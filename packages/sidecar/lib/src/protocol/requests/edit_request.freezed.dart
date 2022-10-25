// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'edit_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditRequest {
  int get offset => throw _privateConstructorUsedError;
  AnalyzedFile get file => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditRequestCopyWith<EditRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditRequestCopyWith<$Res> {
  factory $EditRequestCopyWith(
          EditRequest value, $Res Function(EditRequest) then) =
      _$EditRequestCopyWithImpl<$Res>;
  $Res call({int offset, AnalyzedFile file});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class _$EditRequestCopyWithImpl<$Res> implements $EditRequestCopyWith<$Res> {
  _$EditRequestCopyWithImpl(this._value, this._then);

  final EditRequest _value;
  // ignore: unused_field
  final $Res Function(EditRequest) _then;

  @override
  $Res call({
    Object? offset = freezed,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
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
abstract class _$$_EditRequestCopyWith<$Res>
    implements $EditRequestCopyWith<$Res> {
  factory _$$_EditRequestCopyWith(
          _$_EditRequest value, $Res Function(_$_EditRequest) then) =
      __$$_EditRequestCopyWithImpl<$Res>;
  @override
  $Res call({int offset, AnalyzedFile file});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$_EditRequestCopyWithImpl<$Res> extends _$EditRequestCopyWithImpl<$Res>
    implements _$$_EditRequestCopyWith<$Res> {
  __$$_EditRequestCopyWithImpl(
      _$_EditRequest _value, $Res Function(_$_EditRequest) _then)
      : super(_value, (v) => _then(v as _$_EditRequest));

  @override
  _$_EditRequest get _value => super._value as _$_EditRequest;

  @override
  $Res call({
    Object? offset = freezed,
    Object? file = freezed,
  }) {
    return _then(_$_EditRequest(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
    ));
  }
}

/// @nodoc

class _$_EditRequest extends _EditRequest {
  const _$_EditRequest({required this.offset, required this.file}) : super._();

  @override
  final int offset;
  @override
  final AnalyzedFile file;

  @override
  String toString() {
    return 'EditRequest(offset: $offset, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditRequest &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  _$$_EditRequestCopyWith<_$_EditRequest> get copyWith =>
      __$$_EditRequestCopyWithImpl<_$_EditRequest>(this, _$identity);
}

abstract class _EditRequest extends EditRequest {
  const factory _EditRequest(
      {required final int offset,
      required final AnalyzedFile file}) = _$_EditRequest;
  const _EditRequest._() : super._();

  @override
  int get offset;
  @override
  AnalyzedFile get file;
  @override
  @JsonKey(ignore: true)
  _$$_EditRequestCopyWith<_$_EditRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
