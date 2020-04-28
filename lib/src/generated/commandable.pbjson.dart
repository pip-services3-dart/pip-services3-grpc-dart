///
//  Generated code. Do not modify.
//  source: commandable.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ErrorDescription$json = const {
  '1': 'ErrorDescription',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {
      '1': 'correlation_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'correlationId'
    },
    const {'1': 'status', '3': 4, '4': 1, '5': 5, '10': 'status'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'cause', '3': 6, '4': 1, '5': 9, '10': 'cause'},
    const {'1': 'stack_trace', '3': 7, '4': 1, '5': 9, '10': 'stackTrace'},
    const {
      '1': 'details',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.commandable.ErrorDescription.DetailsEntry',
      '10': 'details'
    },
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

const InvokeRequest$json = const {
  '1': 'InvokeRequest',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    const {
      '1': 'correlation_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'correlationId'
    },
    const {'1': 'args_empty', '3': 3, '4': 1, '5': 8, '10': 'argsEmpty'},
    const {'1': 'args_json', '3': 4, '4': 1, '5': 9, '10': 'argsJson'},
  ],
};

const InvokeReply$json = const {
  '1': 'InvokeReply',
  '2': const [
    const {
      '1': 'error',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.commandable.ErrorDescription',
      '10': 'error'
    },
    const {'1': 'result_empty', '3': 2, '4': 1, '5': 8, '10': 'resultEmpty'},
    const {'1': 'result_json', '3': 3, '4': 1, '5': 9, '10': 'resultJson'},
  ],
};
