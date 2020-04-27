///
//  Generated code. Do not modify.
//  source: dummies.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ErrorDescription$json = const {
  '1': 'ErrorDescription',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'correlation_id', '3': 3, '4': 1, '5': 9, '10': 'correlationId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'cause', '3': 6, '4': 1, '5': 9, '10': 'cause'},
    const {'1': 'stack_trace', '3': 7, '4': 1, '5': 9, '10': 'stackTrace'},
    const {'1': 'details', '3': 8, '4': 3, '5': 11, '6': '.dummies.ErrorDescription.DetailsEntry', '10': 'details'},
  ],
  '3': const [ErrorDescription_DetailsEntry$json],
};

const ErrorDescription_DetailsEntry$json = const {
  '1': 'DetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

const PagingParams$json = const {
  '1': 'PagingParams',
  '2': const [
    const {'1': 'skip', '3': 1, '4': 1, '5': 3, '10': 'skip'},
    const {'1': 'take', '3': 2, '4': 1, '5': 5, '10': 'take'},
    const {'1': 'total', '3': 3, '4': 1, '5': 8, '10': 'total'},
  ],
};

const Dummy$json = const {
  '1': 'Dummy',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

const DummiesPage$json = const {
  '1': 'DummiesPage',
  '2': const [
    const {'1': 'total', '3': 1, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'data', '3': 2, '4': 3, '5': 11, '6': '.dummies.Dummy', '10': 'data'},
  ],
};

const DummiesPageRequest$json = const {
  '1': 'DummiesPageRequest',
  '2': const [
    const {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    const {'1': 'filter', '3': 2, '4': 3, '5': 11, '6': '.dummies.DummiesPageRequest.FilterEntry', '10': 'filter'},
    const {'1': 'paging', '3': 3, '4': 1, '5': 11, '6': '.dummies.PagingParams', '10': 'paging'},
  ],
  '3': const [DummiesPageRequest_FilterEntry$json],
};

const DummiesPageRequest_FilterEntry$json = const {
  '1': 'FilterEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

const DummyIdRequest$json = const {
  '1': 'DummyIdRequest',
  '2': const [
    const {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    const {'1': 'dummy_id', '3': 2, '4': 1, '5': 9, '10': 'dummyId'},
  ],
};

const DummyObjectRequest$json = const {
  '1': 'DummyObjectRequest',
  '2': const [
    const {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    const {'1': 'dummy', '3': 2, '4': 1, '5': 11, '6': '.dummies.Dummy', '10': 'dummy'},
  ],
};

