import 'dart:async';
import 'dart:convert';

import './GrpcClient.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../generated/commandable.pbgrpc.dart' as command;

/// Abstract client that calls commandable GRPC service.
///
/// Commandable services are generated automatically for [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/commands.icommandable.html ICommandable objects]].
/// Each command is exposed as Invoke method that receives all parameters as args.
///
/// ### Configuration parameters ###
///
/// - [connection(s)]:
///   - [discovery_key]:         (optional) a key to retrieve the connection from [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/connect.idiscovery.html IDiscovery]]
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
/// - *:logger:*:*:1.0         (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/log.ilogger.html ILogger]] components to pass log messages
/// - *:counters:*:*:1.0         (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/count.icounters.html ICounters]] components to pass collected measurements
/// - *:discovery:*:*:1.0        (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/connect.idiscovery.html IDiscovery]] services to resolve connection
///
/// ### Example ###
///
///     class MyCommandableGrpcClient extends CommandableGrpcClient implements IMyClient {
///        ...
///
///         public getData(String correlationId, id: string,
///            callback: (err: any, result: MyData) => void): void {
///
///            this.callCommand(
///                'get_data',
///                correlationId,
///                { id: id },
///                (err, result) => {
///                    callback(err, result);
///                }
///             );
///         }
///         ...
///     }
///
///     var client = new MyCommandableGrpcClient();
///     client.configure(ConfigParams.fromTuples(
///         'connection.protocol', 'http',
///         'connection.host', 'localhost',
///         'connection.port', 8080
///     ));
///
///     client.getData('123', '1', (err, result) => {
///     ...
///     });

class CommandableGrpcClient extends GrpcClient {
  /// The service name
  String name;

  /// Creates a new instance of the client.
  ///
  /// - [name]     a service name.
  CommandableGrpcClient(String name) : super('commandable.Commandable') {
    this.name = name;
  }

  /// Calls a remote method via GRPC commadable protocol.
  /// The call is made via Invoke method and all parameters are sent in args object.
  /// The complete route to remote method is defined as serviceName + '.' + name.
  ///
  /// - [name]              a name of the command to call.
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [params]            command parameters.
  /// Returns               Future that receives result
  /// Throws error.

  Future callCommand(String name, String correlationId, params) async {
    var method = this.name + '.' + name;
    var timing = instrument(correlationId, method);

    var request = command.InvokeRequest();

    request.method = method;
    request.correlationId = correlationId;
    request.argsEmpty = params == null;
    request.argsJson = params != null ? json.encode(params) : '';

    try {
      var response = await call<command.InvokeRequest, command.InvokeReply>(
          'invoke', correlationId, request);
      timing.endTiming();
      // Handle error response
      if (response.error != null &&
          response.error.writeToJsonMap().isNotEmpty) {
        var err = ErrorDescription();
        err.category = response.error.category;
        err.code = response.error.code;
        err.correlation_id = response.error.correlationId;
        err.status = response.error.status;
        err.message = response.error.message;
        err.cause = response.error.cause;
        err.stack_trace = response.error.stackTrace;
        err.details.addAll(response.error.details);
        throw ApplicationExceptionFactory.create(err);
      }

      // Handle empty response
      if (response.resultEmpty ||
          response.resultJson == '' ||
          response.resultJson == null) {
        return null;
      }

      // Handle regular response
      return json.decode(response.resultJson);
    } catch (ex) {
      timing.endTiming();
      // Handle unexpected error
      var err = ex;
      if (!(ex is ApplicationException)) {
        err = ApplicationException().wrap(ex);
      }
      instrumentError(correlationId, method, err, true);
    }
  }
}
