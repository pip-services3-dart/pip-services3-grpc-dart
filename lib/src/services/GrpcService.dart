import 'dart:async';

import 'package:grpc/grpc.dart' as grpc;
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import './GrpcEndpoint.dart';
import './IRegisterable.dart';

/// Abstract service that receives remove calls via GRPC protocol.
///
/// ### Configuration parameters ###
///
/// - [dependencies]:
///   - [endpoint]:              override for GRPC Endpoint dependency
///   - [controller]:            override for Controller dependency
/// - [connection(s)]:
///   - [discovery_key]:         (optional) a key to retrieve the connection from [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html)
///   - [protocol]:              connection protocol: http or https
///   - [host]:                  host name or IP address
///   - [port]:                  port number
///   - [uri]:                   resource URI or connection string with all parameters in it
/// - [credential] - the HTTPS credentials:
///   - [ssl_key_file]:         the SSL private key in PEM
///   - [ssl_crt_file]:         the SSL certificate in PEM
///   - [ssl_ca_file]:          the certificate authorities (root cerfiticates) in PEM
///
/// ### References ###
///
/// - \*:logger:\*:\*:1.0               (optional) [ILogger](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ILogger-class.html) components to pass log messages
/// - \*:counters:\*:\*:1.0             (optional) [ICounters](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ICounters-class.html) components to pass collected measurements
/// - \*:discovery:\*:\*:1.0            (optional) [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html) services to resolve connection
/// - \*:endpoint:grpc:\*:1.0           (optional) [GrpcEndpoint] reference
///
/// See [GrpcClient]
///
/// ### Example ###
///
///     class MyGrpcService extends MyDataGrpcServiceBase with GrpcService {
///         IMyController _controller;
///        ...
///        MyGrpcService() {
///           serviceName = '.. service name ...';
///           dependencyResolver.put(
///               'controller',
///               Descriptor('mygroup','controller','*','*','1.0')
///           );
///        }
///
///        void setReferences(IReferences references) {
///           base.setReferences(references);
///           _controller = dependencyResolver.getRequired<IMyController>('controller');
///        }
///
///        public register() {
///            registerInterceptor(_incrementNumberOfCalls);
///            registerService(this);
///         }
///           Future<grpcService.MyData> getMyData(ServiceCall call, grpcService.MyDataIdRequest request) async{
///                var correlationId = request.correlationId;
///                var id = request.id;
///                var result = await_controller.getMyData(correlationId, id);
///                var item = grpcService.MyData();
///                // ... convert MyData -> grpcService.MyData
///                return item;
///            });
///            ...
///        }
///     }
///
///     var service = MyGrpcService();
///     service.configure(ConfigParams.fromTuples([
///         'connection.protocol', 'http',
///         'connection.host', 'localhost',
///         'connection.port', 8080
///     ]));
///     service.setReferences(References.fromTuples([
///         Descriptor('mygroup','controller','default','default','1.0'), controller
///     ]));
///
///     await service.open('123')
///     print ('The GRPC service is running on port 8080');

