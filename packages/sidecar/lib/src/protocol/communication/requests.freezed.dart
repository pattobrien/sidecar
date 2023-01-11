// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'requests.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarRequest _$SidecarRequestFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'setWorkspaceScope':
      return SetContextCollectionRequest.fromJson(json);
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
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
      _$SidecarRequestCopyWithImpl<$Res, SidecarRequest>;
}

/// @nodoc
class _$SidecarRequestCopyWithImpl<$Res, $Val extends SidecarRequest>
    implements $SidecarRequestCopyWith<$Res> {
  _$SidecarRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SetContextCollectionRequestCopyWith<$Res> {
  factory _$$SetContextCollectionRequestCopyWith(
          _$SetContextCollectionRequest value,
          $Res Function(_$SetContextCollectionRequest) then) =
      __$$SetContextCollectionRequestCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uri>? roots});
}

/// @nodoc
class __$$SetContextCollectionRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$SetContextCollectionRequest>
    implements _$$SetContextCollectionRequestCopyWith<$Res> {
  __$$SetContextCollectionRequestCopyWithImpl(
      _$SetContextCollectionRequest _value,
      $Res Function(_$SetContextCollectionRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roots = freezed,
  }) {
    return _then(_$SetContextCollectionRequest(
      freezed == roots
          ? _value._roots
          : roots // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetContextCollectionRequest extends SetContextCollectionRequest {
  const _$SetContextCollectionRequest(final List<Uri>? roots,
      {final String? $type})
      : _roots = roots,
        $type = $type ?? 'setWorkspaceScope',
        super._();

  factory _$SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetContextCollectionRequestFromJson(json);

  final List<Uri>? _roots;
  @override
  List<Uri>? get roots {
    final value = _roots;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.setWorkspaceScope(roots: $roots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetContextCollectionRequest &&
            const DeepCollectionEquality().equals(other._roots, _roots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_roots));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => __$$SetContextCollectionRequestCopyWithImpl<
          _$SetContextCollectionRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
    required TResult Function(List<String> files) lint,
    required TResult Function(AnalyzedFile file, int offset, int length) assist,
    required TResult Function(AnalyzedFile file, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
    required TResult Function(Set<AnalyzedFile> files) setPriorityFiles,
  }) {
    return setWorkspaceScope(roots);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return setWorkspaceScope?.call(roots);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
    TResult Function(List<String> files)? lint,
    TResult Function(AnalyzedFile file, int offset, int length)? assist,
    TResult Function(AnalyzedFile file, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult Function(Set<AnalyzedFile> files)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setWorkspaceScope != null) {
      return setWorkspaceScope(roots);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
    required TResult Function(SetPriorityFilesRequest value) setPriorityFiles,
  }) {
    return setWorkspaceScope(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return setWorkspaceScope?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    TResult Function(SetPriorityFilesRequest value)? setPriorityFiles,
    required TResult orElse(),
  }) {
    if (setWorkspaceScope != null) {
      return setWorkspaceScope(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SetContextCollectionRequestToJson(
      this,
    );
  }
}

abstract class SetContextCollectionRequest extends SidecarRequest {
  const factory SetContextCollectionRequest(final List<Uri>? roots) =
      _$SetContextCollectionRequest;
  const SetContextCollectionRequest._() : super._();

  factory SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =
      _$SetContextCollectionRequest.fromJson;

  List<Uri>? get roots;
  @JsonKey(ignore: true)
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LintRequestCopyWith<$Res> {
  factory _$$LintRequestCopyWith(
          _$LintRequest value, $Res Function(_$LintRequest) then) =
      __$$LintRequestCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> files});
}

/// @nodoc
class __$$LintRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$LintRequest>
    implements _$$LintRequestCopyWith<$Res> {
  __$$LintRequestCopyWithImpl(
      _$LintRequest _value, $Res Function(_$LintRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$LintRequest(
      null == files
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
  @pragma('vm:prefer-inline')
  _$$LintRequestCopyWith<_$LintRequest> get copyWith =>
      __$$LintRequestCopyWithImpl<_$LintRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
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
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return lint?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
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
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
  @useResult
  $Res call({AnalyzedFile file, int offset, int length});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$AssistRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$AssistRequest>
    implements _$$AssistRequestCopyWith<$Res> {
  __$$AssistRequestCopyWithImpl(
      _$AssistRequest _value, $Res Function(_$AssistRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? offset = null,
    Object? length = null,
  }) {
    return _then(_$AssistRequest(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.file, file) || other.file == file) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, file, offset, length);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistRequestCopyWith<_$AssistRequest> get copyWith =>
      __$$AssistRequestCopyWithImpl<_$AssistRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
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
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return assist?.call(file, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
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
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
  @useResult
  $Res call({AnalyzedFile file, int offset});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$QuickFixRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$QuickFixRequest>
    implements _$$QuickFixRequestCopyWith<$Res> {
  __$$QuickFixRequestCopyWithImpl(
      _$QuickFixRequest _value, $Res Function(_$QuickFixRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? offset = null,
  }) {
    return _then(_$QuickFixRequest(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.file, file) || other.file == file) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, file, offset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickFixRequestCopyWith<_$QuickFixRequest> get copyWith =>
      __$$QuickFixRequestCopyWithImpl<_$QuickFixRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
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
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return quickFix?.call(file, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
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
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return quickFix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
  @useResult
  $Res call({List<FileUpdateEvent> updates});
}

/// @nodoc
class __$$FileUpdateRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$FileUpdateRequest>
    implements _$$FileUpdateRequestCopyWith<$Res> {
  __$$FileUpdateRequestCopyWithImpl(
      _$FileUpdateRequest _value, $Res Function(_$FileUpdateRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updates = null,
  }) {
    return _then(_$FileUpdateRequest(
      null == updates
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
  @pragma('vm:prefer-inline')
  _$$FileUpdateRequestCopyWith<_$FileUpdateRequest> get copyWith =>
      __$$FileUpdateRequestCopyWithImpl<_$FileUpdateRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
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
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return updateFiles?.call(updates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
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
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return updateFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
  @useResult
  $Res call({Set<AnalyzedFile> files});
}

/// @nodoc
class __$$SetPriorityFilesRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res, _$SetPriorityFilesRequest>
    implements _$$SetPriorityFilesRequestCopyWith<$Res> {
  __$$SetPriorityFilesRequestCopyWithImpl(_$SetPriorityFilesRequest _value,
      $Res Function(_$SetPriorityFilesRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
  }) {
    return _then(_$SetPriorityFilesRequest(
      null == files
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
  @pragma('vm:prefer-inline')
  _$$SetPriorityFilesRequestCopyWith<_$SetPriorityFilesRequest> get copyWith =>
      __$$SetPriorityFilesRequestCopyWithImpl<_$SetPriorityFilesRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri>? roots) setWorkspaceScope,
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
    TResult? Function(List<Uri>? roots)? setWorkspaceScope,
    TResult? Function(List<String> files)? lint,
    TResult? Function(AnalyzedFile file, int offset, int length)? assist,
    TResult? Function(AnalyzedFile file, int offset)? quickFix,
    TResult? Function(List<FileUpdateEvent> updates)? updateFiles,
    TResult? Function(Set<AnalyzedFile> files)? setPriorityFiles,
  }) {
    return setPriorityFiles?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri>? roots)? setWorkspaceScope,
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
    required TResult Function(SetContextCollectionRequest value)
        setWorkspaceScope,
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
    TResult? Function(SetContextCollectionRequest value)? setWorkspaceScope,
    TResult? Function(LintRequest value)? lint,
    TResult? Function(AssistRequest value)? assist,
    TResult? Function(QuickFixRequest value)? quickFix,
    TResult? Function(FileUpdateRequest value)? updateFiles,
    TResult? Function(SetPriorityFilesRequest value)? setPriorityFiles,
  }) {
    return setPriorityFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setWorkspaceScope,
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
