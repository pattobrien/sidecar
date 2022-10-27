// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisSource {
  SourceSpan get span => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisSourceCopyWith<AnalysisSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisSourceCopyWith<$Res> {
  factory $AnalysisSourceCopyWith(
          AnalysisSource value, $Res Function(AnalysisSource) then) =
      _$AnalysisSourceCopyWithImpl<$Res>;
  $Res call({SourceSpan span, String path});
}

/// @nodoc
class _$AnalysisSourceCopyWithImpl<$Res>
    implements $AnalysisSourceCopyWith<$Res> {
  _$AnalysisSourceCopyWithImpl(this._value, this._then);

  final AnalysisSource _value;
  // ignore: unused_field
  final $Res Function(AnalysisSource) _then;

  @override
  $Res call({
    Object? span = freezed,
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_AnalysisSourceCopyWith<$Res>
    implements $AnalysisSourceCopyWith<$Res> {
  factory _$$_AnalysisSourceCopyWith(
          _$_AnalysisSource value, $Res Function(_$_AnalysisSource) then) =
      __$$_AnalysisSourceCopyWithImpl<$Res>;
  @override
  $Res call({SourceSpan span, String path});
}

/// @nodoc
class __$$_AnalysisSourceCopyWithImpl<$Res>
    extends _$AnalysisSourceCopyWithImpl<$Res>
    implements _$$_AnalysisSourceCopyWith<$Res> {
  __$$_AnalysisSourceCopyWithImpl(
      _$_AnalysisSource _value, $Res Function(_$_AnalysisSource) _then)
      : super(_value, (v) => _then(v as _$_AnalysisSource));

  @override
  _$_AnalysisSource get _value => super._value as _$_AnalysisSource;

  @override
  $Res call({
    Object? span = freezed,
    Object? path = freezed,
  }) {
    return _then(_$_AnalysisSource(
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AnalysisSource extends _AnalysisSource {
  const _$_AnalysisSource({required this.span, required this.path}) : super._();

  @override
  final SourceSpan span;
  @override
  final String path;

  @override
  String toString() {
    return 'AnalysisSource(span: $span, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnalysisSource &&
            const DeepCollectionEquality().equals(other.span, span) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(span),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$_AnalysisSourceCopyWith<_$_AnalysisSource> get copyWith =>
      __$$_AnalysisSourceCopyWithImpl<_$_AnalysisSource>(this, _$identity);
}

abstract class _AnalysisSource extends AnalysisSource {
  const factory _AnalysisSource(
      {required final SourceSpan span,
      required final String path}) = _$_AnalysisSource;
  const _AnalysisSource._() : super._();

  @override
  SourceSpan get span;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_AnalysisSourceCopyWith<_$_AnalysisSource> get copyWith =>
      throw _privateConstructorUsedError;
}
