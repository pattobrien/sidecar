// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarRequest _$SidecarRequestFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'setActivePackage':
      return SetActivePackageRequest.fromJson(json);
    case 'lint':
      return LintRequest.fromJson(json);
    case 'assist':
      return AssistRequest.fromJson(json);
    case 'quickFix':
      return QuickFixRequest.fromJson(json);
    case 'updateFiles':
      return FileUpdateRequest.fromJson(json);
    case 'setPriorityFiles':
      return SetPriorityFilesRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SidecarRequest',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SidecarRequest {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarRequestCopyWith<$Res> {
  factory $SidecarRequestCopyWith(
          SidecarRequest value, $Res Function(SidecarRequest) then) =
      _$SidecarRequestCopyWithImpl<$Res>;
}

/// @nodoc
class _$SidecarRequestCopyWithImpl<$Res>
    implements $SidecarRequestCopyWith<$Res> {
  _$SidecarRequestCopyWithImpl(this._value, this._then);

  final SidecarRequest _value;
  // ignore: unused_field
  final $Res Function(SidecarRequest) _then;
}

/// @nodoc
abstract class _$$SetActivePackageRequestCopyWith<$Res> {
  factory _$$SetActivePackageRequestCopyWith(_$SetActivePackageRequest value,
          $Res Function(_$SetActivePackageRequest) then) =
      __$$SetActivePackageRequestCopyWithImpl<$Res>;
  $Res call({ActivePackageRoot root, List<Uri>? workspaceScope});

  $ActivePackageRootCopyWith<$Res> get root;
}

/// @nodoc
class __$$SetActivePackageRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$SetActivePackageRequestCopyWith<$Res> {
  __$$SetActivePackageRequestCopyWithImpl(_$SetActivePackageRequest _value,
      $Res Function(_$SetActivePackageRequest) _then)
      : super(_value, (v) => _then(v as _$SetActivePackageRequest));

  @override
  _$SetActivePackageRequest get _value =>
      super._value as _$SetActivePackageRequest;

