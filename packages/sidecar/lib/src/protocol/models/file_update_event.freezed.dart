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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String filePath, String contents) add,
    required TResult Function(SourceFileEdit fileEdit) modify,
    required TResult Function(String filePath) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
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
}

/// @nodoc
abstract class $FileUpdateEventCopyWith<$Res> {
  factory $FileUpdateEventCopyWith(
          FileUpdateEvent value, $Res Function(FileUpdateEvent) then) =
      _$FileUpdateEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$FileUpdateEventCopyWithImpl<$Res>
    implements $FileUpdateEventCopyWith<$Res> {
  _$FileUpdateEventCopyWithImpl(this._value, this._then);

  final FileUpdateEvent _value;
  // ignore: unused_field
  final $Res Function(FileUpdateEvent) _then;
}

/// @nodoc
abstract class _$$AddEventCopyWith<$Res> {
  factory _$$AddEventCopyWith(
          _$AddEvent value, $Res Function(_$AddEvent) then) =
      __$$AddEventCopyWithImpl<$Res>;
  $Res call({String filePath, String contents});
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
    Object? filePath = freezed,
    Object? contents = freezed,
  }) {
    return _then(_$AddEvent(
      filePath == freezed
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
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
  const _$AddEvent(this.filePath, this.contents, {final String? $type})
      : $type = $type ?? 'add',
        super._();

  factory _$AddEvent.fromJson(Map<String, dynamic> json) =>
      _$$AddEventFromJson(json);

  @override
  final String filePath;
  @override
  final String contents;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.add(filePath: $filePath, contents: $contents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddEvent &&
            const DeepCollectionEquality().equals(other.filePath, filePath) &&
            const DeepCollectionEquality().equals(other.contents, contents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filePath),
      const DeepCollectionEquality().hash(contents));

  @JsonKey(ignore: true)
  @override
  _$$AddEventCopyWith<_$AddEvent> get copyWith =>
      __$$AddEventCopyWithImpl<_$AddEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String filePath, String contents) add,
    required TResult Function(SourceFileEdit fileEdit) modify,
    required TResult Function(String filePath) delete,
  }) {
    return add(filePath, contents);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
  }) {
    return add?.call(filePath, contents);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(filePath, contents);
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
  const factory AddEvent(final String filePath, final String contents) =
      _$AddEvent;
  const AddEvent._() : super._();

  factory AddEvent.fromJson(Map<String, dynamic> json) = _$AddEvent.fromJson;

  String get filePath;
  String get contents;
  @JsonKey(ignore: true)
  _$$AddEventCopyWith<_$AddEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ModifyEventCopyWith<$Res> {
  factory _$$ModifyEventCopyWith(
          _$ModifyEvent value, $Res Function(_$ModifyEvent) then) =
      __$$ModifyEventCopyWithImpl<$Res>;
  $Res call({SourceFileEdit fileEdit});

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
    Object? fileEdit = freezed,
  }) {
    return _then(_$ModifyEvent(
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
  const _$ModifyEvent(this.fileEdit, {final String? $type})
      : $type = $type ?? 'modify',
        super._();

  factory _$ModifyEvent.fromJson(Map<String, dynamic> json) =>
      _$$ModifyEventFromJson(json);

  @override
  final SourceFileEdit fileEdit;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.modify(fileEdit: $fileEdit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifyEvent &&
            const DeepCollectionEquality().equals(other.fileEdit, fileEdit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(fileEdit));

  @JsonKey(ignore: true)
  @override
  _$$ModifyEventCopyWith<_$ModifyEvent> get copyWith =>
      __$$ModifyEventCopyWithImpl<_$ModifyEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String filePath, String contents) add,
    required TResult Function(SourceFileEdit fileEdit) modify,
    required TResult Function(String filePath) delete,
  }) {
    return modify(fileEdit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
  }) {
    return modify?.call(fileEdit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
    required TResult orElse(),
  }) {
    if (modify != null) {
      return modify(fileEdit);
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
  const factory ModifyEvent(final SourceFileEdit fileEdit) = _$ModifyEvent;
  const ModifyEvent._() : super._();

  factory ModifyEvent.fromJson(Map<String, dynamic> json) =
      _$ModifyEvent.fromJson;

  SourceFileEdit get fileEdit;
  @JsonKey(ignore: true)
  _$$ModifyEventCopyWith<_$ModifyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteEventCopyWith<$Res> {
  factory _$$DeleteEventCopyWith(
          _$DeleteEvent value, $Res Function(_$DeleteEvent) then) =
      __$$DeleteEventCopyWithImpl<$Res>;
  $Res call({String filePath});
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
    Object? filePath = freezed,
  }) {
    return _then(_$DeleteEvent(
      filePath == freezed
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteEvent extends DeleteEvent {
  const _$DeleteEvent(this.filePath, {final String? $type})
      : $type = $type ?? 'delete',
        super._();

  factory _$DeleteEvent.fromJson(Map<String, dynamic> json) =>
      _$$DeleteEventFromJson(json);

  @override
  final String filePath;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FileUpdateEvent.delete(filePath: $filePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteEvent &&
            const DeepCollectionEquality().equals(other.filePath, filePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(filePath));

  @JsonKey(ignore: true)
  @override
  _$$DeleteEventCopyWith<_$DeleteEvent> get copyWith =>
      __$$DeleteEventCopyWithImpl<_$DeleteEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String filePath, String contents) add,
    required TResult Function(SourceFileEdit fileEdit) modify,
    required TResult Function(String filePath) delete,
  }) {
    return delete(filePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
  }) {
    return delete?.call(filePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String filePath, String contents)? add,
    TResult Function(SourceFileEdit fileEdit)? modify,
    TResult Function(String filePath)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(filePath);
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
  const factory DeleteEvent(final String filePath) = _$DeleteEvent;
  const DeleteEvent._() : super._();

  factory DeleteEvent.fromJson(Map<String, dynamic> json) =
      _$DeleteEvent.fromJson;

  String get filePath;
  @JsonKey(ignore: true)
  _$$DeleteEventCopyWith<_$DeleteEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
