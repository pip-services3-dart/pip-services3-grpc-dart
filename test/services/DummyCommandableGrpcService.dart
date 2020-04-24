import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_grpc/pip_services3_grpc.dart';

class DummyCommandableGrpcService extends CommandableGrpcService {
  DummyCommandableGrpcService() : super('dummy') {
    dependencyResolver.put('controller',
        Descriptor('pip-services-dummies', 'controller', 'default', '*', '*'));
  }
}
