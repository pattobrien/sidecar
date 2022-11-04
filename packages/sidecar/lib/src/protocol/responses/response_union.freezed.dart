// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'response_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarResponse _$SidecarResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'contextCollection':
      return ContextCollectionResponse.fromJson(json);
    case 'assist':
      return AssistResponse.fromJson(json);
    case 'quickFix':
      return QuickFixResponse.fromJson(json);
    case 'lint':
      return LintResponse.fromJson(json);
    case 'updateFiles':
      return UpdateFilesResponse.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SidecarResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SidecarResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarResponseCopyWith<$Res> {
  factory $SidecarResponseCopyWith(
          SidecarResponse value, $Res Function(SidecarResponse) then) =
      _$SidecarResponseCopyWithImpl<$Res>;
}

/// @nodoc
class _$SidecarResponseCopyWithImpl<$Res>
    implements $SidecarResponseCopyWith<$Res> {
  _$SidecarResponseCopyWithImpl(this._value, this._then);

  final SidecarResponse _value;
  // ignore: unused_field
  final $Res Function(SidecarResponse) _then;
}

/// @nodoc
abstract class _$$ContextCollectionResponseCopyWith<$Res> {
  factory _$$ContextCollectionResponseCopyWith(
          _$ContextCollectionResponse value,
          $Res Function(_$ContextCollectionResponse) then) =
      __$$ContextCollectionResponseCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContextCollectionResponseCopyWithImpl<$Res>
    extends _$SidecarResponseCopyWithImpl<$Res>
    implements _$$ContextCollectionResponseCopyWith<$Res> {
  __$$ContextCollectionResponseCopyWithImpl(_$ContextCollectionResponse _value,
      $Res Function(_$ContextCollectionResponse) _then)
      : super(_value, (v) => _then(v as _$ContextCollectionResponse));

  @override
  _$ContextCollectionResponse get _value =>
      super._value as _$ContextCollectionResponse;
}

/// @nodoc
@JsonSerializable()
class _$ContextCollectionResponse extends ContextCollectionResponse {
  const _$ContextCollectionResponse({final String? $type})
      : $type = $type ?? 'contextCollection',
        super._();

