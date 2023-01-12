// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'edit_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EditResult _$EditResultFromJson(Map<String, dynamic> json) {
  return _EditResult.fromJson(json);
}

/// @nodoc
mixin _$EditResult {
  /// User facing message about the edit
  String get message => throw _privateConstructorUsedError;
  List<SourceFileEdit> get sourceChanges => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditResultCopyWith<EditResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditResultCopyWith<$Res> {
  factory $EditResultCopyWith(
          EditResult value, $Res Function(EditResult) then) =
      _$EditResultCopyWithImpl<$Res, EditResult>;
  @useResult
  $Res call({String message, List<SourceFileEdit> sourceChanges});
}

/// @nodoc
class _$EditResultCopyWithImpl<$Res, $Val extends EditResult>
    implements $EditResultCopyWith<$Res> {
  _$EditResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sourceChanges = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sourceChanges: null == sourceChanges
          ? _value.sourceChanges
          : sourceChanges // ignore: cast_nullable_to_non_nullable
              as List<SourceFileEdit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditResultCopyWith<$Res>
    implements $EditResultCopyWith<$Res> {
  factory _$$_EditResultCopyWith(
          _$_EditResult value, $Res Function(_$_EditResult) then) =
      __$$_EditResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, List<SourceFileEdit> sourceChanges});
}

/// @nodoc
class __$$_EditResultCopyWithImpl<$Res>
    extends _$EditResultCopyWithImpl<$Res, _$_EditResult>
    implements _$$_EditResultCopyWith<$Res> {
  __$$_EditResultCopyWithImpl(
      _$_EditResult _value, $Res Function(_$_EditResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sourceChanges = null,
  }) {
    return _then(_$_EditResult(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sourceChanges: null == sourceChanges
          ? _value._sourceChanges
          : sourceChanges // ignore: cast_nullable_to_non_nullable
              as List<SourceFileEdit>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EditResult extends _EditResult {
  const _$_EditResult(
      {required this.message,
      required final List<SourceFileEdit> sourceChanges})
      : _sourceChanges = sourceChanges,
        super._();

  factory _$_EditResult.fromJson(Map<String, dynamic> json) =>
      _$$_EditResultFromJson(json);

  /// User facing message about the edit
  @override
  final String message;
  final List<SourceFileEdit> _sourceChanges;
  @override
  List<SourceFileEdit> get sourceChanges {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceChanges);
  }

  @override
  String toString() {
    return 'EditResult(message: $message, sourceChanges: $sourceChanges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditResult &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._sourceChanges, _sourceChanges));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(_sourceChanges));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditResultCopyWith<_$_EditResult> get copyWith =>
      __$$_EditResultCopyWithImpl<_$_EditResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EditResultToJson(
      this,
    );
  }
}

abstract class _EditResult extends EditResult {
  const factory _EditResult(
      {required final String message,
      required final List<SourceFileEdit> sourceChanges}) = _$_EditResult;
  const _EditResult._() : super._();

  factory _EditResult.fromJson(Map<String, dynamic> json) =
      _$_EditResult.fromJson;

  @override

  /// User facing message about the edit
  String get message;
  @override
  List<SourceFileEdit> get sourceChanges;
  @override
  @JsonKey(ignore: true)
  _$$_EditResultCopyWith<_$_EditResult> get copyWith =>
      throw _privateConstructorUsedError;
}
