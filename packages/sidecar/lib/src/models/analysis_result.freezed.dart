// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisResult {
  SidecarBase get rule => throw _privateConstructorUsedError;
  SourceSpan get sourceSpan => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get correction => throw _privateConstructorUsedError;
  SourceSpan? get highlightedSpan => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarBase rule, SourceSpan sourceSpan,
            String message, String? correction, SourceSpan? highlightedSpan)
        generic,
    required TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)
        dart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericAnalysisResult value) generic,
    required TResult Function(DartAnalysisResult value) dart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisResultCopyWith<AnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisResultCopyWith<$Res> {
  factory $AnalysisResultCopyWith(
          AnalysisResult value, $Res Function(AnalysisResult) then) =
      _$AnalysisResultCopyWithImpl<$Res>;
  $Res call(
      {SidecarBase rule,
      SourceSpan sourceSpan,
      String message,
      String? correction,
      SourceSpan? highlightedSpan});
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  final AnalysisResult _value;
  // ignore: unused_field
  final $Res Function(AnalysisResult) _then;

  @override
  $Res call({
    Object? rule = freezed,
    Object? sourceSpan = freezed,
    Object? message = freezed,
    Object? correction = freezed,
    Object? highlightedSpan = freezed,
  }) {
    return _then(_value.copyWith(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as SidecarBase,
      sourceSpan: sourceSpan == freezed
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      highlightedSpan: highlightedSpan == freezed
          ? _value.highlightedSpan
          : highlightedSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan?,
    ));
  }
}

/// @nodoc
abstract class _$$GenericAnalysisResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$GenericAnalysisResultCopyWith(_$GenericAnalysisResult value,
          $Res Function(_$GenericAnalysisResult) then) =
      __$$GenericAnalysisResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {SidecarBase rule,
      SourceSpan sourceSpan,
      String message,
      String? correction,
      SourceSpan? highlightedSpan});
}

/// @nodoc
class __$$GenericAnalysisResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$GenericAnalysisResultCopyWith<$Res> {
  __$$GenericAnalysisResultCopyWithImpl(_$GenericAnalysisResult _value,
      $Res Function(_$GenericAnalysisResult) _then)
      : super(_value, (v) => _then(v as _$GenericAnalysisResult));

  @override
  _$GenericAnalysisResult get _value => super._value as _$GenericAnalysisResult;

  @override
  $Res call({
    Object? rule = freezed,
    Object? sourceSpan = freezed,
    Object? message = freezed,
    Object? correction = freezed,
    Object? highlightedSpan = freezed,
  }) {
    return _then(_$GenericAnalysisResult(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as SidecarBase,
      sourceSpan: sourceSpan == freezed
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      highlightedSpan: highlightedSpan == freezed
          ? _value.highlightedSpan
          : highlightedSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan?,
    ));
  }
}

/// @nodoc

class _$GenericAnalysisResult extends GenericAnalysisResult {
  const _$GenericAnalysisResult(
      {required this.rule,
      required this.sourceSpan,
      required this.message,
      this.correction,
      this.highlightedSpan})
      : super._();

  @override
  final SidecarBase rule;
  @override
  final SourceSpan sourceSpan;
  @override
  final String message;
  @override
  final String? correction;
  @override
  final SourceSpan? highlightedSpan;

  @override
  String toString() {
    return 'AnalysisResult.generic(rule: $rule, sourceSpan: $sourceSpan, message: $message, correction: $correction, highlightedSpan: $highlightedSpan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericAnalysisResult &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality()
                .equals(other.sourceSpan, sourceSpan) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.correction, correction) &&
            const DeepCollectionEquality()
                .equals(other.highlightedSpan, highlightedSpan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(sourceSpan),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(correction),
      const DeepCollectionEquality().hash(highlightedSpan));