mixin GrpcService
    implements
        IOpenable,
        IConfigurable,
        IReferenceable,
        IUnreferenceable,
        IRegisterable {
  static final _defaultConfig = ConfigParams.fromTuples(
      ['dependencies.endpoint', '*:endpoint:grpc:*:1.0']);

  String _serviceName;
  ConfigParams _config;
  IReferences _references;
  bool _localEndpoint = false;
  IRegisterable _registerable;
  bool _opened = false;

  /// The GRPC endpoint that exposes this service.
  GrpcEndpoint endpoint;

  /// The dependency resolver.
  final dependencyResolver = DependencyResolver(GrpcService._defaultConfig);

  /// The logger.
  final logger = CompositeLogger();

  /// The performance counters.
  final counters = CompositeCounters();

  /// Sets service name
  /// - [name]  name of service
  set serviceName(String name) {
    _serviceName = name;
  }

  /// Configures component by passing configuration parameters.
  ///
  /// - [config]    configuration parameters to be set.
  @override
  void configure(ConfigParams config) {
    config = config.setDefaults(GrpcService._defaultConfig);
    _config = config;
    dependencyResolver.configure(config);
  }

  /// Sets references to dependent components.
  ///
  /// - [references] 	references to locate the component dependencies.
  @override
  void setReferences(IReferences references) {
    _references = references;

    logger.setReferences(references);
    counters.setReferences(references);
    dependencyResolver.setReferences(references);

    // Get endpoint
    endpoint = dependencyResolver.getOneOptional<GrpcEndpoint>('endpoint');
    // Or create a local one
    if (endpoint == null) {
      endpoint = _createEndpoint();
      _localEndpoint = true;
    } else {
      _localEndpoint = false;
    }
    // Add registration callback to the endpoint
    endpoint.register(this);
  }

  /// Unsets (clears) previously set references to dependent components.
  @override
  void unsetReferences() {
    // Remove registration callback from endpoint
    if (endpoint != null) {
      endpoint.unregister(_registerable);
      endpoint = null;
    }
  }

  GrpcEndpoint _createEndpoint() {
    var endpoint = GrpcEndpoint();
    if (_config != null) {
      endpoint.configure(_config);
    }
    if (_references != null) {
      endpoint.setReferences(_references);
    }
    return endpoint;
  }

  /// Adds instrumentation to log calls and measure call time.
  /// It returns a Timing object that is used to end the time measurement.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [name]              a method name.
  /// Returns Timing object to end the time measurement.
  Timing instrument(String correlationId, String name) {
    logger.trace(correlationId, 'Executing %s method', [name]);
    counters.incrementOne(name + '.exec_count');
    return counters.beginTiming(name + '.exec_time');
  }

  /// Adds instrumentation to error handling.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [name]              a method name.
  /// - [err]               an occured error
  /// - [reerror]           if true - throw error
  void instrumentError(String correlationId, String name, err,
      [bool reerror = false]) {
    if (err != null) {
      logger.error(correlationId, err, 'Failed to execute %s method', [name]);
      counters.incrementOne(name + '.exec_errors');
      if (reerror != null && reerror == true) {
        throw err;
      }
    }
  }

  /// Checks if the component is opened.
  ///
  /// Returns true if the component has been opened and false otherwise.
  @override
  bool isOpen() {
    return _opened;
  }

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives  null no errors occured.
  /// Throws error
  @override
  Future open(String correlationId) async {
    if (_opened) {
      return null;
    }

    if (endpoint == null) {
      endpoint = _createEndpoint();
      endpoint.register(this);
      _localEndpoint = true;
    }

    if (_localEndpoint) {
      await endpoint.open(correlationId);
    }
    _opened = true;
  }

  /// Closes component and frees used resources.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			      Future that receives error or null no errors occured.
  @override
  Future close(String correlationId) async {
    if (!_opened) {
      return null;
    }

    if (endpoint == null) {
      throw InvalidStateException(
          correlationId, 'NO_ENDPOINT', 'HTTP endpoint is missing');
    }

    if (_localEndpoint) {
      await endpoint.close(correlationId);
    }
    _opened = false;
  }

  /// Registers a commandable method in this objects GRPC server (service) by the given name.,
  ///
  /// - [method]        the GRPC method name.
  /// - [schema]        the schema to use for parameter validation.
  /// - [action]        the action to perform at the given route.
  void registerCommadableMethod(String method, Schema schema,
      Future<dynamic> Function(String correlationId, Parameters args) action) {
    endpoint.registerCommadableMethod(method, schema, action);
  }

  /// Registers a middleware for methods in GRPC endpoint.
  ///
  /// - [action]        an action function that is called when middleware is invoked.
  void registerInterceptor(grpc.Interceptor action) {
    if (endpoint != null) {
      endpoint.registerInterceptor(action);
    }
  }

  /// Registers a service with related implementation
  ///
  /// - [implementation] a GRPC service object with service implementation methods.
  void registerService(grpc.Service implementation) {
    if (endpoint != null) {
      endpoint.registerService(implementation);
    }
  }

  /// Registers all service routes in Grpc endpoint.
  ///
  /// This method is called by the service and must be overriden
  /// in child classes.
  @override
  void register();
}
