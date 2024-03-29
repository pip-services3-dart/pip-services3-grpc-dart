import 'package:pip_services3_commons/pip_services3_commons.dart';

import './GrpcService.dart';

/// Abstract service that receives commands via GRPC protocol
/// to operations automatically generated for commands defined in [ICommandable components](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/ICommandable-class.html).
/// Each command is exposed as invoke method that receives command name and parameters.
///
/// Commandable services require only 3 lines of code to implement a robust external
/// GRPC-based remote interface.
///
/// ### Configuration parameters ###
///
/// - [dependencies]:
///   - [endpoint]:              override for HTTP Endpoint dependency
///   - [controller]:            override for Controller dependency
/// - [connection(s)]:
///   - [discovery_key]:         (optional) a key to retrieve the connection from [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html)
///   - [protocol]:              connection protocol: http or https
///   - [host]:                  host name or IP address
///   - [port]:                  port number
///   - [uri]:                   resource URI or connection string with all parameters in it
///
/// ### References ###
///
/// - *:logger:*:*:1.0               (optional) [ILogger](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ILogger-class.html) components to pass log messages
/// - *:counters:*:*:1.0             (optional) [ICounters](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ICounters-class.html) components to pass collected measurements
/// - *:discovery:*:*:1.0            (optional) [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html) services to resolve connection
/// - *:endpoint:grpc:*:1.0          (optional) [GrpcEndpoint] reference
///
/// See [CommandableGrpcClient]
/// See [GrpcService]
///
/// ### Example ###
///
///     class MyCommandableGrpcService extends CommandableGrpcService {
///        MyCommandableGrpcService():super('mydata') {
///           _dependencyResolver.put(
///               "controller",
///               Descriptor("mygroup","controller","*","*","1.0")
///           );
///        }
///     }
///
///     var service = MyCommandableGrpcService();
///     service.configure(ConfigParams.fromTuples([
///         "connection.protocol", "http",
///         "connection.host", "localhost",
///         "connection.port", 8080
///     ]));
///     service.setReferences(References.fromTuples([
///         Descriptor("mygroup","controller","default","default","1.0"), controller
///     ]));
///
///     await service.open("123");
///     print("The GRPC service is running on port 8080");
///

abstract class CommandableGrpcService with GrpcService {
  final String _name;
  CommandSet? _commandSet;

  /// Creates a new instance of the service.
  ///
  /// - [name] a service name.
  CommandableGrpcService(String name) : _name = name {
    dependencyResolver.put('controller', 'none');
  }

  /// Registers all service routes in gRPC endpoint.
  /// Call automaticaly in open component procedure
  @override
  void register() {
    var controller =
        dependencyResolver.getOneRequired<ICommandable>('controller');
    _commandSet = controller.getCommandSet();

    var commands = _commandSet!.getCommands();
    for (var index = 0; index < commands.length; index++) {
      var command = commands[index];

      var method = '' + _name + '.' + command.getName();

      registerCommadableMethod(method, null,
          (String? correlationId, Parameters args) async {
        var timing = instrument(correlationId, method);
        try {
          var result = await command.execute(correlationId, args);
          return result;
        } catch (err) {
          timing.endFailure(err as Exception);
        } finally {
          timing.endTiming();
        }
      });
    }
  }
}
