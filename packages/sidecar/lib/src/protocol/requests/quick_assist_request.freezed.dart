// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quick_assist_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuickAssistRequest {
  AnalyzedFile get file => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuickAssistRequestCopyWith<QuickAssistRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickAssistRequestCopyWith<$Res> {
  factory $QuickAssistRequestCopyWith(
          QuickAssistRequest value, $Res Function(QuickAssistRequest) then) =
      _$QuickAssistRequestCopyWithImpl<$Res>;
  $Res call({AnalyzedFile file, int offset, int length});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class _$QuickAssistRequestCopyWithImpl<$Res>
    implements $QuickAssistRequestCopyWith<$Res> {
  _$QuickAssistRequestCopyWithImpl(this._value, this._then);

  final QuickAssistRequest _value;
  // ignore: unused_field
  final $Res Function(QuickAssistRequest) _then;

  @override
  $Res call({
    Object? file = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $AnalyzedFileCopyWith<$Res> get file {
    return $AnalyzedFileCopyWith<$Res>(_value.file, (value) {
      return _then(_value.copyWith(file: value));
    });
  }
}

/// @nodoc
abstract class _$$_FromPluginCopyWith<$Res>
    implements $QuickAssistRequestCopyWith<$Res> {
  factory _$$_FromPluginCopyWith(
          _$_FromPlugin value, $Res Function(_$_FromPlugin) then) =
      __$$_FromPluginCopyWithImpl<$Res>;
  @override
  $Res call({AnalyzedFile file, int offset, int length});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$_FromPluginCopyWithImpl<$Res>
    extends _$QuickAssistRequestCopyWithImpl<$Res>
    implements _$$_FromPluginCopyWith<$Res> {
  __$$_FromPluginCopyWithImpl(
      _$_FromPlugin _value, $Res Function(_$_FromPlugin) _then)
      : super(_value, (v) => _then(v as _$_FromPlugin));

  @override
  _$_FromPlugin get _value => super._value as _$_FromPlugin;

  @override
  $Res call({
    Object? file = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_$_FromPlugin(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_FromPlugin extends _FromPlugin {
  const _$_FromPlugin(
      {required this.file, required this.offset, required this.length})
      : super._();

  @override
  final AnalyzedFile file;
  @override
  final int offset;
  @override
  final int length;

  @override
  String toString() {
    return 'QuickAssistRequest(file: $file, offset: $offset, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FromPlugin &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.length, length));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(length));

  @JsonKey(ignore: true)
  @override
  _$$_FromPluginCopyWith<_$_FromPlugin> get copyWith =>
      __$$_FromPluginCopyWithImpl<_$_FromPlugin>(this, _$identity);
}

abstract class _FromPlugin extends QuickAssistRequest {
  const factory _FromPlugin(
      {required final AnalyzedFile file,
      required final int offset,
      required final int length}) = _$_FromPlugin;
  const _FromPlugin._() : super._();

  @override
  AnalyzedFile get file;
  @override
  int get offset;
  @override
  int get length;
  @override
  @JsonKey(ignore: true)
  _$$_FromPluginCopyWith<_$_FromPlugin> get copyWith =>
      throw _privateConstructorUsedError;
}
