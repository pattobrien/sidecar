import 'package:freezed_annotation/freezed_annotation.dart';

part 'id.freezed.dart';

@freezed
class Id with _$Id {
  const factory Id({
    required IdType type,
    required String packageId,
    required String id,
  }) = _Id;

  const Id._();
}

enum IdType { lintRule, codeEdit }
