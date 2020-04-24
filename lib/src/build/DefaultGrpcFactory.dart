import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../services/GrpcEndpoint.dart';

/// Creates GRPC components by their descriptors.
///
/// See [Factory]
/// See [GrpcEndpoint]
/// See [HeartbeatGrpcService]
/// See [StatusGrpcService]

class DefaultGrpcFactory extends Factory {
  static final descriptor =
      Descriptor('pip-services', 'factory', 'grpc', 'default', '1.0');
  static final GrpcEndpointDescriptor =
      Descriptor('pip-services', 'endpoint', 'grpc', '*', '1.0');
  //  static final StatusServiceDescriptor =  Descriptor('pip-services', 'status-service', 'grpc', '*', '1.0');
  //  static final HeartbeatServiceDescriptor =  Descriptor('pip-services', 'heartbeat-service', 'grpc', '*', '1.0');

  /// Create a new instance of the factory.
  DefaultGrpcFactory() : super() {
    registerAsType(DefaultGrpcFactory.GrpcEndpointDescriptor, GrpcEndpoint);
    // registerAsType(DefaultRpcFactory.HeartbeatServiceDescriptor, HeartbeatGrpcService);
    // registerAsType(DefaultRpcFactory.StatusServiceDescriptor, StatusGrpcService);
  }
}
