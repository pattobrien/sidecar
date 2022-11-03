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
    case 'setContextCollection':
      return SetContextCollectionRequest.fromJson(json);
    case 'analyzeFile':
      return AnalyzeFileRequest.fromJson(json);
    case 'assist':
      return AssistRequest.fromJson(json);
    case 'quickFix':
      return QuickFixRequest.fromJson(json);
    case 'fileUpdate':
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
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
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
abstract class _$$SetContextCollectionRequestCopyWith<$Res> {
  factory _$$SetContextCollectionRequestCopyWith(
          _$SetContextCollectionRequest value,
          $Res Function(_$SetContextCollectionRequest) then) =
      __$$SetContextCollectionRequestCopyWithImpl<$Res>;
  $Res call({List<String> roots});
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
    Object? roots = freezed,
  }) {
    return _then(_$SetContextCollectionRequest(
      roots == freezed
          ? _value._roots
          : roots // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetContextCollectionRequest extends SetContextCollectionRequest {
  const _$SetContextCollectionRequest(final List<String> roots,
      {final String? $type})
      : _roots = roots,
        $type = $type ?? 'setContextCollection',
        super._();

  factory _$SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$$SetContextCollectionRequestFromJson(json);

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
    return 'SidecarRequest.setContextCollection(roots: $roots)';
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
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => __$$SetContextCollectionRequestCopyWithImpl<
          _$SetContextCollectionRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) {
    return setContextCollection(roots);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) {
    return setContextCollection?.call(roots);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
    required TResult orElse(),
  }) {
    if (setContextCollection != null) {
      return setContextCollection(roots);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) {
    return setContextCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) {
    return setContextCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
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
  const factory SetContextCollectionRequest(final List<String> roots) =
      _$SetContextCollectionRequest;
  const SetContextCollectionRequest._() : super._();

  factory SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =
      _$SetContextCollectionRequest.fromJson;

  List<String> get roots;
  @JsonKey(ignore: true)
  _$$SetContextCollectionRequestCopyWith<_$SetContextCollectionRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalyzeFileRequestCopyWith<$Res> {
  factory _$$AnalyzeFileRequestCopyWith(_$AnalyzeFileRequest value,
          $Res Function(_$AnalyzeFileRequest) then) =
      __$$AnalyzeFileRequestCopyWithImpl<$Res>;
  $Res call({String filePath});
}

/// @nodoc
class __$$AnalyzeFileRequestCopyWithImpl<$Res>
    extends _$SidecarRequestCopyWithImpl<$Res>
    implements _$$AnalyzeFileRequestCopyWith<$Res> {
  __$$AnalyzeFileRequestCopyWithImpl(
      _$AnalyzeFileRequest _value, $Res Function(_$AnalyzeFileRequest) _then)
      : super(_value, (v) => _then(v as _$AnalyzeFileRequest));

  @override
  _$AnalyzeFileRequest get _value => super._value as _$AnalyzeFileRequest;

  @override
  $Res call({
    Object? filePath = freezed,
  }) {
    return _then(_$AnalyzeFileRequest(
      filePath == freezed
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyzeFileRequest extends AnalyzeFileRequest {
  const _$AnalyzeFileRequest(this.filePath, {final String? $type})
      : $type = $type ?? 'analyzeFile',
        super._();

  factory _$AnalyzeFileRequest.fromJson(Map<String, dynamic> json) =>
      _$$AnalyzeFileRequestFromJson(json);

  @override
  final String filePath;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.analyzeFile(filePath: $filePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyzeFileRequest &&
            const DeepCollectionEquality().equals(other.filePath, filePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(filePath));

  @JsonKey(ignore: true)
  @override
  _$$AnalyzeFileRequestCopyWith<_$AnalyzeFileRequest> get copyWith =>
      __$$AnalyzeFileRequestCopyWithImpl<_$AnalyzeFileRequest>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) {
    return analyzeFile(filePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) {
    return analyzeFile?.call(filePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
    required TResult orElse(),
  }) {
    if (analyzeFile != null) {
      return analyzeFile(filePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) {
    return analyzeFile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) {
    return analyzeFile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
    required TResult orElse(),
  }) {
    if (analyzeFile != null) {
      return analyzeFile(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyzeFileRequestToJson(
      this,
    );
  }
}

abstract class AnalyzeFileRequest extends SidecarRequest {
  const factory AnalyzeFileRequest(final String filePath) =
      _$AnalyzeFileRequest;
  const AnalyzeFileRequest._() : super._();

  factory AnalyzeFileRequest.fromJson(Map<String, dynamic> json) =
      _$AnalyzeFileRequest.fromJson;

  String get filePath;
  @JsonKey(ignore: true)
  _$$AnalyzeFileRequestCopyWith<_$AnalyzeFileRequest> get copyWith =>
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
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) {
    return assist(filePath, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) {
    return assist?.call(filePath, offset, length);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
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
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
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
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) {
    return quickFix(filePath, offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) {
    return quickFix?.call(filePath, offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
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
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) {
    return quickFix(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) {
    return quickFix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
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
  $Res call({FileUpdateEvent event});

  $FileUpdateEventCopyWith<$Res> get event;
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
    Object? event = freezed,
  }) {
    return _then(_$FileUpdateRequest(
      event == freezed
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as FileUpdateEvent,
    ));
  }

  @override
  $FileUpdateEventCopyWith<$Res> get event {
    return $FileUpdateEventCopyWith<$Res>(_value.event, (value) {
      return _then(_value.copyWith(event: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$FileUpdateRequest extends FileUpdateRequest {
  const _$FileUpdateRequest(this.event, {final String? $type})
      : $type = $type ?? 'fileUpdate',
        super._();

  factory _$FileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$$FileUpdateRequestFromJson(json);

  @override
  final FileUpdateEvent event;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarRequest.fileUpdate(event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileUpdateRequest &&
            const DeepCollectionEquality().equals(other.event, event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(event));

  @JsonKey(ignore: true)
  @override
  _$$FileUpdateRequestCopyWith<_$FileUpdateRequest> get copyWith =>
      __$$FileUpdateRequestCopyWithImpl<_$FileUpdateRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> roots) setContextCollection,
    required TResult Function(String filePath) analyzeFile,
    required TResult Function(String filePath, int offset, int length) assist,
    required TResult Function(String filePath, int offset) quickFix,
    required TResult Function(FileUpdateEvent event) fileUpdate,
  }) {
    return fileUpdate(event);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
  }) {
    return fileUpdate?.call(event);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> roots)? setContextCollection,
    TResult Function(String filePath)? analyzeFile,
    TResult Function(String filePath, int offset, int length)? assist,
    TResult Function(String filePath, int offset)? quickFix,
    TResult Function(FileUpdateEvent event)? fileUpdate,
    required TResult orElse(),
  }) {
    if (fileUpdate != null) {
      return fileUpdate(event);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetContextCollectionRequest value)
        setContextCollection,
    required TResult Function(AnalyzeFileRequest value) analyzeFile,
    required TResult Function(AssistRequest value) assist,
    required TResult Function(QuickFixRequest value) quickFix,
    required TResult Function(FileUpdateRequest value) fileUpdate,
  }) {
    return fileUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
  }) {
    return fileUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetContextCollectionRequest value)? setContextCollection,
    TResult Function(AnalyzeFileRequest value)? analyzeFile,
    TResult Function(AssistRequest value)? assist,
    TResult Function(QuickFixRequest value)? quickFix,
    TResult Function(FileUpdateRequest value)? fileUpdate,
    required TResult orElse(),
  }) {
    if (fileUpdate != null) {
      return fileUpdate(this);
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
  const factory FileUpdateRequest(final FileUpdateEvent event) =
      _$FileUpdateRequest;
  const FileUpdateRequest._() : super._();

  factory FileUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$FileUpdateRequest.fromJson;

  FileUpdateEvent get event;
  @JsonKey(ignore: true)
  _$$FileUpdateRequestCopyWith<_$FileUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
