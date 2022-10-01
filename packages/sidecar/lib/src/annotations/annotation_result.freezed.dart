// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'annotation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnnotationResult {
  String get packageName => throw _privateConstructorUsedError;
  String? get analysisRuleId => throw _privateConstructorUsedError;
  String? get annotationId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnnotationResultCopyWith<AnnotationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnotationResultCopyWith<$Res> {
  factory $AnnotationResultCopyWith(
          AnnotationResult value, $Res Function(AnnotationResult) then) =
      _$AnnotationResultCopyWithImpl<$Res>;
  $Res call({String packageName, String? analysisRuleId, String? annotationId});
}

/// @nodoc
class _$AnnotationResultCopyWithImpl<$Res>
    implements $AnnotationResultCopyWith<$Res> {
  _$AnnotationResultCopyWithImpl(this._value, this._then);

  final AnnotationResult _value;
  // ignore: unused_field
  final $Res Function(AnnotationResult) _then;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? analysisRuleId = freezed,
    Object? annotationId = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      analysisRuleId: analysisRuleId == freezed
          ? _value.analysisRuleId
          : analysisRuleId // ignore: cast_nullable_to_non_nullable
              as String?,
      annotationId: annotationId == freezed
          ? _value.annotationId
          : annotationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_AnnotationResultCopyWith<$Res>
    implements $AnnotationResultCopyWith<$Res> {
  factory _$$_AnnotationResultCopyWith(
          _$_AnnotationResult value, $Res Function(_$_AnnotationResult) then) =
      __$$_AnnotationResultCopyWithImpl<$Res>;
  @override
  $Res call({String packageName, String? analysisRuleId, String? annotationId});
}

/// @nodoc
class __$$_AnnotationResultCopyWithImpl<$Res>
    extends _$AnnotationResultCopyWithImpl<$Res>
    implements _$$_AnnotationResultCopyWith<$Res> {
  __$$_AnnotationResultCopyWithImpl(
      _$_AnnotationResult _value, $Res Function(_$_AnnotationResult) _then)
      : super(_value, (v) => _then(v as _$_AnnotationResult));

  @override
  _$_AnnotationResult get _value => super._value as _$_AnnotationResult;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? analysisRuleId = freezed,
    Object? annotationId = freezed,
  }) {
    return _then(_$_AnnotationResult(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      analysisRuleId: analysisRuleId == freezed
          ? _value.analysisRuleId
          : analysisRuleId // ignore: cast_nullable_to_non_nullable
              as String?,
      annotationId: annotationId == freezed
          ? _value.annotationId
          : annotationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AnnotationResult extends _AnnotationResult {
  const _$_AnnotationResult(
      {required this.packageName, this.analysisRuleId, this.annotationId})
      : super._();

  @override
  final String packageName;
  @override
  final String? analysisRuleId;
  @override
  final String? annotationId;

  @override
  String toString() {
    return 'AnnotationResult(packageName: $packageName, analysisRuleId: $analysisRuleId, annotationId: $annotationId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnnotationResult &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.analysisRuleId, analysisRuleId) &&
            const DeepCollectionEquality()
                .equals(other.annotationId, annotationId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(analysisRuleId),
      const DeepCollectionEquality().hash(annotationId));

  @JsonKey(ignore: true)
  @override
  _$$_AnnotationResultCopyWith<_$_AnnotationResult> get copyWith =>
      __$$_AnnotationResultCopyWithImpl<_$_AnnotationResult>(this, _$identity);
}

abstract class _AnnotationResult extends AnnotationResult {
  const factory _AnnotationResult(
      {required final String packageName,
      final String? analysisRuleId,
      final String? annotationId}) = _$_AnnotationResult;
  const _AnnotationResult._() : super._();

  @override
  String get packageName;
  @override
  String? get analysisRuleId;
  @override
  String? get annotationId;
  @override
  @JsonKey(ignore: true)
  _$$_AnnotationResultCopyWith<_$_AnnotationResult> get copyWith =>
      throw _privateConstructorUsedError;
}
