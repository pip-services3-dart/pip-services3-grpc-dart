import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart' as grpc;
import 'package:protobuf/protobuf.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

/// Abstract client that calls remove endpoints using GRPC protocol.
///
/// ### Configuration parameters ###
///
/// - [connection(s)]:
///   - [discovery_key]:         (optional) a key to retrieve the connection from [IDiscovery]
///   - [protocol]:              connection protocol: http or https
///   - [host]:                  host name or IP address
///   - [port]:                  port number
///   - [uri]:                   resource URI or connection string with all parameters in it
/// - [options]:
///   - [retries]:               number of retries (default: 3)
///   - [connect_timeout]:       connection timeout in milliseconds (default: 10 sec)
///   - [timeout]:               invocation timeout in milliseconds (default: 10 sec)
///
/// ### References ###
///
/// - *:logger:*:*:1.0         (optional) [ILogger] components to pass log messages
/// - *:counters:*:*:1.0         (optional) [ICounters] components to pass collected measurements
/// - *:discovery:*:*:1.0        (optional) [IDiscovery] services to resolve connection
///
/// See [GrpcService]
/// See [CommandableHttpService]
///
/// ### Example ###
///
///     class MyGrpcClient extends GrpcClient implements IMyClient {
///        ...
///
///        Future<MyData> getData(String correlationId, string id) async {
///
///            var timing = this.instrument(correlationId, 'myclient.get_data');
///            var request = MyDataRequest();
///            request.id = id;
///            var response = await call<MydataRequest,MyDataResponse>('get_data', correlationId, request)
///            timing.endTiming();
///            MyData item;
///            ///... convert MyDataResponse to MyData
///            return item;
///        }
///        ...
///     }
///
///     var client = MyGrpcClient();
///     client.configure(ConfigParams.fromTuples([
///         'connection.protocol', 'http',
///         'connection.host', 'localhost',
///         'connection.port', 8080
///     ]));
///
///     var item = await client.getData('123', '1')
///       ...

abstract class GrpcClient implements IOpenable, IConfigurable, IReferenceable {
  static final _defaultConfig = ConfigParams.fromTuples([
    'connection.protocol',
    'http',
    'connection.host',
    '0.0.0.0',
    'connection.port',
    3000,
    'options.request_max_size',
    1024 * 1024,
    'options.connect_timeout',
    10000,
    'options.timeout',
    10000,
    'options.retries',
    3,
    'options.debug',
    true
  ]);

  String _clientName;

  /// The GRPC client chanel
  grpc.ClientChannel _channel;

  /// The connection resolver.
  final _connectionResolver = HttpConnectionResolver();

  /// The logger.
  final _logger = CompositeLogger();

  /// The performance counters.
  final _counters = CompositeCounters();

  /// The configuration options.
  var _options = ConfigParams();

  /// The connection timeout in milliseconds.
  int _connectTimeout = 10000;

  /// The invocation timeout in milliseconds.
  int _timeout = 10000;

  /// The remote service uri which is calculated on open.
  String _uri;

  GrpcClient(String clientName) {
    _clientName = clientName;
  }

  /// Configures component by passing configuration parameters.
  ///
  /// - [config]    configuration parameters to be set.
  @override
  void configure(ConfigParams config) {
    config = config.setDefaults(GrpcClient._defaultConfig);
    _connectionResolver.configure(config);
    _options = _options.override(config.getSection('options'));

    _connectTimeout = config.getAsIntegerWithDefault(
        'options.connect_timeout', _connectTimeout);
    _timeout = config.getAsIntegerWithDefault('options.timeout', _timeout);
  }

  /// Sets references to dependent components.
  ///
  /// - [references] 	references to locate the component dependencies.
  @override
  void setReferences(IReferences references) {
    _logger.setReferences(references);
    _counters.setReferences(references);
    _connectionResolver.setReferences(references);
  }