  @JsonKey(ignore: true)
  @override
  _$$GenericAnalysisResultCopyWith<_$GenericAnalysisResult> get copyWith =>
      __$$GenericAnalysisResultCopyWithImpl<_$GenericAnalysisResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarBase rule, SourceSpan sourceSpan,
            String message, String? correction, SourceSpan? highlightedSpan)
        generic,
    required TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)
        dart,
  }) {
    return generic(rule, sourceSpan, message, correction, highlightedSpan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
  }) {
    return generic?.call(
        rule, sourceSpan, message, correction, highlightedSpan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(rule, sourceSpan, message, correction, highlightedSpan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericAnalysisResult value) generic,
    required TResult Function(DartAnalysisResult value) dart,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class GenericAnalysisResult extends AnalysisResult {
  const factory GenericAnalysisResult(
      {required final SidecarBase rule,
      required final SourceSpan sourceSpan,
      required final String message,
      final String? correction,
      final SourceSpan? highlightedSpan}) = _$GenericAnalysisResult;
  const GenericAnalysisResult._() : super._();

  @override
  SidecarBase get rule;
  @override
  SourceSpan get sourceSpan;
  @override
  String get message;
  @override
  String? get correction;
  @override
  SourceSpan? get highlightedSpan;
  @override
  @JsonKey(ignore: true)
  _$$GenericAnalysisResultCopyWith<_$GenericAnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DartAnalysisResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$DartAnalysisResultCopyWith(_$DartAnalysisResult value,
          $Res Function(_$DartAnalysisResult) then) =
      __$$DartAnalysisResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {ResolvedUnitResult unit,
      SidecarBase rule,
      SourceSpan sourceSpan,
      String message,
      String? correction,
      SourceSpan? highlightedSpan});
}

/// @nodoc
class __$$DartAnalysisResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$DartAnalysisResultCopyWith<$Res> {
  __$$DartAnalysisResultCopyWithImpl(
      _$DartAnalysisResult _value, $Res Function(_$DartAnalysisResult) _then)
      : super(_value, (v) => _then(v as _$DartAnalysisResult));

  @override
  _$DartAnalysisResult get _value => super._value as _$DartAnalysisResult;

  @override
  $Res call({
    Object? unit = freezed,
    Object? rule = freezed,
    Object? sourceSpan = freezed,
    Object? message = freezed,
    Object? correction = freezed,
    Object? highlightedSpan = freezed,
  }) {
    return _then(_$DartAnalysisResult(
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ResolvedUnitResult,
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as SidecarBase,
      sourceSpan: sourceSpan == freezed
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      highlightedSpan: highlightedSpan == freezed
          ? _value.highlightedSpan
          : highlightedSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan?,
    ));
  }
}

/// @nodoc

class _$DartAnalysisResult extends DartAnalysisResult {
  const _$DartAnalysisResult(
      {required this.unit,
      required this.rule,
      required this.sourceSpan,
      required this.message,
      this.correction,
      this.highlightedSpan})
      : super._();

  @override
  final ResolvedUnitResult unit;
  @override
  final SidecarBase rule;
  @override
  final SourceSpan sourceSpan;
  @override
  final String message;
  @override
  final String? correction;
  @override
  final SourceSpan? highlightedSpan;

  @override
  String toString() {
    return 'AnalysisResult.dart(unit: $unit, rule: $rule, sourceSpan: $sourceSpan, message: $message, correction: $correction, highlightedSpan: $highlightedSpan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartAnalysisResult &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality()
                .equals(other.sourceSpan, sourceSpan) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.correction, correction) &&
            const DeepCollectionEquality()
                .equals(other.highlightedSpan, highlightedSpan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(sourceSpan),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(correction),
      const DeepCollectionEquality().hash(highlightedSpan));

  @JsonKey(ignore: true)
  @override
  _$$DartAnalysisResultCopyWith<_$DartAnalysisResult> get copyWith =>
      __$$DartAnalysisResultCopyWithImpl<_$DartAnalysisResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarBase rule, SourceSpan sourceSpan,
            String message, String? correction, SourceSpan? highlightedSpan)
        generic,
    required TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)
        dart,
  }) {
    return dart(unit, rule, sourceSpan, message, correction, highlightedSpan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
  }) {
    return dart?.call(
        unit, rule, sourceSpan, message, correction, highlightedSpan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarBase rule, SourceSpan sourceSpan, String message,
            String? correction, SourceSpan? highlightedSpan)?
        generic,
    TResult Function(
            ResolvedUnitResult unit,
            SidecarBase rule,
            SourceSpan sourceSpan,
            String message,
            String? correction,
            SourceSpan? highlightedSpan)?
        dart,
    required TResult orElse(),
  }) {
    if (dart != null) {
      return dart(unit, rule, sourceSpan, message, correction, highlightedSpan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericAnalysisResult value) generic,
    required TResult Function(DartAnalysisResult value) dart,
  }) {
    return dart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
  }) {
    return dart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericAnalysisResult value)? generic,
    TResult Function(DartAnalysisResult value)? dart,
    required TResult orElse(),
  }) {
    if (dart != null) {
      return dart(this);
    }
    return orElse();
  }
}

abstract class DartAnalysisResult extends AnalysisResult {
  const factory DartAnalysisResult(
      {required final ResolvedUnitResult unit,
      required final SidecarBase rule,
      required final SourceSpan sourceSpan,
      required final String message,
      final String? correction,
      final SourceSpan? highlightedSpan}) = _$DartAnalysisResult;
  const DartAnalysisResult._() : super._();

  ResolvedUnitResult get unit;
  @override
  SidecarBase get rule;
  @override
  SourceSpan get sourceSpan;
  @override
  String get message;
  @override
  String? get correction;
  @override
  SourceSpan? get highlightedSpan;
  @override
  @JsonKey(ignore: true)
  _$$DartAnalysisResultCopyWith<_$DartAnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}
