//  @module clients 
// import { GrpcClient } from './GrpcClient';

// import { ApplicationExceptionFactory } from 'pip-services3-commons-node';

// 
// /// Abstract client that calls commandable GRPC service.
// /// 
// /// Commandable services are generated automatically for [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/commands.icommandable.html ICommandable objects]].
// /// Each command is exposed as Invoke method that receives all parameters as args.
// /// 
// /// ### Configuration parameters ###
// /// 
// /// - connection(s):           
// ///   - discovery_key:         (optional) a key to retrieve the connection from [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/connect.idiscovery.html IDiscovery]]
// ///   - protocol:              connection protocol: http or https
// ///   - host:                  host name or IP address
// ///   - port:                  port number
// ///   - uri:                   resource URI or connection string with all parameters in it
// /// - options:
// ///   - retries:               number of retries (default: 3)
// ///   - connect_timeout:       connection timeout in milliseconds (default: 10 sec)
// ///   - timeout:               invocation timeout in milliseconds (default: 10 sec)
// /// 
// /// ### References ###
// /// 
// /// - \*:logger:\*:\*:1.0         (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/log.ilogger.html ILogger]] components to pass log messages
// /// - \*:counters:\*:\*:1.0         (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/count.icounters.html ICounters]] components to pass collected measurements
// /// - \*:discovery:\*:\*:1.0        (optional) [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/interfaces/connect.idiscovery.html IDiscovery]] services to resolve connection
// /// 
// /// ### Example ###
// /// 
// ///     class MyCommandableGrpcClient extends CommandableGrpcClient implements IMyClient {
// ///        ...
// /// 
// ///         public getData(String correlationId, id: string, 
// ///            callback: (err: any, result: MyData) => void): void {
// ///        
// ///            this.callCommand(
// ///                "get_data",
// ///                correlationId,
// ///                { id: id },
// ///                (err, result) => {
// ///                    callback(err, result);
// ///                }
// ///             );        
// ///         }
// ///         ...
// ///     }
// /// 
// ///     let client = new MyCommandableGrpcClient();
// ///     client.configure(ConfigParams.fromTuples(
// ///         "connection.protocol", "http",
// ///         "connection.host", "localhost",
// ///         "connection.port", 8080
// ///     ));
// /// 
// ///     client.getData("123", "1", (err, result) => {
// ///     ...
// ///     });
//  
// export class CommandableGrpcClient extends GrpcClient {
//     
//     /// The service name
//      
//     protected _name: string;

//     
//     /// Creates a new instance of the client.
//     /// 
//     /// - name     a service name. 
//      
//     public constructor(name: string) {
//         super(__dirname + "../../../../src/protos/commandable.proto", "commandable.Commandable");
//         this._name = name;
//     }

//     
//     /// Calls a remote method via GRPC commadable protocol.
//     /// The call is made via Invoke method and all parameters are sent in args object.
//     /// The complete route to remote method is defined as serviceName + "." + name.
//     /// 
//     /// - name              a name of the command to call. 
//     /// - correlationId     (optional) transaction id to trace execution through call chain.
//     /// - params            command parameters.
//     /// - callback          callback function that receives result or error.
//      
//     public callCommand(name: string, String correlationId, params: any, callback: (err: any, result: any) => void): void {
//         let method = this._name + '.' + name;
//         let timing = this.instrument(correlationId, method);

//         let request = {
//             method: method,
//             correlation_id: correlationId,
//             args_empty: params == null,
//             args_json: params != null ? JSON.stringify(params) : null
//         };

//         this.call("invoke",
//             correlationId,
//             request,
//             (err, response) => {
//                 timing.endTiming();

//                 // Handle unexpected error
//                 if (err) {
//                     this.instrumentError(correlationId, method, err);
//                     if (callback) callback(err, null);
//                     return;
//                 }

//                 // Handle error response
//                 if (response.error != null) {
//                     let err = ApplicationExceptionFactory.create(response.error);
//                     if (callback) callback(err, null);
//                     return;
//                 }

//                 // Handle empty response
//                 if (response.result_empty || response.result_json == null) {
//                     if (callback) callback(null, null);
//                     return;
//                 }

//                 // Handle regular response
//                 try {
//                     let result = JSON.parse(response.result_json);
//                     if (callback) callback(null, result);
//                 } catch (ex) {
//                     if (callback) callback(ex, null);
//                 }
//             }
//         );
//     }
// }