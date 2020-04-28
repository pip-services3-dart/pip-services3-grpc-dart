///
//  Generated code. Do not modify.
//  source: dummies.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ErrorDescription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrorDescription',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aOS(1, 'category')
    ..aOS(2, 'code')
    ..aOS(3, 'correlationId')
    ..aOS(4, 'status')
    ..aOS(5, 'message')
    ..aOS(6, 'cause')
    ..aOS(7, 'stackTrace')
    ..m<$core.String, $core.String>(8, 'details',
        entryClassName: 'ErrorDescription.DetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('dummies'))
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
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) {
    $_setString(3, v);
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

class PagingParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PagingParams',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aInt64(1, 'skip')
    ..a<$core.int>(2, 'take', $pb.PbFieldType.O3)
    ..aOB(3, 'total')
    ..hasRequiredFields = false;

  PagingParams._() : super();
  factory PagingParams() => create();
  factory PagingParams.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PagingParams.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  PagingParams clone() => PagingParams()..mergeFromMessage(this);
  PagingParams copyWith(void Function(PagingParams) updates) =>
      super.copyWith((message) => updates(message as PagingParams));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PagingParams create() => PagingParams._();
  PagingParams createEmptyInstance() => create();
  static $pb.PbList<PagingParams> createRepeated() =>
      $pb.PbList<PagingParams>();
  @$core.pragma('dart2js:noInline')
  static PagingParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PagingParams>(create);
  static PagingParams _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get skip => $_getI64(0);
  @$pb.TagNumber(1)
  set skip($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSkip() => $_has(0);
  @$pb.TagNumber(1)
  void clearSkip() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get take => $_getIZ(1);
  @$pb.TagNumber(2)
  set take($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTake() => $_has(1);
  @$pb.TagNumber(2)
  void clearTake() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get total => $_getBF(2);
  @$pb.TagNumber(3)
  set total($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => clearField(3);
}

class Dummy extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Dummy',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'key')
    ..aOS(3, 'content')
    ..hasRequiredFields = false;

  Dummy._() : super();
  factory Dummy() => create();
  factory Dummy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Dummy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Dummy clone() => Dummy()..mergeFromMessage(this);
  Dummy copyWith(void Function(Dummy) updates) =>
      super.copyWith((message) => updates(message as Dummy));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Dummy create() => Dummy._();
  Dummy createEmptyInstance() => create();
  static $pb.PbList<Dummy> createRepeated() => $pb.PbList<Dummy>();
  @$core.pragma('dart2js:noInline')
  static Dummy getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Dummy>(create);
  static Dummy _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);
}

class DummiesPage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DummiesPage',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aInt64(1, 'total')
    ..pc<Dummy>(2, 'data', $pb.PbFieldType.PM, subBuilder: Dummy.create)
    ..hasRequiredFields = false;

  DummiesPage._() : super();
  factory DummiesPage() => create();
  factory DummiesPage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DummiesPage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DummiesPage clone() => DummiesPage()..mergeFromMessage(this);
  DummiesPage copyWith(void Function(DummiesPage) updates) =>
      super.copyWith((message) => updates(message as DummiesPage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DummiesPage create() => DummiesPage._();
  DummiesPage createEmptyInstance() => create();
  static $pb.PbList<DummiesPage> createRepeated() => $pb.PbList<DummiesPage>();
  @$core.pragma('dart2js:noInline')
  static DummiesPage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DummiesPage>(create);
  static DummiesPage _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get total => $_getI64(0);
  @$pb.TagNumber(1)
  set total($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Dummy> get data => $_getList(1);
}

class DummiesPageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DummiesPageRequest',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aOS(1, 'correlationId')
    ..m<$core.String, $core.String>(2, 'filter',
        entryClassName: 'DummiesPageRequest.FilterEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('dummies'))
    ..aOM<PagingParams>(3, 'paging', subBuilder: PagingParams.create)
    ..hasRequiredFields = false;

  DummiesPageRequest._() : super();
  factory DummiesPageRequest() => create();
  factory DummiesPageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DummiesPageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DummiesPageRequest clone() => DummiesPageRequest()..mergeFromMessage(this);
  DummiesPageRequest copyWith(void Function(DummiesPageRequest) updates) =>
      super.copyWith((message) => updates(message as DummiesPageRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DummiesPageRequest create() => DummiesPageRequest._();
  DummiesPageRequest createEmptyInstance() => create();
  static $pb.PbList<DummiesPageRequest> createRepeated() =>
      $pb.PbList<DummiesPageRequest>();
  @$core.pragma('dart2js:noInline')
  static DummiesPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DummiesPageRequest>(create);
  static DummiesPageRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get filter => $_getMap(1);

  @$pb.TagNumber(3)
  PagingParams get paging => $_getN(2);
  @$pb.TagNumber(3)
  set paging(PagingParams v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPaging() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaging() => clearField(3);
  @$pb.TagNumber(3)
  PagingParams ensurePaging() => $_ensure(2);
}

class DummyIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DummyIdRequest',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aOS(1, 'correlationId')
    ..aOS(2, 'dummyId')
    ..hasRequiredFields = false;

  DummyIdRequest._() : super();
  factory DummyIdRequest() => create();
  factory DummyIdRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DummyIdRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DummyIdRequest clone() => DummyIdRequest()..mergeFromMessage(this);
  DummyIdRequest copyWith(void Function(DummyIdRequest) updates) =>
      super.copyWith((message) => updates(message as DummyIdRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DummyIdRequest create() => DummyIdRequest._();
  DummyIdRequest createEmptyInstance() => create();
  static $pb.PbList<DummyIdRequest> createRepeated() =>
      $pb.PbList<DummyIdRequest>();
  @$core.pragma('dart2js:noInline')
  static DummyIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DummyIdRequest>(create);
  static DummyIdRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dummyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set dummyId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDummyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDummyId() => clearField(2);
}

class DummyObjectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DummyObjectRequest',
      package: const $pb.PackageName('dummies'), createEmptyInstance: create)
    ..aOS(1, 'correlationId')
    ..aOM<Dummy>(2, 'dummy', subBuilder: Dummy.create)
    ..hasRequiredFields = false;

  DummyObjectRequest._() : super();
  factory DummyObjectRequest() => create();
  factory DummyObjectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DummyObjectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DummyObjectRequest clone() => DummyObjectRequest()..mergeFromMessage(this);
  DummyObjectRequest copyWith(void Function(DummyObjectRequest) updates) =>
      super.copyWith((message) => updates(message as DummyObjectRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DummyObjectRequest create() => DummyObjectRequest._();
  DummyObjectRequest createEmptyInstance() => create();
  static $pb.PbList<DummyObjectRequest> createRepeated() =>
      $pb.PbList<DummyObjectRequest>();
  @$core.pragma('dart2js:noInline')
  static DummyObjectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DummyObjectRequest>(create);
  static DummyObjectRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => clearField(1);

  @$pb.TagNumber(2)
  Dummy get dummy => $_getN(1);
  @$pb.TagNumber(2)
  set dummy(Dummy v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDummy() => $_has(1);
  @$pb.TagNumber(2)
  void clearDummy() => clearField(2);
  @$pb.TagNumber(2)
  Dummy ensureDummy() => $_ensure(1);
}
