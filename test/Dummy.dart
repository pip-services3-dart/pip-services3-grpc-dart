import 'package:pip_services3_commons/pip_services3_commons.dart';

class Dummy implements IStringIdentifiable, ICloneable {
  @override
  String id;
  String key;
  String content;

  Dummy();

  Dummy.from(this.id, this.key, this.content);

  factory Dummy.fromJson(Map<String, dynamic> json) {
    return Dummy.from(json['id'], json['key'], json['content']);
  }

  factory Dummy.fromGrpcJson(Map<String, dynamic> json) {
    return Dummy.from(json['1'], json['2'], json['3']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'key': key, 'content': content};
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    content = json['content'];
  }
  
  // For easy work with grpc
  Map<String, dynamic> toGrpcJson() {
    return <String, dynamic>{'1': id, '2': key, '3': content};
  }

  void fromGrpcJson(Map<String, dynamic> json) {
    id = json['1'];
    key = json['2'];
    content = json['3'];
  }

  @override
  Dummy clone() {
    return Dummy.from(id, key, content);
  }
}
