import 'package:pip_services3_commons/pip_services3_commons.dart';

import './GrpcService.dart';

/// Abstract service that receives commands via GRPC protocol
/// to operations automatically generated for commands defined in [ICommandable components].
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
///   - [discovery_key]:         (optional) a key to retrieve the connection from [IDiscovery]
///   - [protocol]:              connection protocol: http or https
///   - [host]:                  host name or IP address
///   - [port]:                  port number
///   - [uri]:                   resource URI or connection string with all parameters in it
///
/// ### References ###
///
/// - *:logger:*:*:1.0               (optional) [ILogger] components to pass log messages
/// - *:counters:*:*:1.0             (optional) [ICounters] components to pass collected measurements
/// - *:discovery:*:*:1.0            (optional) [IDiscovery] services to resolve connection
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
  String _name;
  CommandSet _commandSet;

  /// Creates a new instance of the service.
  ///
  /// - [name] a service name.
  CommandableGrpcService(String name) {
    _name = name;
    dependencyResolver.put('controller', 'none');
  }

  /// Registers all service routes in gRPC endpoint.
  /// Call automaticaly in open component procedure
  @override
  void register() {
    var controller =
        dependencyResolver.getOneRequired<ICommandable>('controller');
    _commandSet = controller.getCommandSet();

    var commands = _commandSet.getCommands();
    for (var index = 0; index < commands.length; index++) {
      var command = commands[index];

      var method = '' + _name + '.' + command.getName();

      registerCommadableMethod(method, null,
          (String correlationId, Parameters args) async {
        var timing = instrument(correlationId, method);
        try {
          var result = await command.execute(correlationId, args);
          timing.endTiming();
          return result;
        } catch (err) {
          timing.endTiming();
          instrumentError(correlationId, method, err, true);
        }
      });
    }
  }
}