  factory _$ContextCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$$ContextCollectionResponseFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarResponse.contextCollection()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContextCollectionResponse);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) {
    return contextCollection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) {
    return contextCollection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) {
    if (contextCollection != null) {
      return contextCollection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) {
    return contextCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) {
    return contextCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) {
    if (contextCollection != null) {
      return contextCollection(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextCollectionResponseToJson(
      this,
    );
  }
}

abstract class ContextCollectionResponse extends SidecarResponse {
  const factory ContextCollectionResponse() = _$ContextCollectionResponse;
  const ContextCollectionResponse._() : super._();

  factory ContextCollectionResponse.fromJson(Map<String, dynamic> json) =
      _$ContextCollectionResponse.fromJson;
}

/// @nodoc
abstract class _$$AssistResponseCopyWith<$Res> {
  factory _$$AssistResponseCopyWith(
          _$AssistResponse value, $Res Function(_$AssistResponse) then) =
      __$$AssistResponseCopyWithImpl<$Res>;
  $Res call({List<AssistResult> results});
}

/// @nodoc
class __$$AssistResponseCopyWithImpl<$Res>
    extends _$SidecarResponseCopyWithImpl<$Res>
    implements _$$AssistResponseCopyWith<$Res> {
  __$$AssistResponseCopyWithImpl(
      _$AssistResponse _value, $Res Function(_$AssistResponse) _then)
      : super(_value, (v) => _then(v as _$AssistResponse));

  @override
  _$AssistResponse get _value => super._value as _$AssistResponse;

  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_$AssistResponse(
      results == freezed
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<AssistResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistResponse extends AssistResponse {
  const _$AssistResponse(final List<AssistResult> results,
      {final String? $type})
      : _results = results,
        $type = $type ?? 'assist',
        super._();

  factory _$AssistResponse.fromJson(Map<String, dynamic> json) =>
      _$$AssistResponseFromJson(json);

  final List<AssistResult> _results;
  @override
  List<AssistResult> get results {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarResponse.assist(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistResponse &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  _$$AssistResponseCopyWith<_$AssistResponse> get copyWith =>
      __$$AssistResponseCopyWithImpl<_$AssistResponse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) {
    return assist(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) {
    return assist?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistResponseToJson(
      this,
    );
  }
}

abstract class AssistResponse extends SidecarResponse {
  const factory AssistResponse(final List<AssistResult> results) =
      _$AssistResponse;
  const AssistResponse._() : super._();

  factory AssistResponse.fromJson(Map<String, dynamic> json) =
      _$AssistResponse.fromJson;

  List<AssistResult> get results;
  @JsonKey(ignore: true)
  _$$AssistResponseCopyWith<_$AssistResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuickFixResponseCopyWith<$Res> {
  factory _$$QuickFixResponseCopyWith(
          _$QuickFixResponse value, $Res Function(_$QuickFixResponse) then) =
      __$$QuickFixResponseCopyWithImpl<$Res>;
  $Res call({List<LintResultWithEdits> results});
}

/// @nodoc
class __$$QuickFixResponseCopyWithImpl<$Res>
    extends _$SidecarResponseCopyWithImpl<$Res>
    implements _$$QuickFixResponseCopyWith<$Res> {
  __$$QuickFixResponseCopyWithImpl(
      _$QuickFixResponse _value, $Res Function(_$QuickFixResponse) _then)
      : super(_value, (v) => _then(v as _$QuickFixResponse));

  @override
  _$QuickFixResponse get _value => super._value as _$QuickFixResponse;

  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_$QuickFixResponse(
      results == freezed
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<LintResultWithEdits>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickFixResponse extends QuickFixResponse {
  const _$QuickFixResponse(final List<LintResultWithEdits> results,
      {final String? $type})
      : _results = results,
        $type = $type ?? 'quickFix',
        super._();

  factory _$QuickFixResponse.fromJson(Map<String, dynamic> json) =>
      _$$QuickFixResponseFromJson(json);

  final List<LintResultWithEdits> _results;
  @override
  List<LintResultWithEdits> get results {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarResponse.quickFix(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickFixResponse &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  _$$QuickFixResponseCopyWith<_$QuickFixResponse> get copyWith =>
      __$$QuickFixResponseCopyWithImpl<_$QuickFixResponse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) {
    return quickFix(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) {
    return quickFix?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) {
    if (quickFix != null) {
      return quickFix(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) {
    return quickFix(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) {
    return quickFix?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) {
    if (quickFix != null) {
      return quickFix(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickFixResponseToJson(
      this,
    );
  }
}

abstract class QuickFixResponse extends SidecarResponse {
  const factory QuickFixResponse(final List<LintResultWithEdits> results) =
      _$QuickFixResponse;
  const QuickFixResponse._() : super._();

  factory QuickFixResponse.fromJson(Map<String, dynamic> json) =
      _$QuickFixResponse.fromJson;

  List<LintResultWithEdits> get results;
  @JsonKey(ignore: true)
  _$$QuickFixResponseCopyWith<_$QuickFixResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LintResponseCopyWith<$Res> {
  factory _$$LintResponseCopyWith(
          _$LintResponse value, $Res Function(_$LintResponse) then) =
      __$$LintResponseCopyWithImpl<$Res>;
  $Res call({List<LintResult> lints});
}

/// @nodoc
class __$$LintResponseCopyWithImpl<$Res>
    extends _$SidecarResponseCopyWithImpl<$Res>
    implements _$$LintResponseCopyWith<$Res> {
  __$$LintResponseCopyWithImpl(
      _$LintResponse _value, $Res Function(_$LintResponse) _then)
      : super(_value, (v) => _then(v as _$LintResponse));

  @override
  _$LintResponse get _value => super._value as _$LintResponse;

  @override
  $Res call({
    Object? lints = freezed,
  }) {
    return _then(_$LintResponse(
      lints == freezed
          ? _value._lints
          : lints // ignore: cast_nullable_to_non_nullable
              as List<LintResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintResponse extends LintResponse {
  const _$LintResponse(final List<LintResult> lints, {final String? $type})
      : _lints = lints,
        $type = $type ?? 'lint',
        super._();

  factory _$LintResponse.fromJson(Map<String, dynamic> json) =>
      _$$LintResponseFromJson(json);

  final List<LintResult> _lints;
  @override
  List<LintResult> get lints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lints);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarResponse.lint(lints: $lints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintResponse &&
            const DeepCollectionEquality().equals(other._lints, _lints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lints));

  @JsonKey(ignore: true)
  @override
  _$$LintResponseCopyWith<_$LintResponse> get copyWith =>
      __$$LintResponseCopyWithImpl<_$LintResponse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) {
    return lint(lints);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) {
    return lint?.call(lints);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(lints);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintResponseToJson(
      this,
    );
  }
}

abstract class LintResponse extends SidecarResponse {
  const factory LintResponse(final List<LintResult> lints) = _$LintResponse;
  const LintResponse._() : super._();

  factory LintResponse.fromJson(Map<String, dynamic> json) =
      _$LintResponse.fromJson;

  List<LintResult> get lints;
  @JsonKey(ignore: true)
  _$$LintResponseCopyWith<_$LintResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateFilesResponseCopyWith<$Res> {
  factory _$$UpdateFilesResponseCopyWith(_$UpdateFilesResponse value,
          $Res Function(_$UpdateFilesResponse) then) =
      __$$UpdateFilesResponseCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateFilesResponseCopyWithImpl<$Res>
    extends _$SidecarResponseCopyWithImpl<$Res>
    implements _$$UpdateFilesResponseCopyWith<$Res> {
  __$$UpdateFilesResponseCopyWithImpl(
      _$UpdateFilesResponse _value, $Res Function(_$UpdateFilesResponse) _then)
      : super(_value, (v) => _then(v as _$UpdateFilesResponse));

  @override
  _$UpdateFilesResponse get _value => super._value as _$UpdateFilesResponse;
}

/// @nodoc
@JsonSerializable()
class _$UpdateFilesResponse extends UpdateFilesResponse {
  const _$UpdateFilesResponse({final String? $type})
      : $type = $type ?? 'updateFiles',
        super._();

  factory _$UpdateFilesResponse.fromJson(Map<String, dynamic> json) =>
      _$$UpdateFilesResponseFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarResponse.updateFiles()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateFilesResponse);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() contextCollection,
    required TResult Function(List<AssistResult> results) assist,
    required TResult Function(List<LintResultWithEdits> results) quickFix,
    required TResult Function(List<LintResult> lints) lint,
    required TResult Function() updateFiles,
  }) {
    return updateFiles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
  }) {
    return updateFiles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? contextCollection,
    TResult Function(List<AssistResult> results)? assist,
    TResult Function(List<LintResultWithEdits> results)? quickFix,
    TResult Function(List<LintResult> lints)? lint,
    TResult Function()? updateFiles,
    required TResult orElse(),
  }) {
    if (updateFiles != null) {
      return updateFiles();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContextCollectionResponse value)
        contextCollection,
    required TResult Function(AssistResponse value) assist,
    required TResult Function(QuickFixResponse value) quickFix,
    required TResult Function(LintResponse value) lint,
    required TResult Function(UpdateFilesResponse value) updateFiles,
  }) {
    return updateFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
  }) {
    return updateFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContextCollectionResponse value)? contextCollection,
    TResult Function(AssistResponse value)? assist,
    TResult Function(QuickFixResponse value)? quickFix,
    TResult Function(LintResponse value)? lint,
    TResult Function(UpdateFilesResponse value)? updateFiles,
    required TResult orElse(),
  }) {
    if (updateFiles != null) {
      return updateFiles(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateFilesResponseToJson(
      this,
    );
  }
}

abstract class UpdateFilesResponse extends SidecarResponse {
  const factory UpdateFilesResponse() = _$UpdateFilesResponse;
  const UpdateFilesResponse._() : super._();

  factory UpdateFilesResponse.fromJson(Map<String, dynamic> json) =
      _$UpdateFilesResponse.fromJson;
}
