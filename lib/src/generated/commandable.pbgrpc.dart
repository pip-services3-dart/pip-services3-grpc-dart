///
//  Generated code. Do not modify.
//  source: commandable.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'commandable.pb.dart' as $0;
export 'commandable.pb.dart';

class CommandableClient extends $grpc.Client {
  static final _$invoke = $grpc.ClientMethod<$0.InvokeRequest, $0.InvokeReply>(
      '/commandable.Commandable/invoke',
      ($0.InvokeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InvokeReply.fromBuffer(value));

  CommandableClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.InvokeReply> invoke($0.InvokeRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$invoke, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class CommandableServiceBase extends $grpc.Service {
  $core.String get $name => 'commandable.Commandable';

  CommandableServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InvokeRequest, $0.InvokeReply>(
        'invoke',
        invoke_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InvokeRequest.fromBuffer(value),
        ($0.InvokeReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.InvokeReply> invoke_Pre(
      $grpc.ServiceCall call, $async.Future<$0.InvokeRequest> request) async {
    return invoke(call, await request);
  }

  $async.Future<$0.InvokeReply> invoke(
      $grpc.ServiceCall call, $0.InvokeRequest request);
}
