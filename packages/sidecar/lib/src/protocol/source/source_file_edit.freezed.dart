// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'source_file_edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SourceFileEdit _$SourceFileEditFromJson(Map<String, dynamic> json) {
  return _SourceFileEdit.fromJson(json);
}

/// @nodoc
mixin _$SourceFileEdit {
  /// The file containing the code to be modified.
  Uri get file => throw _privateConstructorUsedError;

  /// A list of the edits used to effect the change.
  List<SourceEdit> get edits => throw _privateConstructorUsedError;

  /// The modification stamp of the file at the moment when the change was
  /// created. Will be -1 if the file did not exist and should be created.
  /// The client may use this field to make sure that the file was not
  /// changed since then, so it is safe to apply the change.
  DateTime get fileStamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SourceFileEditCopyWith<SourceFileEdit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceFileEditCopyWith<$Res> {
  factory $SourceFileEditCopyWith(
          SourceFileEdit value, $Res Function(SourceFileEdit) then) =
      _$SourceFileEditCopyWithImpl<$Res, SourceFileEdit>;
  @useResult
  $Res call({Uri file, List<SourceEdit> edits, DateTime fileStamp});
}

/// @nodoc
class _$SourceFileEditCopyWithImpl<$Res, $Val extends SourceFileEdit>
    implements $SourceFileEditCopyWith<$Res> {
  _$SourceFileEditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? edits = null,
    Object? fileStamp = null,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uri,
      edits: null == edits
          ? _value.edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<SourceEdit>,
      fileStamp: null == fileStamp
          ? _value.fileStamp
          : fileStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SourceFileEditCopyWith<$Res>
    implements $SourceFileEditCopyWith<$Res> {
  factory _$$_SourceFileEditCopyWith(
          _$_SourceFileEdit value, $Res Function(_$_SourceFileEdit) then) =
      __$$_SourceFileEditCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri file, List<SourceEdit> edits, DateTime fileStamp});
}

/// @nodoc
class __$$_SourceFileEditCopyWithImpl<$Res>
    extends _$SourceFileEditCopyWithImpl<$Res, _$_SourceFileEdit>
    implements _$$_SourceFileEditCopyWith<$Res> {
  __$$_SourceFileEditCopyWithImpl(
      _$_SourceFileEdit _value, $Res Function(_$_SourceFileEdit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? edits = null,
    Object? fileStamp = null,
  }) {
    return _then(_$_SourceFileEdit(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uri,
      edits: null == edits
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<SourceEdit>,
      fileStamp: null == fileStamp
          ? _value.fileStamp
          : fileStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SourceFileEdit implements _SourceFileEdit {
  const _$_SourceFileEdit(
      {required this.file,
      required final List<SourceEdit> edits,
      required this.fileStamp})
      : _edits = edits;

  factory _$_SourceFileEdit.fromJson(Map<String, dynamic> json) =>
      _$$_SourceFileEditFromJson(json);

  /// The file containing the code to be modified.
  @override
  final Uri file;

  /// A list of the edits used to effect the change.
  final List<SourceEdit> _edits;

  /// A list of the edits used to effect the change.
  @override
  List<SourceEdit> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  /// The modification stamp of the file at the moment when the change was
  /// created. Will be -1 if the file did not exist and should be created.
  /// The client may use this field to make sure that the file was not
  /// changed since then, so it is safe to apply the change.
  @override
  final DateTime fileStamp;

  @override
  String toString() {
    return 'SourceFileEdit._(file: $file, edits: $edits, fileStamp: $fileStamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SourceFileEdit &&
            (identical(other.file, file) || other.file == file) &&
            const DeepCollectionEquality().equals(other._edits, _edits) &&
            (identical(other.fileStamp, fileStamp) ||
                other.fileStamp == fileStamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, file,
      const DeepCollectionEquality().hash(_edits), fileStamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SourceFileEditCopyWith<_$_SourceFileEdit> get copyWith =>
      __$$_SourceFileEditCopyWithImpl<_$_SourceFileEdit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SourceFileEditToJson(
      this,
    );
  }
}

abstract class _SourceFileEdit implements SourceFileEdit {
  const factory _SourceFileEdit(
      {required final Uri file,
      required final List<SourceEdit> edits,
      required final DateTime fileStamp}) = _$_SourceFileEdit;

  factory _SourceFileEdit.fromJson(Map<String, dynamic> json) =
      _$_SourceFileEdit.fromJson;

  @override

  /// The file containing the code to be modified.
  Uri get file;
  @override

  /// A list of the edits used to effect the change.
  List<SourceEdit> get edits;
  @override

  /// The modification stamp of the file at the moment when the change was
  /// created. Will be -1 if the file did not exist and should be created.
  /// The client may use this field to make sure that the file was not
  /// changed since then, so it is safe to apply the change.
  DateTime get fileStamp;
  @override
  @JsonKey(ignore: true)
  _$$_SourceFileEditCopyWith<_$_SourceFileEdit> get copyWith =>
      throw _privateConstructorUsedError;
}
