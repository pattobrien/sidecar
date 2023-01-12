// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'source_edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SourceEdit _$SourceEditFromJson(Map<String, dynamic> json) {
  return _SourceEdit.fromJson(json);
}

/// @nodoc
mixin _$SourceEdit {
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get originalSourceSpan => throw _privateConstructorUsedError;
  String get replacement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceEditCopyWith<SourceEdit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceEditCopyWith<$Res> {
  factory $SourceEditCopyWith(
          SourceEdit value, $Res Function(SourceEdit) then) =
      _$SourceEditCopyWithImpl<$Res, SourceEdit>;
  @useResult
  $Res call(
      {@JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan originalSourceSpan,
      String replacement});
}

/// @nodoc
class _$SourceEditCopyWithImpl<$Res, $Val extends SourceEdit>
    implements $SourceEditCopyWith<$Res> {
  _$SourceEditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalSourceSpan = null,
    Object? replacement = null,
  }) {
    return _then(_value.copyWith(
      originalSourceSpan: null == originalSourceSpan
          ? _value.originalSourceSpan
          : originalSourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      replacement: null == replacement
          ? _value.replacement
          : replacement // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SourceEditCopyWith<$Res>
    implements $SourceEditCopyWith<$Res> {
  factory _$$_SourceEditCopyWith(
          _$_SourceEdit value, $Res Function(_$_SourceEdit) then) =
      __$$_SourceEditCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan originalSourceSpan,
      String replacement});
}

/// @nodoc
class __$$_SourceEditCopyWithImpl<$Res>
    extends _$SourceEditCopyWithImpl<$Res, _$_SourceEdit>
    implements _$$_SourceEditCopyWith<$Res> {
  __$$_SourceEditCopyWithImpl(
      _$_SourceEdit _value, $Res Function(_$_SourceEdit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalSourceSpan = null,
    Object? replacement = null,
  }) {
    return _then(_$_SourceEdit(
      originalSourceSpan: null == originalSourceSpan
          ? _value.originalSourceSpan
          : originalSourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      replacement: null == replacement
          ? _value.replacement
          : replacement // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SourceEdit extends _SourceEdit {
  const _$_SourceEdit(
      {@JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.originalSourceSpan,
      required this.replacement})
      : super._();

  factory _$_SourceEdit.fromJson(Map<String, dynamic> json) =>
      _$$_SourceEditFromJson(json);

  @override
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  final SourceSpan originalSourceSpan;
  @override
  final String replacement;

  @override
  String toString() {
    return 'SourceEdit(originalSourceSpan: $originalSourceSpan, replacement: $replacement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SourceEdit &&
            (identical(other.originalSourceSpan, originalSourceSpan) ||
                other.originalSourceSpan == originalSourceSpan) &&
            (identical(other.replacement, replacement) ||
                other.replacement == replacement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, originalSourceSpan, replacement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SourceEditCopyWith<_$_SourceEdit> get copyWith =>
      __$$_SourceEditCopyWithImpl<_$_SourceEdit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SourceEditToJson(
      this,
    );
  }
}

abstract class _SourceEdit extends SourceEdit {
  const factory _SourceEdit(
      {@JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan originalSourceSpan,
      required final String replacement}) = _$_SourceEdit;
  const _SourceEdit._() : super._();

  factory _SourceEdit.fromJson(Map<String, dynamic> json) =
      _$_SourceEdit.fromJson;

  @override
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get originalSourceSpan;
  @override
  String get replacement;
  @override
  @JsonKey(ignore: true)
  _$$_SourceEditCopyWith<_$_SourceEdit> get copyWith =>
      throw _privateConstructorUsedError;
}
