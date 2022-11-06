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
    case 'setActiveRoot':
      return SetActiveRootRequest.fromJson(json);
    case 'setContextCollection':
      return SetContextCollectionRequest.fromJson(json);
    case 'lint':
      return LintRequest.fromJson(json);
    case 'assist':
      return AssistRequest.fromJson(json);
    case 'quickFix':
      return QuickFixRequest.fromJson(json);
    case 'updateFiles':
      return FileUpdateRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SidecarRequest',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SidecarRequest {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
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
abstract class _$$SetActiveRootRequestCopyWith<$Res> {
  factory _$$SetActiveRootRequestCopyWith(_$SetActiveRootRequest value,
          $Res Function(_$SetActiveRootRequest) then) =
      __$$SetActiveRootRequestCopyWithImpl<$Res>;
  $Res call({Uri root});
}

/// @nodoc
class __$$SetActiveRootRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$SetActiveRootRequestCopyWith<$Res> {
  __$$SetActiveRootRequestCopyWithImpl(_$SetActiveRootRequest _value,
      $Res Function(_$SetActiveRootRequest) _then)
      : super(_value, (v) => _then(v as _$SetActiveRootRequest));

  @override
  _$SetActiveRootRequest get _value => super._value as _$SetActiveRootRequest;

  @override
  $Res call({
    Object? root = freezed,
  }) {
    return _then(_$SetActiveRootRequest(
      root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetActiveRootRequest extends SetActiveRootRequest {
  const _$SetActiveRootRequest(this.root, {final String? $type})
      : $type = $type ?? 'setActiveRoot',
        super._();

  factory _$SetActiveRootRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetActiveRootRequestFromJson(json);

  @override
  final Uri root;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.setActiveRoot(root: $root)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetActiveRootRequest &&
            const DeepCollectionEquality().equals(other.root, root));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(root));

  @JsonKey(ignore: true)
  @override
  _$$SetActiveRootRequestCopyWith<_$SetActiveRootRequest> get copyWith =>
      __$$SetActiveRootRequestCopyWithImpl<_$SetActiveRootRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return setActiveRoot(root);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return setActiveRoot?.call(root);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    required TResult orElse(),
  }) {
    if (setActiveRoot != null) {
      return setActiveRoot(root);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return setActiveRoot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return setActiveRoot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    required TResult orElse(),
  }) {
    if (setActiveRoot != null) {
      return setActiveRoot(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SetActiveRootRequestToJson(
      this,
    );
  }
}

abstract class SetActiveRootRequest extends SidecarRequest {
  const factory SetActiveRootRequest(final Uri root) = _$SetActiveRootRequest;
  const SetActiveRootRequest._() : super._();

  factory SetActiveRootRequest.fromJson(Map<String, dynamic> json) =
      _$SetActiveRootRequest.fromJson;

  Uri get root;
  @JsonKey(ignore: true)
  _$$SetActiveRootRequestCopyWith<_$SetActiveRootRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetContextCollectionRequestCopyWith<$Res> {
  factory _$$SetContextCollectionRequestCopyWith(
          _$SetContextCollectionRequest value,
          $Res Function(_$SetContextCollectionRequest) then) =
      __$$SetContextCollectionRequestCopyWithImpl<$Res>;
  $Res call({String mainRoot, List<String> roots});
}

/// @nodoc
class __$$SetContextCollectionRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$SetContextCollectionRequestCopyWith<$Res> {
  __$$SetContextCollectionRequestCopyWithImpl(
      _$SetContextCollectionRequest _value,
      $Res Function(_$SetContextCollectionRequest) _then)
      : super(_value, (v) => _then(v as _$SetContextCollectionRequest));

  @override
  _$SetContextCollectionRequest get _value =>
      super._value as _$SetContextCollectionRequest;

  @override
  $Res call({
    Object? mainRoot = freezed,
    Object? roots = freezed,
  }) {
    return _then(_$SetContextCollectionRequest(
      mainRoot: mainRoot == freezed
          ? _value.mainRoot
          : mainRoot // ignore: cast_nullable_to_non_nullable
              as String,
      roots: roots == freezed
          ? _value._roots
          : roots // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetContextCollectionRequest extends SetContextCollectionRequest {
  const _$SetContextCollectionRequest(
      {required this.mainRoot,
      required final List<String> roots,
      final String? $type})
      : _roots = roots,
        $type = $type ?? 'setContextCollection',
        super._();

  factory _$SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetContextCollectionRequestFromJson(json);

  @override
  final String mainRoot;
  final List<String> _roots;
  @override
  List<String> get roots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roots);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.setContextCollection(mainRoot: $mainRoot, roots: $roots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetContextCollectionRequest &&
            const DeepCollectionEquality().equals(other.mainRoot, mainRoot) &&
            const DeepCollectionEquality().equals(other._roots, _roots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(mainRoot),
      const DeepCollectionEquality().hash(_roots));

  @JsonKey(ignore: true)
  @override
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => __$$SetContextCollectionRequestCopyWithImpl<
          _$SetContextCollectionRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return setContextCollection(mainRoot, roots);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return setContextCollection?.call(mainRoot, roots);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    required TResult orElse(),
  }) {
    if (setContextCollection != null) {
      return setContextCollection(mainRoot, roots);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return setContextCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return setContextCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
    required TResult orElse(),
  }) {
    if (setContextCollection != null) {
      return setContextCollection(this);
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
  const factory SetContextCollectionRequest(
      {required final String mainRoot,
      required final List<String> roots}) = _$SetContextCollectionRequest;
  const SetContextCollectionRequest._() : super._();

  factory SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =
      _$SetContextCollectionRequest.fromJson;

  String get mainRoot;
  List<String> get roots;
  @JsonKey(ignore: true)
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => throw _privateConstructorUsedError;
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
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return lint(files);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return lint?.call(files);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
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
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
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
  $Res call({String filePath, int offset, int length});
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
    Object? filePath = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_$AssistRequest(
      filePath: filePath == freezed
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
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
@JsonSerializable()
class _$AssistRequest extends AssistRequest {
  const _$AssistRequest(
      {required this.filePath,
      required this.offset,
      required this.length,
      final String? $type})
      : $type = $type ?? 'assist',
        super._();

  factory _$AssistRequest.fromJson(Map<String, dynamic> json) =>
      _$$AssistRequestFromJson(json);

// required AnalyzedFile file,
  @override
  final String filePath;
  @override
  final int offset;
  @override
  final int length;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.assist(filePath: $filePath, offset: $offset, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistRequest &&
            const DeepCollectionEquality().equals(other.filePath, filePath) &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.length, length));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filePath),
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(length));

  @JsonKey(ignore: true)
  @override
  _$$AssistRequestCopyWith<_$AssistRequest> get copyWith =>
      __$$AssistRequestCopyWithImpl<_$AssistRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return assist(filePath, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return assist?.call(filePath, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(filePath, offset, length);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
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
      {required final String filePath,
      required final int offset,
      required final int length}) = _$AssistRequest;
  const AssistRequest._() : super._();

  factory AssistRequest.fromJson(Map<String, dynamic> json) =
      _$AssistRequest.fromJson;

// required AnalyzedFile file,
  String get filePath;
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
  $Res call({String filePath, int offset});
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
    Object? filePath = freezed,
    Object? offset = freezed,
  }) {
    return _then(_$QuickFixRequest(
      filePath: filePath == freezed
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickFixRequest extends QuickFixRequest {
  const _$QuickFixRequest(
      {required this.filePath, required this.offset, final String? $type})
      : $type = $type ?? 'quickFix',
        super._();

  factory _$QuickFixRequest.fromJson(Map<String, dynamic> json) =>
      _$$QuickFixRequestFromJson(json);

  @override
  final String filePath;
  @override
  final int offset;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.quickFix(filePath: $filePath, offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickFixRequest &&
            const DeepCollectionEquality().equals(other.filePath, filePath) &&
            const DeepCollectionEquality().equals(other.offset, offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filePath),
      const DeepCollectionEquality().hash(offset));

  @JsonKey(ignore: true)
  @override
  _$$QuickFixRequestCopyWith<_$QuickFixRequest> get copyWith =>
      __$$QuickFixRequestCopyWithImpl<_$QuickFixRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return quickFix(filePath, offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return quickFix?.call(filePath, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
    required TResult orElse(),
  }) {
    if (quickFix != null) {
      return quickFix(filePath, offset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return quickFix(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return quickFix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
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
      {required final String filePath,
      required final int offset}) = _$QuickFixRequest;
  const QuickFixRequest._() : super._();

  factory QuickFixRequest.fromJson(Map<String, dynamic> json) =
      _$QuickFixRequest.fromJson;

  String get filePath;
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
    required TResult Function(Uri root) setActiveRoot,
    required TResult Function(String mainRoot, List<String> roots)
        setContextCollection,
    required TResult Function(List<String> files) lint,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(List<FileUpdateEvent> updates) updateFiles,
  }) {
    return updateFiles(updates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
  }) {
    return updateFiles?.call(updates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri root)? setActiveRoot,
    TResult Function(String mainRoot, List<String> roots)? setContextCollection,
    TResult Function(List<String> files)? lint,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(List<FileUpdateEvent> updates)? updateFiles,
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
    required TResult Function(SetActiveRootRequest value) setActiveRoot,
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(LintRequest value) lint,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) updateFiles,
  }) {
    return updateFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
  }) {
    return updateFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetActiveRootRequest value)? setActiveRoot,
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(LintRequest value)? lint,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? updateFiles,
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
