// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'assist_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssistResult _$AssistResultFromJson(Map<String, dynamic> json) {
  return _AssistResult.fromJson(json);
}

/// @nodoc
mixin _$AssistResult {
  RuleCode get code => throw _privateConstructorUsedError;
  List<EditResult> get edits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssistResultCopyWith<AssistResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssistResultCopyWith<$Res> {
  factory $AssistResultCopyWith(
          AssistResult value, $Res Function(AssistResult) then) =
      _$AssistResultCopyWithImpl<$Res>;
  $Res call({RuleCode code, List<EditResult> edits});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$AssistResultCopyWithImpl<$Res> implements $AssistResultCopyWith<$Res> {
  _$AssistResultCopyWithImpl(this._value, this._then);

  final AssistResult _value;
  // ignore: unused_field
  final $Res Function(AssistResult) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? edits = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      edits: edits == freezed
          ? _value.edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }

  @override
  $RuleCodeCopyWith<$Res> get code {
    return $RuleCodeCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value));
    });
  }
}

/// @nodoc
abstract class _$$_AssistResultCopyWith<$Res>
    implements $AssistResultCopyWith<$Res> {
  factory _$$_AssistResultCopyWith(
          _$_AssistResult value, $Res Function(_$_AssistResult) then) =
      __$$_AssistResultCopyWithImpl<$Res>;
  @override
  $Res call({RuleCode code, List<EditResult> edits});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$_AssistResultCopyWithImpl<$Res>
    extends _$AssistResultCopyWithImpl<$Res>
    implements _$$_AssistResultCopyWith<$Res> {
  __$$_AssistResultCopyWithImpl(
      _$_AssistResult _value, $Res Function(_$_AssistResult) _then)
      : super(_value, (v) => _then(v as _$_AssistResult));

  @override
  _$_AssistResult get _value => super._value as _$_AssistResult;

  @override
  $Res call({
    Object? code = freezed,
    Object? edits = freezed,
  }) {
    return _then(_$_AssistResult(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AssistResult extends _AssistResult {
  const _$_AssistResult(
      {required this.code, final List<EditResult> edits = const <EditResult>[]})
      : _edits = edits,
        super._();

  factory _$_AssistResult.fromJson(Map<String, dynamic> json) =>
      _$$_AssistResultFromJson(json);

  @override
  final RuleCode code;
  final List<EditResult> _edits;
  @override
  @JsonKey()
  List<EditResult> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  @override
  String toString() {
    return 'AssistResult(code: $code, edits: $edits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AssistResult &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
  _$$_AssistResultCopyWith<_$_AssistResult> get copyWith =>
      __$$_AssistResultCopyWithImpl<_$_AssistResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssistResultToJson(
      this,
    );
  }
}

abstract class _AssistResult extends AssistResult {
  const factory _AssistResult(
      {required final RuleCode code,
      final List<EditResult> edits}) = _$_AssistResult;
  const _AssistResult._() : super._();

  factory _AssistResult.fromJson(Map<String, dynamic> json) =
      _$_AssistResult.fromJson;

  @override
  RuleCode get code;
  @override
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$_AssistResultCopyWith<_$_AssistResult> get copyWith =>
      throw _privateConstructorUsedError;
}
