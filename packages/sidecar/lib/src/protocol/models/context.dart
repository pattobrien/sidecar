import 'package:freezed_annotation/freezed_annotation.dart';

part 'context.freezed.dart';
part 'context.g.dart';

@freezed
class Context with _$Context {
  const factory Context({
    required Uri root,
  }) = _Context;

  const Context._();

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);
}
