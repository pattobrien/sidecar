import 'package:freezed_annotation/freezed_annotation.dart';

import '../protocol.dart';

part 'data_result.freezed.dart';

@freezed
class DataResult<T> with _$DataResult<T> {
  const factory DataResult.total({
    required RuleCode code,
    required Set<SingleDataResult<T>> data,
  }) = TotalData<T>;

  const factory DataResult.single({
    required RuleCode code,
    required T data,
  }) = SingleDataResult<T>;

  const DataResult._();
}
