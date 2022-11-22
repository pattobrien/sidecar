// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'file_update_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileUpdateEvent _$FileUpdateEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'add':
      return AddEvent.fromJson(json);
    case 'modify':
      return ModifyEvent.fromJson(json);
    case 'delete':
      return DeleteEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'FileUpdateEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$FileUpdateEvent {
  AnalyzedFile get file => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AnalyzedFile file, String contents) add,
    required TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)
        modify,
    required TResult Function(AnalyzedFile file) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddEvent value) add,
    required TResult Function(ModifyEvent value) modify,
    required TResult Function(DeleteEvent value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileUpdateEventCopyWith<FileUpdateEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileUpdateEventCopyWith<$Res> {
  factory $FileUpdateEventCopyWith(
          FileUpdateEvent value, $Res Function(FileUpdateEvent) then) =
      _$FileUpdateEventCopyWithImpl<$Res>;
  $Res call({AnalyzedFile file});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class _$FileUpdateEventCopyWithImpl<$Res>
    implements $FileUpdateEventCopyWith<$Res> {
  _$FileUpdateEventCopyWithImpl(this._value, this._then);

  final FileUpdateEvent _value;
  // ignore: unused_field
  final $Res Function(FileUpdateEvent) _then;

  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$AddEventCopyWith<$Res>
    implements $FileUpdateEventCopyWith<$Res> {
  factory _$$AddEventCopyWith(
          _$AddEvent value, $Res Function(_$AddEvent) then) =
      __$$AddEventCopyWithImpl<$Res>;
  @override
  $Res call({AnalyzedFile file, String contents});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$AddEventCopyWithImpl<$Res> extends _$FileUpdateEventCopyWithImpl<$Res>
    implements _$$AddEventCopyWith<$Res> {
  __$$AddEventCopyWithImpl(_$AddEvent _value, $Res Function(_$AddEvent) _then)
      : super(_value, (v) => _then(v as _$AddEvent));

  @override
  _$AddEvent get _value => super._value as _$AddEvent;

  @override
  $Res call({
    Object? file = freezed,
    Object? contents = freezed,
  }) {
    return _then(_$AddEvent(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      contents == freezed
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddEvent extends AddEvent {
  const _$AddEvent(this.file, this.contents, {final String? $type})
      : $type = $type ?? 'add',
        super._();

  factory _$AddEvent.fromJson(Map<String, dynamic> json) =>
      _$$AddEventFromJson(json);

  @override
  final AnalyzedFile file;
  @override
  final String contents;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.add(file: $file, contents: $contents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddEvent &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(contents));

  @JsonKey(ignore: true)
  @override
  _$$AddEventCopyWith<_$AddEvent> get copyWith =>
      __$$AddEventCopyWithImpl<_$AddEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AnalyzedFile file, String contents) add,
    required TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)
        modify,
    required TResult Function(AnalyzedFile file) delete,
  }) {
    return add(file, contents);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
  }) {
    return add?.call(file, contents);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(file, contents);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddEvent value) add,
    required TResult Function(ModifyEvent value) modify,
    required TResult Function(DeleteEvent value) delete,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AddEventToJson(
      this,
    );
  }
}

abstract class AddEvent extends FileUpdateEvent {
  const factory AddEvent(final AnalyzedFile file, final String contents) =
      _$AddEvent;
  const AddEvent._() : super._();

  factory AddEvent.fromJson(Map<String, dynamic> json) = _$AddEvent.fromJson;

  @override
  AnalyzedFile get file;
  String get contents;
  @override
  @JsonKey(ignore: true)
  _$$AddEventCopyWith<_$AddEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ModifyEventCopyWith<$Res>
    implements $FileUpdateEventCopyWith<$Res> {
  factory _$$ModifyEventCopyWith(
          _$ModifyEvent value, $Res Function(_$ModifyEvent) then) =
      __$$ModifyEventCopyWithImpl<$Res>;
  @override
  $Res call({AnalyzedFile file, SourceFileEdit fileEdit});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
  $SourceFileEditCopyWith<$Res> get fileEdit;
}

/// @nodoc
class __$$ModifyEventCopyWithImpl<$Res>
    extends _$FileUpdateEventCopyWithImpl<$Res>
    implements _$$ModifyEventCopyWith<$Res> {
  __$$ModifyEventCopyWithImpl(
      _$ModifyEvent _value, $Res Function(_$ModifyEvent) _then)
      : super(_value, (v) => _then(v as _$ModifyEvent));

  @override
  _$ModifyEvent get _value => super._value as _$ModifyEvent;

  @override
  $Res call({
    Object? file = freezed,
    Object? fileEdit = freezed,
  }) {
    return _then(_$ModifyEvent(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      fileEdit == freezed
          ? _value.fileEdit
          : fileEdit // ignore: cast_nullable_to_non_nullable
              as SourceFileEdit,
    ));
  }

  @override
  $SourceFileEditCopyWith<$Res> get fileEdit {
    return $SourceFileEditCopyWith<$Res>(_value.fileEdit, (value) {
      return _then(_value.copyWith(fileEdit: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ModifyEvent extends ModifyEvent {
  const _$ModifyEvent(this.file, this.fileEdit, {final String? $type})
      : $type = $type ?? 'modify',
        super._();

  factory _$ModifyEvent.fromJson(Map<String, dynamic> json) =>
      _$$ModifyEventFromJson(json);

  @override
  final AnalyzedFile file;
  @override
  final SourceFileEdit fileEdit;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.modify(file: $file, fileEdit: $fileEdit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifyEvent &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.fileEdit, fileEdit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(fileEdit));

  @JsonKey(ignore: true)
  @override
  _$$ModifyEventCopyWith<_$ModifyEvent> get copyWith =>
      __$$ModifyEventCopyWithImpl<_$ModifyEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AnalyzedFile file, String contents) add,
    required TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)
        modify,
    required TResult Function(AnalyzedFile file) delete,
  }) {
    return modify(file, fileEdit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
  }) {
    return modify?.call(file, fileEdit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
    required TResult orElse(),
  }) {
    if (modify != null) {
      return modify(file, fileEdit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddEvent value) add,
    required TResult Function(ModifyEvent value) modify,
    required TResult Function(DeleteEvent value) delete,
  }) {
    return modify(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
  }) {
    return modify?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (modify != null) {
      return modify(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ModifyEventToJson(
      this,
    );
  }
}

abstract class ModifyEvent extends FileUpdateEvent {
  const factory ModifyEvent(
      final AnalyzedFile file, final SourceFileEdit fileEdit) = _$ModifyEvent;
  const ModifyEvent._() : super._();

  factory ModifyEvent.fromJson(Map<String, dynamic> json) =
      _$ModifyEvent.fromJson;

  @override
  AnalyzedFile get file;
  SourceFileEdit get fileEdit;
  @override
  @JsonKey(ignore: true)
  _$$ModifyEventCopyWith<_$ModifyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteEventCopyWith<$Res>
    implements $FileUpdateEventCopyWith<$Res> {
  factory _$$DeleteEventCopyWith(
          _$DeleteEvent value, $Res Function(_$DeleteEvent) then) =
      __$$DeleteEventCopyWithImpl<$Res>;
  @override
  $Res call({AnalyzedFile file});

  @override
  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$DeleteEventCopyWithImpl<$Res>
    extends _$FileUpdateEventCopyWithImpl<$Res>
    implements _$$DeleteEventCopyWith<$Res> {
  __$$DeleteEventCopyWithImpl(
      _$DeleteEvent _value, $Res Function(_$DeleteEvent) _then)
      : super(_value, (v) => _then(v as _$DeleteEvent));

  @override
  _$DeleteEvent get _value => super._value as _$DeleteEvent;

  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_$DeleteEvent(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteEvent extends DeleteEvent {
  const _$DeleteEvent(this.file, {final String? $type})
      : $type = $type ?? 'delete',
        super._();

  factory _$DeleteEvent.fromJson(Map<String, dynamic> json) =>
      _$$DeleteEventFromJson(json);

  @override
  final AnalyzedFile file;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.delete(file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteEvent &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  _$$DeleteEventCopyWith<_$DeleteEvent> get copyWith =>
      __$$DeleteEventCopyWithImpl<_$DeleteEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AnalyzedFile file, String contents) add,
    required TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)
        modify,
    required TResult Function(AnalyzedFile file) delete,
  }) {
    return delete(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
  }) {
    return delete?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AnalyzedFile file, String contents)? add,
    TResult Function(AnalyzedFile file, SourceFileEdit fileEdit)? modify,
    TResult Function(AnalyzedFile file)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddEvent value) add,
    required TResult Function(ModifyEvent value) modify,
    required TResult Function(DeleteEvent value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddEvent value)? add,
    TResult Function(ModifyEvent value)? modify,
    TResult Function(DeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteEventToJson(
      this,
    );
  }
}

abstract class DeleteEvent extends FileUpdateEvent {
  const factory DeleteEvent(final AnalyzedFile file) = _$DeleteEvent;
  const DeleteEvent._() : super._();

  factory DeleteEvent.fromJson(Map<String, dynamic> json) =
      _$DeleteEvent.fromJson;

  @override
  AnalyzedFile get file;
  @override
  @JsonKey(ignore: true)
  _$$DeleteEventCopyWith<_$DeleteEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
