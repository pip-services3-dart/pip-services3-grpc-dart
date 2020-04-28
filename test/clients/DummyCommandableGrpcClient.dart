import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services3_grpc/src/clients/CommandableGrpcClient.dart';
import './IDummyClient.dart';
import '../Dummy.dart';

class DummyCommandableGrpcClient extends CommandableGrpcClient
    implements IDummyClient {
  DummyCommandableGrpcClient() : super('dummy');

  @override
  Future<DataPage<Dummy>> getDummies(
      String correlationId, FilterParams filter, PagingParams paging) async {
    var response = await callCommand(
        'get_dummies', correlationId, {'filter': filter, 'paging': paging});
    if (response == null) {
      return null;
    }
    return DataPage<Dummy>.fromJson(response, (item) => Dummy.fromJson(item));
  }

  @override
  Future<Dummy> getDummyById(String correlationId, String dummyId) async {
    var response = await callCommand(
        'get_dummy_by_id', correlationId, {'dummy_id': dummyId});

    if (response == null) {
      return null;
    }
    return Dummy.fromJson(response);
  }

  @override
  Future<Dummy> createDummy(String correlationId, Dummy dummy) async {
    var response =
        await callCommand('create_dummy', correlationId, {'dummy': dummy});
    if (response == null) {
      return null;
    }
    return Dummy.fromJson(response);
  }

  @override
  Future<Dummy> updateDummy(String correlationId, Dummy dummy) async {
    var response =
        await callCommand('update_dummy', correlationId, {'dummy': dummy});
    if (response == null) {
      return null;
    }
    return Dummy.fromJson(response);
  }

  @override
  Future<Dummy> deleteDummy(String correlationId, String dummyId) async {
    var response =
        await callCommand('delete_dummy', correlationId, {'dummy_id': dummyId});
    if (response == null) {
      return null;
    }
    return Dummy.fromJson(response);
  }
}
