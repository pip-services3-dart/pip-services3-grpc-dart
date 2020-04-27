import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../DummyController.dart';
import '../services/DummyGrpcService.dart';
import './DummyGrpcClient.dart';
import './DummyClientFixture.dart';

void main() {
  var grpcConfig = ConfigParams.fromTuples([
    'connection.protocol',
    'http',
    'connection.host',
    'localhost',
    'connection.port',
    3000
  ]);

  group('DummyGrpcClient', () {
    DummyGrpcService service;
    DummyGrpcClient client;
    DummyClientFixture fixture;

    setUpAll(() async {
      var ctrl = DummyController();

      service = DummyGrpcService();
      service.configure(grpcConfig);

      var references = References.fromTuples([
        Descriptor(
            'pip-services-dummies', 'controller', 'default', 'default', '1.0'),
        ctrl,
        Descriptor('pip-services-dummies', 'service', 'grpc', 'default', '1.0'),
        service
      ]);
      service.setReferences(references);

      await service.open(null);
    });

    tearDownAll(() async {
      await service.close(null);
    });

    setUp(() async {
      client = DummyGrpcClient();
      fixture = DummyClientFixture(client);

      client.configure(grpcConfig);
      client.setReferences(References());
      await client.open(null);
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
