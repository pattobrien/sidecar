// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalyzedFile {
  ContextRoot get contextRoot =>
      throw _privateConstructorUsedError; // String contextRootPath,
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalyzedFileCopyWith<AnalyzedFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyzedFileCopyWith<$Res> {
  factory $AnalyzedFileCopyWith(
          AnalyzedFile value, $Res Function(AnalyzedFile) then) =
      _$AnalyzedFileCopyWithImpl<$Res>;
  $Res call({ContextRoot contextRoot, String path});
}

/// @nodoc
class _$AnalyzedFileCopyWithImpl<$Res> implements $AnalyzedFileCopyWith<$Res> {
  _$AnalyzedFileCopyWithImpl(this._value, this._then);

  final AnalyzedFile _value;
  // ignore: unused_field
  final $Res Function(AnalyzedFile) _then;

  @override
  $Res call({
    Object? contextRoot = freezed,
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      contextRoot: contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_AnalyzedFileCopyWith<$Res>
    implements $AnalyzedFileCopyWith<$Res> {
  factory _$$_AnalyzedFileCopyWith(
          _$_AnalyzedFile value, $Res Function(_$_AnalyzedFile) then) =
      __$$_AnalyzedFileCopyWithImpl<$Res>;
  @override
  $Res call({ContextRoot contextRoot, String path});
}

/// @nodoc
class __$$_AnalyzedFileCopyWithImpl<$Res>
    extends _$AnalyzedFileCopyWithImpl<$Res>
    implements _$$_AnalyzedFileCopyWith<$Res> {
  __$$_AnalyzedFileCopyWithImpl(
      _$_AnalyzedFile _value, $Res Function(_$_AnalyzedFile) _then)
      : super(_value, (v) => _then(v as _$_AnalyzedFile));

  @override
  _$_AnalyzedFile get _value => super._value as _$_AnalyzedFile;

  @override
  $Res call({
    Object? contextRoot = freezed,
    Object? path = freezed,
  }) {
    return _then(_$_AnalyzedFile(
      contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AnalyzedFile extends _AnalyzedFile {
  const _$_AnalyzedFile(this.contextRoot, this.path) : super._();

  @override
  final ContextRoot contextRoot;
// String contextRootPath,
  @override
  final String path;

  @override
  String toString() {
    return 'AnalyzedFile(contextRoot: $contextRoot, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnalyzedFile &&
            const DeepCollectionEquality()
                .equals(other.contextRoot, contextRoot) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(contextRoot),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$_AnalyzedFileCopyWith<_$_AnalyzedFile> get copyWith =>
      __$$_AnalyzedFileCopyWithImpl<_$_AnalyzedFile>(this, _$identity);
}

abstract class _AnalyzedFile extends AnalyzedFile {
  const factory _AnalyzedFile(
      final ContextRoot contextRoot, final String path) = _$_AnalyzedFile;
  const _AnalyzedFile._() : super._();

  @override
  ContextRoot get contextRoot;
  @override // String contextRootPath,
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_AnalyzedFileCopyWith<_$_AnalyzedFile> get copyWith =>
      throw _privateConstructorUsedError;
}
