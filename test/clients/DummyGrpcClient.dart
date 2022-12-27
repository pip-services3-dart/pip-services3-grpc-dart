import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../generated/dummies.pbgrpc.dart' as messages;

import 'package:pip_services3_grpc/src/clients/GrpcClient.dart';
import './IDummyClient.dart';
import '../Dummy.dart';

class DummyGrpcClient extends GrpcClient implements IDummyClient {
  DummyGrpcClient() : super('dummies.Dummies');

  @override
  Future<DataPage<Dummy>?> getDummies(
      String? correlationId, FilterParams? filter, PagingParams? paging) async {
    var request = messages.DummiesPageRequest();
    request.correlationId = correlationId ?? '';
    if (filter != null) {
      filter.entries.forEach((element) {
        request.filter.addAll({element.key: element.value ?? ''});
      });
    }
    if (paging != null) {
      var params = messages.PagingParams();
      params.total = paging.total;
      params.skip += paging.skip ?? 0;
      params.take = paging.take ?? 0;
      request.paging = params;
    }

    instrument(correlationId, 'dummy.get_page_by_filter');

    var response =
        await call<messages.DummiesPageRequest, messages.DummiesPage>(
            'get_dummies', correlationId, request);
    var items = <Dummy>[];
    for (var item in response.data) {
      items.add(Dummy.fromGrpcJson(item.writeToJsonMap()));
    }
    return DataPage(items, response.total.toInt());
  }

  @override
  Future<Dummy?> getDummyById(String? correlationId, String dummyId) async {
    var request = messages.DummyIdRequest();
    request.dummyId = dummyId;

    instrument(correlationId, 'dummy.get_one_by_id');

    var response = await call<messages.DummyIdRequest, messages.Dummy>(
        'get_dummy_by_id', correlationId, request);

    var result = Dummy.fromGrpcJson(response.writeToJsonMap());
    if (result != null && (result.id == null) && result.key == null) {
      return null;
    }
    return result;
  }

  @override
  Future<Dummy?> createDummy(String? correlationId, Dummy dummy) async {
    var request = messages.DummyObjectRequest();
    request.correlationId = correlationId ?? '';
    var item = messages.Dummy();
    item.mergeFromJsonMap(dummy.toGrpcJson());
    request.dummy = item;

    instrument(correlationId, 'dummy.create');

    var response = await call<messages.DummyObjectRequest, messages.Dummy>(
        'create_dummy', correlationId, request);

    var result = Dummy.fromGrpcJson(response.writeToJsonMap());
    if (result != null && (result.id == null) && result.key == null) {
      return null;
    }
    return result;
  }

  @override
  Future<Dummy?> updateDummy(String? correlationId, Dummy dummy) async {
    var request = messages.DummyObjectRequest();
    request.correlationId = correlationId ?? '';
    var item = messages.Dummy();
    item.mergeFromJsonMap(dummy.toGrpcJson());
    request.dummy = item;

    instrument(correlationId, 'dummy.update');

    var response = await call<messages.DummyObjectRequest, messages.Dummy>(
        'update_dummy', correlationId, request);

    var result = Dummy.fromGrpcJson(response.writeToJsonMap());
    if (result != null && (result.id == null) && result.key == null) {
      return null;
    }
    return result;
  }

  @override
  Future<Dummy?> deleteDummy(String? correlationId, String dummyId) async {
    var request = messages.DummyIdRequest();
    request.dummyId = dummyId;

    instrument(correlationId, 'dummy.delete_by_id');

    var response = await call<messages.DummyIdRequest, messages.Dummy>(
        'delete_dummy_by_id', correlationId, request);

    var result = Dummy.fromGrpcJson(response.writeToJsonMap());
    if (result != null && (result.id == null) && result.key == null) {
      return null;
    }
    return result;
  }
}