  /// Adds instrumentation to log calls and measure call time.
  /// It returns a Timing object that is used to end the time measurement.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [name]              a method name.
  /// Returns Timing object to end the time measurement.
  Timing instrument(String correlationId, String name) {
    _logger.trace(correlationId, 'Executing %s method', [name]);
    _counters.incrementOne(name + '.call_count');
    return _counters.beginTiming(name + '.call_time');
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
      _logger.error(correlationId, err, 'Failed to call %s method', [name]);
      _counters.incrementOne(name + '.call_errors');
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
    return _channel != null;
  }

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			      Future that receives error or null no errors occured.
  @override
  Future open(String correlationId) async {
    if (isOpen()) {
      return null;
    }

    try {
      var connection = await _connectionResolver.resolve(correlationId);
      _uri = connection.getUri();

      grpc.ChannelCredentials credentials;
      if (connection.getProtocol('http') == 'https') {
        var sslCaFile = connection.getAsNullableString('ssl_ca_file');
        List<int> trustedRoot = File(sslCaFile).readAsBytesSync();
        credentials = grpc.ChannelCredentials.secure(
            certificates: trustedRoot, authority: connection.getHost());
      } else {
        credentials = const grpc.ChannelCredentials.insecure();
      }

      final options = grpc.ChannelOptions(
          credentials: credentials,
          connectionTimeout: Duration(milliseconds: _connectTimeout),
          idleTimeout: Duration(milliseconds: _timeout));
      _channel = grpc.ClientChannel(connection.getHost(),
          port: connection.getPort(), options: options);
    } catch (ex) {
      _channel = null;
      throw ConnectionException(
              correlationId, 'CANNOT_CONNECT', 'Opening GRPC client failed')
          .wrap(ex)
          .withDetails('url', _uri);
    }
  }

  /// Closes component and frees used resources.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives error or null no errors occured.
  @override
  Future close(String correlationId) async {
    if (_channel != null) {
      // Eat exceptions
      try {
        _logger.debug(correlationId, 'Closed GRPC service at %s', [_uri]);
      } catch (ex) {
        _logger.warn(
            correlationId, 'Failed while closing GRPC service: %s', ex);
      }
      _channel = null;
      _uri = null;
    }
  }

  /// Calls a remote method via GRPC protocol.
  ///
  /// - [method]            a method name to called
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [request]           (optional) request object.
  /// Return                (optional) Future that receives result object or error.
  grpc.ResponseFuture<R>
      call<Q extends GeneratedMessage, R extends GeneratedMessage>(
          String method, String correlationId, Q request,
          {grpc.CallOptions options}) {
    method = method.toLowerCase();
    method = '/' + _clientName + '/' + method;

    final _options = grpc.CallOptions();
    final clientMethod = grpc.ClientMethod<Q, R>(
        method, (Q value) => value.writeToBuffer(), (List<int> value) {
      //TODO: make a decision is it right or not?
      R item = TypeReflector.createInstanceByType(R, []);
      item.mergeFromBuffer(value);
      return item;
    });

    final call = _channel.createCall(clientMethod,
        Stream.fromIterable([request]), _options.mergedWith(options));
    return grpc.ResponseFuture(call);
  }

  /// AddFilterParams method are adds filter parameters (with the same name as they defined)
  /// to invocation parameter map.
  ///  - [params]        invocation parameters.
  ///  - [filter]        (optional) filter parameters
  /// Return invocation parameters with added filter parameters.
  StringValueMap addFilterParams(StringValueMap params, FilterParams filter) {
    params ??= StringValueMap();

    if (filter != null) {
      for (var k in filter.keys) {
        params.put(k, filter[k]);
      }
    }
    return params;
  }

  /// AddPagingParams method are adds paging parameters (skip, take, total) to invocation parameter map.
  /// - [params]        invocation parameters.
  /// - [paging]        (optional) paging parameters
  /// Return invocation parameters with added paging parameters.
  StringValueMap addPagingParams(StringValueMap params, PagingParams paging) {
    params ??= StringValueMap();

    if (paging != null) {
      params.put('total', paging.total);
      if (paging.skip != null) {
        params.put('skip', paging.skip);
      }
      if (paging.take != null) {
        params.put('take', paging.take);
      }
    }
    return params;
  }
}