  @override
  $Res call({
    Object? root = freezed,
    Object? workspaceScope = freezed,
  }) {
    return _then(_$SetActivePackageRequest(
      root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ActivePackageRoot,
      workspaceScope: workspaceScope == freezed
          ? _value._workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }

  @override
  $ActivePackageRootCopyWith<$Res> get root {
    return $ActivePackageRootCopyWith<$Res>(_value.root, (value) {
      return _then(_value.copyWith(root: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SetActivePackageRequest extends SetActivePackageRequest {
  const _$SetActivePackageRequest(this.root,
      {final List<Uri>? workspaceScope, final String? $type})
      : _workspaceScope = workspaceScope,
        $type = $type ?? 'setActivePackage',
        super._();

  factory _$SetActivePackageRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetActivePackageRequestFromJson(json);

  @override
  final ActivePackageRoot root;
  final List<Uri>? _workspaceScope;
  @override
  List<Uri>? get workspaceScope {
    final value = _workspaceScope;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.setActivePackage(root: $root, workspaceScope: $workspaceScope)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetActivePackageRequest &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality()
                .equals(other._workspaceScope, _workspaceScope));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(_workspaceScope));

  @JsonKey(ignore: true)
  @override
  _$$SetActivePackageRequestCopyWith<_$SetActivePackageRequest> get copyWith =>
      __$$SetActivePackageRequestCopyWithImpl<_$SetActivePackageRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return setActivePackage(root, workspaceScope);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return setActivePackage?.call(root, workspaceScope);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setActivePackage != null) {
      return setActivePackage(root, workspaceScope);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return setActivePackage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return setActivePackage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setActivePackage != null) {
      return setActivePackage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SetActivePackageRequestToJson(
      this,
    );
  }
}

abstract class SetActivePackageRequest extends SidecarRequest {
  const factory SetActivePackageRequest(final ActivePackageRoot root,
      {final List<Uri>? workspaceScope}) = _$SetActivePackageRequest;
  const SetActivePackageRequest._() : super._();

  factory SetActivePackageRequest.fromJson(Map<String, dynamic> json) =
      _$SetActivePackageRequest.fromJson;

  ActivePackageRoot get root;
  List<Uri>? get workspaceScope;
  @JsonKey(ignore: true)
  _$$SetActivePackageRequestCopyWith<_$SetActivePackageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LintRequestCopyWith<$Res> {
  factory _$$LintRequestCopyWith(
          _$LintRequest value, $Res Function(_$LintRequest) then) =
      __$$LintRequestCopyWithImpl<$Res>;
  $Res call({List<String> files});
}

/// @nodoc
class __$$LintRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$LintRequestCopyWith<$Res> {
  __$$LintRequestCopyWithImpl(
      _$LintRequest _value, $Res Function(_$LintRequest) _then)
      : super(_value, (v) => _then(v as _$LintRequest));

  @override
  _$LintRequest get _value => super._value as _$LintRequest;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(_$LintRequest(
      files == freezed
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintRequest extends LintRequest {
  const _$LintRequest(final List<String> files, {final String? $type})
      : _files = files,
        $type = $type ?? 'lint',
        super._();

  factory _$LintRequest.fromJson(Map<String, dynamic> json) =>
      _$$LintRequestFromJson(json);

  final List<String> _files;
  @override
  List<String> get files {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.lint(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintRequest &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  _$$LintRequestCopyWith<_$LintRequest> get copyWith =>
      __$$LintRequestCopyWithImpl<_$LintRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return lint(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return lint?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintRequestToJson(
      this,
    );
  }
}

abstract class LintRequest extends SidecarRequest {
  const factory LintRequest(final List<String> files) = _$LintRequest;
  const LintRequest._() : super._();

  factory LintRequest.fromJson(Map<String, dynamic> json) =
      _$LintRequest.fromJson;

  List<String> get files;
  @JsonKey(ignore: true)
  _$$LintRequestCopyWith<_$LintRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistRequestCopyWith<$Res> {
  factory _$$AssistRequestCopyWith(
          _$AssistRequest value, $Res Function(_$AssistRequest) then) =
      __$$AssistRequestCopyWithImpl<$Res>;
  $Res call({AnalyzedFile file, int offset, int length});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$AssistRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$AssistRequestCopyWith<$Res> {
  __$$AssistRequestCopyWithImpl(
      _$AssistRequest _value, $Res Function(_$AssistRequest) _then)
      : super(_value, (v) => _then(v as _$AssistRequest));

  @override
  _$AssistRequest get _value => super._value as _$AssistRequest;

  @override
  $Res call({
    Object? file = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_$AssistRequest(
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
@JsonSerializable()
class _$AssistRequest extends AssistRequest {
  const _$AssistRequest(
      {required this.file,
      required this.offset,
      required this.length,
      final String? $type})
      : $type = $type ?? 'assist',
        super._();

  factory _$AssistRequest.fromJson(Map<String, dynamic> json) =>
      _$$AssistRequestFromJson(json);

  @override
  final AnalyzedFile file;
  @override
  final int offset;
  @override
  final int length;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.assist(file: $file, offset: $offset, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistRequest &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.length, length));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(length));

  @JsonKey(ignore: true)
  @override
  _$$AssistRequestCopyWith<_$AssistRequest> get copyWith =>
      __$$AssistRequestCopyWithImpl<_$AssistRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return assist(file, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return assist?.call(file, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(file, offset, length);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistRequestToJson(
      this,
    );
  }
}

abstract class AssistRequest extends SidecarRequest {
  const factory AssistRequest(
      {required final AnalyzedFile file,
      required final int offset,
      required final int length}) = _$AssistRequest;
  const AssistRequest._() : super._();

  factory AssistRequest.fromJson(Map<String, dynamic> json) =
      _$AssistRequest.fromJson;

  AnalyzedFile get file;
  int get offset;
  int get length;
  @JsonKey(ignore: true)
  _$$AssistRequestCopyWith<_$AssistRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuickFixRequestCopyWith<$Res> {
  factory _$$QuickFixRequestCopyWith(
          _$QuickFixRequest value, $Res Function(_$QuickFixRequest) then) =
      __$$QuickFixRequestCopyWithImpl<$Res>;
  $Res call({AnalyzedFile file, int offset});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$QuickFixRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$QuickFixRequestCopyWith<$Res> {
  __$$QuickFixRequestCopyWithImpl(
      _$QuickFixRequest _value, $Res Function(_$QuickFixRequest) _then)
      : super(_value, (v) => _then(v as _$QuickFixRequest));

  @override
  _$QuickFixRequest get _value => super._value as _$QuickFixRequest;

  @override
  $Res call({
    Object? file = freezed,
    Object? offset = freezed,
  }) {
    return _then(_$QuickFixRequest(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
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
@JsonSerializable()
class _$QuickFixRequest extends QuickFixRequest {
  const _$QuickFixRequest(
      {required this.file, required this.offset, final String? $type})
      : $type = $type ?? 'quickFix',
        super._();

  factory _$QuickFixRequest.fromJson(Map<String, dynamic> json) =>
      _$$QuickFixRequestFromJson(json);

  @override
  final AnalyzedFile file;
  @override
  final int offset;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.quickFix(file: $file, offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickFixRequest &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.offset, offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(offset));

  @JsonKey(ignore: true)
  @override
  _$$QuickFixRequestCopyWith<_$QuickFixRequest> get copyWith =>
      __$$QuickFixRequestCopyWithImpl<_$QuickFixRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return quickFix(file, offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return quickFix?.call(file, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (quickFix != null) {
      return quickFix(file, offset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return quickFix(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return quickFix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (quickFix != null) {
      return quickFix(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickFixRequestToJson(
      this,
    );
  }
}

abstract class QuickFixRequest extends SidecarRequest {
  const factory QuickFixRequest(
      {required final AnalyzedFile file,
      required final int offset}) = _$QuickFixRequest;
  const QuickFixRequest._() : super._();

  factory QuickFixRequest.fromJson(Map<String, dynamic> json) =
      _$QuickFixRequest.fromJson;

  AnalyzedFile get file;
  int get offset;
  @JsonKey(ignore: true)
  _$$QuickFixRequestCopyWith<_$QuickFixRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileUpdateRequestCopyWith<$Res> {
  factory _$$FileUpdateRequestCopyWith(
          _$FileUpdateRequest value, $Res Function(_$FileUpdateRequest) then) =
      __$$FileUpdateRequestCopyWithImpl<$Res>;
  $Res call({List<FileUpdateEvent> updates});
}

/// @nodoc
class __$$FileUpdateRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$FileUpdateRequestCopyWith<$Res> {
  __$$FileUpdateRequestCopyWithImpl(
      _$FileUpdateRequest _value, $Res Function(_$FileUpdateRequest) _then)
      : super(_value, (v) => _then(v as _$FileUpdateRequest));

  @override
  _$FileUpdateRequest get _value => super._value as _$FileUpdateRequest;

  @override
  $Res call({
    Object? updates = freezed,
  }) {
    return _then(_$FileUpdateRequest(
      updates == freezed
          ? _value._updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<FileUpdateEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileUpdateRequest extends FileUpdateRequest {
  const _$FileUpdateRequest(final List<FileUpdateEvent> updates,
      {final String? $type})
      : _updates = updates,
        $type = $type ?? 'updateFiles',
        super._();

  factory _$FileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$$FileUpdateRequestFromJson(json);

  final List<FileUpdateEvent> _updates;
  @override
  List<FileUpdateEvent> get updates {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updates);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.updateFiles(updates: $updates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileUpdateRequest &&
            const DeepCollectionEquality().equals(other._updates, _updates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_updates));

  @JsonKey(ignore: true)
  @override
  _$$FileUpdateRequestCopyWith<_$FileUpdateRequest> get copyWith =>
      __$$FileUpdateRequestCopyWithImpl<_$FileUpdateRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return updateFiles(updates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return updateFiles?.call(updates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (updateFiles != null) {
      return updateFiles(updates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return updateFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return updateFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (updateFiles != null) {
      return updateFiles(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FileUpdateRequestToJson(
      this,
    );
  }
}

abstract class FileUpdateRequest extends SidecarRequest {
  const factory FileUpdateRequest(final List<FileUpdateEvent> updates) =
      _$FileUpdateRequest;
  const FileUpdateRequest._() : super._();

  factory FileUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$FileUpdateRequest.fromJson;

  List<FileUpdateEvent> get updates;
  @JsonKey(ignore: true)
  _$$FileUpdateRequestCopyWith<_$FileUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetPriorityFilesRequestCopyWith<$Res> {
  factory _$$SetPriorityFilesRequestCopyWith(_$SetPriorityFilesRequest value,
          $Res Function(_$SetPriorityFilesRequest) then) =
      __$$SetPriorityFilesRequestCopyWithImpl<$Res>;
  $Res call({Set<AnalyzedFile> files});
}

/// @nodoc
class __$$SetPriorityFilesRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$SetPriorityFilesRequestCopyWith<$Res> {
  __$$SetPriorityFilesRequestCopyWithImpl(_$SetPriorityFilesRequest _value,
      $Res Function(_$SetPriorityFilesRequest) _then)
      : super(_value, (v) => _then(v as _$SetPriorityFilesRequest));

  @override
  _$SetPriorityFilesRequest get _value =>
      super._value as _$SetPriorityFilesRequest;

  @override
  $Res call({
    Object? files = freezed,
  }) {
    return _then(_$SetPriorityFilesRequest(
      files == freezed
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as Set<AnalyzedFile>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetPriorityFilesRequest extends SetPriorityFilesRequest {
  const _$SetPriorityFilesRequest(final Set<AnalyzedFile> files,
      {final String? $type})
      : _files = files,
        $type = $type ?? 'setPriorityFiles',
        super._();

  factory _$SetPriorityFilesRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetPriorityFilesRequestFromJson(json);

  final Set<AnalyzedFile> _files;
  @override
  Set<AnalyzedFile> get files {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_files);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.setPriorityFiles(files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPriorityFilesRequest &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  _$$SetPriorityFilesRequestCopyWith<_$SetPriorityFilesRequest> get copyWith =>
      __$$SetPriorityFilesRequestCopyWithImpl<_$SetPriorityFilesRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)
        setActivePackage,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return setPriorityFiles(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return setPriorityFiles?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ActivePackageRoot root, List<Uri>? workspaceScope)?
        setActivePackage,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setPriorityFiles != null) {
      return setPriorityFiles(files);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActivePackageRequest value) setActivePackage,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return setPriorityFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return setPriorityFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActivePackageRequest value)? setActivePackage,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setPriorityFiles != null) {
      return setPriorityFiles(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SetPriorityFilesRequestToJson(
      this,
    );
  }
}

abstract class SetPriorityFilesRequest extends SidecarRequest {
  const factory SetPriorityFilesRequest(final Set<AnalyzedFile> files) =
      _$SetPriorityFilesRequest;
  const SetPriorityFilesRequest._() : super._();

  factory SetPriorityFilesRequest.fromJson(Map<String, dynamic> json) =
      _$SetPriorityFilesRequest.fromJson;

  Set<AnalyzedFile> get files;
  @JsonKey(ignore: true)
  _$$SetPriorityFilesRequestCopyWith<_$SetPriorityFilesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
