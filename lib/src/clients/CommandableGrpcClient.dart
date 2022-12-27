import 'dart:async';
import 'dart:convert';

import './GrpcClient.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../generated/commandable.pbgrpc.dart' as command;

/// Abstract client that calls commandable GRPC service.
///
/// Commandable services are generated automatically for [ICommandable objects](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/ICommandable-class.html).
/// Each command is exposed as Invoke method that receives all parameters as args.
///
/// ### Configuration parameters ###
///
/// - [connection(s)]:
///   - [discovery_key]:         (optional) a key to retrieve the connection from [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html)
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
/// - *:logger:*:*:1.0           (optional) [ILogger](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ILogger-class.html) components to pass log messages
/// - *:counters:*:*:1.0         (optional) [ICounters](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/ICounters-class.html) components to pass collected measurements
/// - *:discovery:*:*:1.0        (optional) [IDiscovery](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/IDiscovery-class.html) services to resolve connection
///
/// ### Example ###
///
///     class MyCommandableGrpcClient extends CommandableGrpcClient implements IMyClient {
///        ...
///
///         Future<MyData> getData(String? correlationId, String id) async {
///
///            var result = await callCommand(
///                'get_data',
///                correlationId,
///                { 'id': id }
///             );
///            var item = MyData()
///            item.fromJson(result);
///            return item;
///         }
///         ...
///     }
///
///     var client = MyCommandableGrpcClient();
///     client.configure(ConfigParams.fromTuples([
///         'connection.protocol', 'http',
///         'connection.host', 'localhost',
///         'connection.port', 8080
///     ]));
///
///     var item = await client.getData('123', '1')
///     ...

class CommandableGrpcClient extends GrpcClient {
  /// The service name
  String _serviceName;

  /// Creates a new instance of the client.
  ///
  /// - [name]     a service name.
  CommandableGrpcClient(String name)
      : _serviceName = name,
        super('commandable.Commandable');

  /// Calls a remote method via GRPC commadable protocol.
  /// The call is made via Invoke method and all parameters are sent in args object.
  /// The complete route to remote method is defined as serviceName + '.' + name.
  ///
  /// - [name]              a name of the command to call.
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [params]            command parameters.
  /// Returns               Future that receives result
  /// Throws error.

  Future callCommand(String name, String? correlationId, params) async {
    var method = _serviceName + '.' + name;
    var timing = instrument(correlationId, method);

    var request = command.InvokeRequest();

    request.method = method;
    request.correlationId = correlationId ?? '';
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
        err.details?.addAll(response.error.details);
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
      // Handle unexpected error
      var err = ex;
      if (!(ex is ApplicationException)) {
        err = ApplicationException().wrap(ex);
      }
      timing.endFailure(err as Exception);
    } finally {
      timing.endSuccess();
    }
  }
}
