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
      _$SourceFileEditCopyWithImpl<$Res>;
  $Res call({Uri file, List<SourceEdit> edits, DateTime fileStamp});
}

/// @nodoc
class _$SourceFileEditCopyWithImpl<$Res>
    implements $SourceFileEditCopyWith<$Res> {
  _$SourceFileEditCopyWithImpl(this._value, this._then);

  final SourceFileEdit _value;
  // ignore: unused_field
  final $Res Function(SourceFileEdit) _then;

  @override
  $Res call({
    Object? file = freezed,
    Object? edits = freezed,
    Object? fileStamp = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uri,
      edits: edits == freezed
          ? _value.edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<SourceEdit>,
      fileStamp: fileStamp == freezed
          ? _value.fileStamp
          : fileStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_SourceFileEditCopyWith<$Res>
    implements $SourceFileEditCopyWith<$Res> {
  factory _$$_SourceFileEditCopyWith(
          _$_SourceFileEdit value, $Res Function(_$_SourceFileEdit) then) =
      __$$_SourceFileEditCopyWithImpl<$Res>;
  @override
  $Res call({Uri file, List<SourceEdit> edits, DateTime fileStamp});
}

/// @nodoc
class __$$_SourceFileEditCopyWithImpl<$Res>
    extends _$SourceFileEditCopyWithImpl<$Res>
    implements _$$_SourceFileEditCopyWith<$Res> {
  __$$_SourceFileEditCopyWithImpl(
      _$_SourceFileEdit _value, $Res Function(_$_SourceFileEdit) _then)
      : super(_value, (v) => _then(v as _$_SourceFileEdit));

  @override
  _$_SourceFileEdit get _value => super._value as _$_SourceFileEdit;

  @override
  $Res call({
    Object? file = freezed,
    Object? edits = freezed,
    Object? fileStamp = freezed,
  }) {
    return _then(_$_SourceFileEdit(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as Uri,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<SourceEdit>,
      fileStamp: fileStamp == freezed
          ? _value.fileStamp
          : fileStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SourceFileEdit extends _SourceFileEdit {
  const _$_SourceFileEdit(
      {required this.file,
      required final List<SourceEdit> edits,
      required this.fileStamp})
      : _edits = edits,
        super._();

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
    return 'SourceFileEdit(file: $file, edits: $edits, fileStamp: $fileStamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SourceFileEdit &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other._edits, _edits) &&
            const DeepCollectionEquality().equals(other.fileStamp, fileStamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(_edits),
      const DeepCollectionEquality().hash(fileStamp));

  @JsonKey(ignore: true)
  @override
  _$$_SourceFileEditCopyWith<_$_SourceFileEdit> get copyWith =>
      __$$_SourceFileEditCopyWithImpl<_$_SourceFileEdit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SourceFileEditToJson(
      this,
    );
  }
}

abstract class _SourceFileEdit extends SourceFileEdit {
  const factory _SourceFileEdit(
      {required final Uri file,
      required final List<SourceEdit> edits,
      required final DateTime fileStamp}) = _$_SourceFileEdit;
  const _SourceFileEdit._() : super._();

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
