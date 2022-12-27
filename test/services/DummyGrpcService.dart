import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_grpc/pip_services3_grpc.dart';
import 'package:protobuf/protobuf.dart';

import '../generated/dummies.pbgrpc.dart' as command;

import '../DummySchema.dart';
import '../Dummy.dart';
import '../IDummyController.dart';

class DummyGrpcService extends command.DummiesServiceBase with GrpcService {
  IDummyController? _controller;
  int _numberOfCalls = 0;

  DummyGrpcService() {
    serviceName = 'dummies.Dummies.service';
    dependencyResolver.put('controller',
        Descriptor('pip-services-dummies', 'controller', 'default', '*', '*'));
  }

  @override
  void setReferences(IReferences references) {
    super.setReferences(references);
    _controller =
        dependencyResolver.getOneRequired<IDummyController>('controller');
  }

  int getNumberOfCalls() {
    return _numberOfCalls;
  }

  FutureOr<GrpcError?> _incrementNumberOfCalls(
      ServiceCall call, ServiceMethod method) async {
    _numberOfCalls++;
    // return GrpcError.ok();
    return null;
  }

  @override
  void register() {
    registerInterceptor(_incrementNumberOfCalls);
    registerService(this);
  }

  @override
  Future<command.Dummy> create_dummy(
      ServiceCall call, command.DummyObjectRequest request) async {
    var schema =
        ObjectSchema(true).withRequiredProperty('dummy', DummySchema());
    var correlationId = request.correlationId;
    var err = schema.validateAndReturnException(correlationId, request, false);

    if (err != null) {
      throw err;
    }

    var response = command.Dummy();
    var timing = instrument(correlationId, 'create_dummy.call');
    try {
      var dummy = Dummy.fromGrpcJson(request.dummy.writeToJsonMap());
      var result = await _controller!.create(request.correlationId, dummy);
      if (result != null) {
        response.mergeFromJsonMap(result.toGrpcJson());
      }
    } catch (ex) {
      var err = ApplicationException().wrap(ex);
      timing.endFailure(err);
    } finally {
      timing.endTiming();
    }
    return response;
  }

  @override
  Future<command.Dummy> delete_dummy_by_id(
      ServiceCall call, command.DummyIdRequest request) async {
    var schema =
        ObjectSchema(true).withRequiredProperty('dummyId', TypeCode.String);
    var correlationId = request.correlationId;
    var err = schema.validateAndReturnException(correlationId, request, false);

    if (err != null) {
      throw err;
    }
    var response = command.Dummy();
    var timing = instrument(correlationId, 'delete_dummy_by_id.call');
    try {
      var result =
          await _controller!.deleteById(request.correlationId, request.dummyId);
      if (result != null) {
        response.mergeFromJsonMap(result.toGrpcJson());
      }
    } catch (ex) {
      var err = ApplicationException().wrap(ex);

      timing.endFailure(err);
    } finally {
      timing.endTiming();
    }
    return response;
  }

  @override
  Future<command.DummiesPage> get_dummies(
      ServiceCall call, command.DummiesPageRequest request) async {
    //TODO: Fix schema checks for PagingParams
    // var schema = ObjectSchema(true)
    //     .withOptionalProperty('paging', PagingParamsSchema())
    //     .withOptionalProperty('filter', FilterParamsSchema());
    var correlationId = request.correlationId;
    // var err = schema.validateAndReturnException(correlationId, request, false);

    // if (err != null) {
    //   throw err;
    // }

    var filter = FilterParams.fromValue(request.filter);
    var paging = PagingParams.fromValue(request.paging);
    var response = command.DummiesPage();

    var timing = instrument(correlationId, 'get_dummies.call');
    try {
      var result =
          await _controller!.getPageByFilter(correlationId, filter, paging);
      var list = PbList<command.Dummy>();
      for (var item in result.data) {
        var cmdDummyItem = command.Dummy();
        cmdDummyItem.mergeFromJsonMap(item.toGrpcJson());
        list.add(cmdDummyItem);
      }
      // Hack for set total value
      response.total += result.total;
      response.data.addAll(list);
    } catch (ex) {
      var err = ApplicationException().wrap(ex);
      timing.endFailure(err);
    } finally {
      timing.endTiming();
    }
    return response;
  }

  @override
  Future<command.Dummy> get_dummy_by_id(
      ServiceCall call, command.DummyIdRequest request) async {
    var schema =
        ObjectSchema(true).withRequiredProperty('dummyId', TypeCode.String);
    var correlationId = request.correlationId;
    var err = schema.validateAndReturnException(correlationId, request, false);

    if (err != null) {
      throw err;
    }

    var response = command.Dummy();
    var timing = instrument(correlationId, 'get_dummy_by_id.call');
    try {
      var result =
          await _controller!.getOneById(request.correlationId, request.dummyId);
      if (result != null) {
        response.mergeFromJsonMap(result.toGrpcJson());
      }
    } catch (ex) {
      var err = ApplicationException().wrap(ex);
      timing.endFailure(err);
    } finally {
      timing.endTiming();
    }

    return response;
  }

  @override
  Future<command.Dummy> update_dummy(
      ServiceCall call, command.DummyObjectRequest request) async {
    // 'update_dummy',
    var schema =
        ObjectSchema(true).withRequiredProperty('dummy', DummySchema());
    var correlationId = request.correlationId;
    var err = schema.validateAndReturnException(correlationId, request, false);

    if (err != null) {
      throw err;
    }
    var response = command.Dummy();
    var timing = instrument(correlationId, 'update_dummy.call');
    try {
      var dummy = Dummy.fromGrpcJson(request.dummy.writeToJsonMap());
      var result = await _controller!.update(request.correlationId, dummy);
      response.mergeFromJsonMap(result!.toGrpcJson());
    } catch (ex) {
      var err = ApplicationException().wrap(ex);
      timing.endFailure(err);
    } finally {
      timing.endTiming();
    }

    return response;
  }
}
