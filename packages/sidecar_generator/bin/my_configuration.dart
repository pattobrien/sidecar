import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sidecar/sidecar.dart';

part 'my_configuration.freezed.dart';
part 'my_configuration.g.dart';

@freezed
class MyConfiguration with _$MyConfiguration {
  const MyConfiguration._();
  const factory MyConfiguration({
    required String field,
    required bool field2,
  }) = _MyConfiguration;
}
