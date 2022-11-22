// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notifications.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarNotification _$SidecarNotificationFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initComplete':
      return InitCompleteNotification.fromJson(json);
    case 'lint':
      return LintNotification.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SidecarNotification',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SidecarNotification {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initComplete,
    required TResult Function(AnalyzedFile file, Set<LintResult> lints) lint,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitCompleteNotification value) initComplete,
    required TResult Function(LintNotification value) lint,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarNotificationCopyWith<$Res> {
  factory $SidecarNotificationCopyWith(
          SidecarNotification value, $Res Function(SidecarNotification) then) =
      _$SidecarNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class _$SidecarNotificationCopyWithImpl<$Res>
    implements $SidecarNotificationCopyWith<$Res> {
  _$SidecarNotificationCopyWithImpl(this._value, this._then);

  final SidecarNotification _value;
  // ignore: unused_field
  final $Res Function(SidecarNotification) _then;
}

/// @nodoc
abstract class _$$InitCompleteNotificationCopyWith<$Res> {
  factory _$$InitCompleteNotificationCopyWith(_$InitCompleteNotification value,
          $Res Function(_$InitCompleteNotification) then) =
      __$$InitCompleteNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitCompleteNotificationCopyWithImpl<$Res>
    extends _$SidecarNotificationCopyWithImpl<$Res>
    implements _$$InitCompleteNotificationCopyWith<$Res> {
  __$$InitCompleteNotificationCopyWithImpl(_$InitCompleteNotification _value,
      $Res Function(_$InitCompleteNotification) _then)
      : super(_value, (v) => _then(v as _$InitCompleteNotification));

  @override
  _$InitCompleteNotification get _value =>
      super._value as _$InitCompleteNotification;
}

/// @nodoc
@JsonSerializable()
class _$InitCompleteNotification extends InitCompleteNotification {
  const _$InitCompleteNotification({final String? $type})
      : $type = $type ?? 'initComplete',
        super._();

  factory _$InitCompleteNotification.fromJson(Map<String, dynamic> json) =>
      _$$InitCompleteNotificationFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarNotification.initComplete()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitCompleteNotification);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initComplete,
    required TResult Function(AnalyzedFile file, Set<LintResult> lints) lint,
  }) {
    return initComplete();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
  }) {
    return initComplete?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
    required TResult orElse(),
  }) {
    if (initComplete != null) {
      return initComplete();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitCompleteNotification value) initComplete,
    required TResult Function(LintNotification value) lint,
  }) {
    return initComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
  }) {
    return initComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
    required TResult orElse(),
  }) {
    if (initComplete != null) {
      return initComplete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitCompleteNotificationToJson(
      this,
    );
  }
}

abstract class InitCompleteNotification extends SidecarNotification {
  const factory InitCompleteNotification() = _$InitCompleteNotification;
  const InitCompleteNotification._() : super._();

  factory InitCompleteNotification.fromJson(Map<String, dynamic> json) =
      _$InitCompleteNotification.fromJson;
}

/// @nodoc
abstract class _$$LintNotificationCopyWith<$Res> {
  factory _$$LintNotificationCopyWith(
          _$LintNotification value, $Res Function(_$LintNotification) then) =
      __$$LintNotificationCopyWithImpl<$Res>;
  $Res call({AnalyzedFile file, Set<LintResult> lints});

  $AnalyzedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$$LintNotificationCopyWithImpl<$Res>
    extends _$SidecarNotificationCopyWithImpl<$Res>
    implements _$$LintNotificationCopyWith<$Res> {
  __$$LintNotificationCopyWithImpl(
      _$LintNotification _value, $Res Function(_$LintNotification) _then)
      : super(_value, (v) => _then(v as _$LintNotification));

  @override
  _$LintNotification get _value => super._value as _$LintNotification;

  @override
  $Res call({
    Object? file = freezed,
    Object? lints = freezed,
  }) {
    return _then(_$LintNotification(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as AnalyzedFile,
      lints == freezed
          ? _value._lints
          : lints // ignore: cast_nullable_to_non_nullable
              as Set<LintResult>,
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
class _$LintNotification extends LintNotification {
  const _$LintNotification(this.file, final Set<LintResult> lints,
      {final String? $type})
      : _lints = lints,
        $type = $type ?? 'lint',
        super._();

  factory _$LintNotification.fromJson(Map<String, dynamic> json) =>
      _$$LintNotificationFromJson(json);

  @override
  final AnalyzedFile file;
  final Set<LintResult> _lints;
  @override
  Set<LintResult> get lints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_lints);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarNotification.lint(file: $file, lints: $lints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintNotification &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other._lints, _lints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(_lints));

  @JsonKey(ignore: true)
  @override
  _$$LintNotificationCopyWith<_$LintNotification> get copyWith =>
      __$$LintNotificationCopyWithImpl<_$LintNotification>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initComplete,
    required TResult Function(AnalyzedFile file, Set<LintResult> lints) lint,
  }) {
    return lint(file, lints);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
  }) {
    return lint?.call(file, lints);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initComplete,
    TResult Function(AnalyzedFile file, Set<LintResult> lints)? lint,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(file, lints);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitCompleteNotification value) initComplete,
    required TResult Function(LintNotification value) lint,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    TResult Function(LintNotification value)? lint,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintNotificationToJson(
      this,
    );
  }
}

abstract class LintNotification extends SidecarNotification {
  const factory LintNotification(
          final AnalyzedFile file, final Set<LintResult> lints) =
      _$LintNotification;
  const LintNotification._() : super._();

  factory LintNotification.fromJson(Map<String, dynamic> json) =
      _$LintNotification.fromJson;

  AnalyzedFile get file;
  Set<LintResult> get lints;
  @JsonKey(ignore: true)
  _$$LintNotificationCopyWith<_$LintNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
