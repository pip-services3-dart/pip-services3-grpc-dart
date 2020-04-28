///
//  Generated code. Do not modify.
//  source: commandable.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorDescription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrorDescription',
      package: const $pb.PackageName('commandable'),
      createEmptyInstance: create)
    ..aOS(1, 'category')
    ..aOS(2, 'code')
    ..aOS(3, 'correlationId')
    ..a<$core.int>(4, 'status', $pb.PbFieldType.O3)
    ..aOS(5, 'message')
    ..aOS(6, 'cause')
    ..aOS(7, 'stackTrace')
    ..m<$core.String, $core.String>(8, 'details',
        entryClassName: 'ErrorDescription.DetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('commandable'))
    ..hasRequiredFields = false;

  ErrorDescription._() : super();
  factory ErrorDescription() => create();
  factory ErrorDescription.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorDescription.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ErrorDescription clone() => ErrorDescription()..mergeFromMessage(this);
  ErrorDescription copyWith(void Function(ErrorDescription) updates) =>
      super.copyWith((message) => updates(message as ErrorDescription));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorDescription create() => ErrorDescription._();
  ErrorDescription createEmptyInstance() => create();
  static $pb.PbList<ErrorDescription> createRepeated() =>
      $pb.PbList<ErrorDescription>();
  @$core.pragma('dart2js:noInline')
  static ErrorDescription getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ErrorDescription>(create);
  static ErrorDescription _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get correlationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set correlationId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCorrelationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCorrelationId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get status => $_getIZ(3);
  @$pb.TagNumber(4)
  set status($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cause => $_getSZ(5);
  @$pb.TagNumber(6)
  set cause($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCause() => $_has(5);
  @$pb.TagNumber(6)
  void clearCause() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get stackTrace => $_getSZ(6);
  @$pb.TagNumber(7)
  set stackTrace($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStackTrace() => $_has(6);
  @$pb.TagNumber(7)
  void clearStackTrace() => clearField(7);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get details => $_getMap(7);
}

class InvokeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InvokeRequest',
      package: const $pb.PackageName('commandable'),
      createEmptyInstance: create)
    ..aOS(1, 'method')
    ..aOS(2, 'correlationId')
    ..aOB(3, 'argsEmpty')
    ..aOS(4, 'argsJson')
    ..hasRequiredFields = false;

  InvokeRequest._() : super();
  factory InvokeRequest() => create();
  factory InvokeRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InvokeRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  InvokeRequest clone() => InvokeRequest()..mergeFromMessage(this);
  InvokeRequest copyWith(void Function(InvokeRequest) updates) =>
      super.copyWith((message) => updates(message as InvokeRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvokeRequest create() => InvokeRequest._();
  InvokeRequest createEmptyInstance() => create();
  static $pb.PbList<InvokeRequest> createRepeated() =>
      $pb.PbList<InvokeRequest>();
  @$core.pragma('dart2js:noInline')
  static InvokeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvokeRequest>(create);
  static InvokeRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get correlationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set correlationId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCorrelationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrelationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get argsEmpty => $_getBF(2);
  @$pb.TagNumber(3)
  set argsEmpty($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasArgsEmpty() => $_has(2);
  @$pb.TagNumber(3)
  void clearArgsEmpty() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get argsJson => $_getSZ(3);
  @$pb.TagNumber(4)
  set argsJson($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasArgsJson() => $_has(3);
  @$pb.TagNumber(4)
  void clearArgsJson() => clearField(4);
}

class InvokeReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InvokeReply',
      package: const $pb.PackageName('commandable'),
      createEmptyInstance: create)
    ..aOM<ErrorDescription>(1, 'error', subBuilder: ErrorDescription.create)
    ..aOB(2, 'resultEmpty')
    ..aOS(3, 'resultJson')
    ..hasRequiredFields = false;

  InvokeReply._() : super();
  factory InvokeReply() => create();
  factory InvokeReply.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InvokeReply.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  InvokeReply clone() => InvokeReply()..mergeFromMessage(this);
  InvokeReply copyWith(void Function(InvokeReply) updates) =>
      super.copyWith((message) => updates(message as InvokeReply));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvokeReply create() => InvokeReply._();
  InvokeReply createEmptyInstance() => create();
  static $pb.PbList<InvokeReply> createRepeated() => $pb.PbList<InvokeReply>();
  @$core.pragma('dart2js:noInline')
  static InvokeReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvokeReply>(create);
  static InvokeReply _defaultInstance;

  @$pb.TagNumber(1)
  ErrorDescription get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(ErrorDescription v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => clearField(1);
  @$pb.TagNumber(1)
  ErrorDescription ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get resultEmpty => $_getBF(1);
  @$pb.TagNumber(2)
  set resultEmpty($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResultEmpty() => $_has(1);
  @$pb.TagNumber(2)
  void clearResultEmpty() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get resultJson => $_getSZ(2);
  @$pb.TagNumber(3)
  set resultJson($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasResultJson() => $_has(2);
  @$pb.TagNumber(3)
  void clearResultJson() => clearField(3);
}
