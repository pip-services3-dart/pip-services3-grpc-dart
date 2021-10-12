import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../DummyController.dart';
import '../services/DummyCommandableGrpcService.dart';
import './DummyCommandableGrpcClient.dart';
import './DummyClientFixture.dart';

var grpcConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3002
]);

void main() {
  group('DummyCommandableGrpcClient', () {
    late DummyCommandableGrpcService service;
    late DummyClientFixture fixture;
    DummyCommandableGrpcClient client;

    setUpAll(() async {
      var ctrl = DummyController();

      service = DummyCommandableGrpcService();
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
      client = DummyCommandableGrpcClient();
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
