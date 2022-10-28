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
  String get path => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SourceSpan source, String path) span,
    required TResult Function(SourceCursor source, String path) cursor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AnalysisSourceSpan value) span,
    required TResult Function(AnalysisSourceCursor value) cursor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisSourceCopyWith<AnalysisSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisSourceCopyWith<$Res> {
  factory $AnalysisSourceCopyWith(
          AnalysisSource value, $Res Function(AnalysisSource) then) =
      _$AnalysisSourceCopyWithImpl<$Res>;
  $Res call({String path});
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
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$AnalysisSourceSpanCopyWith<$Res>
    implements $AnalysisSourceCopyWith<$Res> {
  factory _$$AnalysisSourceSpanCopyWith(_$AnalysisSourceSpan value,
          $Res Function(_$AnalysisSourceSpan) then) =
      __$$AnalysisSourceSpanCopyWithImpl<$Res>;
  @override
  $Res call({SourceSpan source, String path});
}

/// @nodoc
class __$$AnalysisSourceSpanCopyWithImpl<$Res>
    extends _$AnalysisSourceCopyWithImpl<$Res>
    implements _$$AnalysisSourceSpanCopyWith<$Res> {
  __$$AnalysisSourceSpanCopyWithImpl(
      _$AnalysisSourceSpan _value, $Res Function(_$AnalysisSourceSpan) _then)
      : super(_value, (v) => _then(v as _$AnalysisSourceSpan));

  @override
  _$AnalysisSourceSpan get _value => super._value as _$AnalysisSourceSpan;

  @override
  $Res call({
    Object? source = freezed,
    Object? path = freezed,
  }) {
    return _then(_$AnalysisSourceSpan(
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AnalysisSourceSpan extends AnalysisSourceSpan {
  const _$AnalysisSourceSpan({required this.source, required this.path})
      : super._();

  @override
  final SourceSpan source;
  @override
  final String path;

  @override
  String toString() {
    return 'AnalysisSource.span(source: $source, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisSourceSpan &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$AnalysisSourceSpanCopyWith<_$AnalysisSourceSpan> get copyWith =>
      __$$AnalysisSourceSpanCopyWithImpl<_$AnalysisSourceSpan>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SourceSpan source, String path) span,
    required TResult Function(SourceCursor source, String path) cursor,
  }) {
    return span(source, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
  }) {
    return span?.call(source, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
    required TResult orElse(),
  }) {
    if (span != null) {
      return span(source, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AnalysisSourceSpan value) span,
    required TResult Function(AnalysisSourceCursor value) cursor,
  }) {
    return span(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
  }) {
    return span?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
    required TResult orElse(),
  }) {
    if (span != null) {
      return span(this);
    }
    return orElse();
  }
}

abstract class AnalysisSourceSpan extends AnalysisSource {
  const factory AnalysisSourceSpan(
      {required final SourceSpan source,
      required final String path}) = _$AnalysisSourceSpan;
  const AnalysisSourceSpan._() : super._();

  SourceSpan get source;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$AnalysisSourceSpanCopyWith<_$AnalysisSourceSpan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalysisSourceCursorCopyWith<$Res>
    implements $AnalysisSourceCopyWith<$Res> {
  factory _$$AnalysisSourceCursorCopyWith(_$AnalysisSourceCursor value,
          $Res Function(_$AnalysisSourceCursor) then) =
      __$$AnalysisSourceCursorCopyWithImpl<$Res>;
  @override
  $Res call({SourceCursor source, String path});
}

/// @nodoc
class __$$AnalysisSourceCursorCopyWithImpl<$Res>
    extends _$AnalysisSourceCopyWithImpl<$Res>
    implements _$$AnalysisSourceCursorCopyWith<$Res> {
  __$$AnalysisSourceCursorCopyWithImpl(_$AnalysisSourceCursor _value,
      $Res Function(_$AnalysisSourceCursor) _then)
      : super(_value, (v) => _then(v as _$AnalysisSourceCursor));

  @override
  _$AnalysisSourceCursor get _value => super._value as _$AnalysisSourceCursor;

  @override
  $Res call({
    Object? source = freezed,
    Object? path = freezed,
  }) {
    return _then(_$AnalysisSourceCursor(
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as SourceCursor,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AnalysisSourceCursor extends AnalysisSourceCursor {
  const _$AnalysisSourceCursor({required this.source, required this.path})
      : super._();

  @override
  final SourceCursor source;
  @override
  final String path;

  @override
  String toString() {
    return 'AnalysisSource.cursor(source: $source, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisSourceCursor &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$AnalysisSourceCursorCopyWith<_$AnalysisSourceCursor> get copyWith =>
      __$$AnalysisSourceCursorCopyWithImpl<_$AnalysisSourceCursor>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SourceSpan source, String path) span,
    required TResult Function(SourceCursor source, String path) cursor,
  }) {
    return cursor(source, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
  }) {
    return cursor?.call(source, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SourceSpan source, String path)? span,
    TResult Function(SourceCursor source, String path)? cursor,
    required TResult orElse(),
  }) {
    if (cursor != null) {
      return cursor(source, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AnalysisSourceSpan value) span,
    required TResult Function(AnalysisSourceCursor value) cursor,
  }) {
    return cursor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
  }) {
    return cursor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalysisSourceSpan value)? span,
    TResult Function(AnalysisSourceCursor value)? cursor,
    required TResult orElse(),
  }) {
    if (cursor != null) {
      return cursor(this);
    }
    return orElse();
  }
}

abstract class AnalysisSourceCursor extends AnalysisSource {
  const factory AnalysisSourceCursor(
      {required final SourceCursor source,
      required final String path}) = _$AnalysisSourceCursor;
  const AnalysisSourceCursor._() : super._();

  SourceCursor get source;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$AnalysisSourceCursorCopyWith<_$AnalysisSourceCursor> get copyWith =>
      throw _privateConstructorUsedError;
}
