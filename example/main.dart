import 'package:pip_services3_commons/pip_services3_commons.dart';

import './DummyController.dart';
import './services/DummyCommandableGrpcService.dart';
import './clients/DummyCommandableGrpcClient.dart';
import './Dummy.dart';

var grpcConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3002
]);

void main() async {
  DummyCommandableGrpcService service;
  DummyCommandableGrpcClient client;

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
  await service.open('123');

  client = DummyCommandableGrpcClient();

  client.configure(grpcConfig);
  client.setReferences(References());
  await client.open('123');
//----------------------------------------------
  var dummy1 = Dummy(id: '', key: 'Key 1', content: 'Content 1');

  // Create one dummy
  var dummy = await client.createDummy('123', dummy1);

  // Get all dummies
  var dummies =
      await client.getDummies('123', FilterParams(), PagingParams(0, 5, false));

  // Update the dummy
  dummy!.content = 'Updated Content 1';
  dummy = await client.updateDummy('123', dummy);

  // Delete dummy
  await client.deleteDummy('123', dummy1.id!);

  // Try to get delete dummy
  dummy = await client.getDummyById('123', dummy1.id!);

//----------------------------------------------
  await client.close('123');
  await service.close('123');
}
