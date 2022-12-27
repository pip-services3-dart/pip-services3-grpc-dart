import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../Dummy.dart';
import './IDummyClient.dart';

class DummyClientFixture {
  final IDummyClient _client;

  DummyClientFixture(IDummyClient client) : _client = client;

  Future testCrudOperations() async {
    var dummy1 = Dummy(id: '', key: 'Key 1', content: 'Content 1');
    var dummy2 = Dummy(id: '', key: 'Key 2', content: 'Content 2');

    // Create one dummy
    var dummy = await _client.createDummy('123', dummy1);
    expect(dummy, isNotNull);
    expect(dummy!.content, dummy1.content);
    expect(dummy.key, dummy1.key);

    dummy1 = dummy;

    // Create another dummy
    dummy = await _client.createDummy('123', dummy2);
    expect(dummy, isNotNull);
    expect(dummy!.content, dummy2.content);
    expect(dummy.key, dummy2.key);

    dummy2 = dummy;

    // Get all dummies
    var dummies = await _client.getDummies(
        '123', FilterParams(), PagingParams(0, 5, false));
    expect(dummies, isNotNull);
    expect(dummies!.data.length >= 2, isTrue);

    // Update the dummy
    dummy1.content = 'Updated Content 1';
    dummy = await _client.updateDummy('123', dummy1);
    expect(dummy, isNotNull);
    expect(dummy!.content, 'Updated Content 1');
    expect(dummy.key, dummy1.key);

    dummy1 = dummy;

    // Delete dummy
    await _client.deleteDummy('123', dummy1.id!);

    // Try to get delete dummy
    dummy = await _client.getDummyById('123', dummy1.id!);
    expect(dummy, isNull);
  }
}
