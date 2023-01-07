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

AnalysisResult _$AnalysisResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return LintResult.fromJson(json);
    case 'withEdits':
      return LintResultWithEdits.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AnalysisResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AnalysisResult {
  RuleCode get rule => throw _privateConstructorUsedError;
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  LintSeverity get severity => throw _privateConstructorUsedError;
  String? get correction => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(LintResult value) $default, {
    required TResult Function(LintResultWithEdits value) withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction});

  $RuleCodeCopyWith<$Res> get rule;
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
    Object? span = freezed,
    Object? message = freezed,
    Object? severity = freezed,
    Object? correction = freezed,
  }) {
    return _then(_value.copyWith(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $RuleCodeCopyWith<$Res> get rule {
    return $RuleCodeCopyWith<$Res>(_value.rule, (value) {
      return _then(_value.copyWith(rule: value));
    });
  }
}

/// @nodoc
abstract class _$$LintResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$LintResultCopyWith(
          _$LintResult value, $Res Function(_$LintResult) then) =
      __$$LintResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction,
      @JsonKey(ignore: true)
          EditsComputer? editsComputer});

  @override
  $RuleCodeCopyWith<$Res> get rule;
}

/// @nodoc
class __$$LintResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$LintResultCopyWith<$Res> {
  __$$LintResultCopyWithImpl(
      _$LintResult _value, $Res Function(_$LintResult) _then)
      : super(_value, (v) => _then(v as _$LintResult));

  @override
  _$LintResult get _value => super._value as _$LintResult;

  @override
  $Res call({
    Object? rule = freezed,
    Object? span = freezed,
    Object? message = freezed,
    Object? severity = freezed,
    Object? correction = freezed,
    Object? editsComputer = freezed,
  }) {
    return _then(_$LintResult(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      editsComputer: editsComputer == freezed
          ? _value.editsComputer
          : editsComputer // ignore: cast_nullable_to_non_nullable
              as EditsComputer?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintResult extends LintResult {
  const _$LintResult(
      {required this.rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      required this.message,
      required this.severity,
      this.correction,
      @JsonKey(ignore: true)
          this.editsComputer,
      final String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$LintResult.fromJson(Map<String, dynamic> json) =>
      _$$LintResultFromJson(json);

  @override
  final RuleCode rule;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  final SourceSpan span;
  @override
  final String message;
  @override
  final LintSeverity severity;
  @override
  final String? correction;
  @override
  @JsonKey(ignore: true)
  final EditsComputer? editsComputer;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult(rule: $rule, span: $span, message: $message, severity: $severity, correction: $correction, editsComputer: $editsComputer)';
  }

  @JsonKey(ignore: true)
  @override
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      __$$LintResultCopyWithImpl<_$LintResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        withEdits,
  }) {
    return $default(rule, span, message, severity, correction, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
  }) {
    return $default?.call(
        rule, span, message, severity, correction, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(rule, span, message, severity, correction, editsComputer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(LintResult value) $default, {
    required TResult Function(LintResultWithEdits value) withEdits,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintResultToJson(
      this,
    );
  }
}

abstract class LintResult extends AnalysisResult
    implements Comparable<AnalysisResult> {
  const factory LintResult(
      {required final RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      required final String message,
      required final LintSeverity severity,
      final String? correction,
      @JsonKey(ignore: true)
          final EditsComputer? editsComputer}) = _$LintResult;
  const LintResult._() : super._();

  factory LintResult.fromJson(Map<String, dynamic> json) =
      _$LintResult.fromJson;

  @override
  RuleCode get rule;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  @override
  String get message;
  @override
  LintSeverity get severity;
  @override
  String? get correction;
  @JsonKey(ignore: true)
  EditsComputer? get editsComputer;
  @override
  @JsonKey(ignore: true)
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LintResultWithEditsCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$LintResultWithEditsCopyWith(_$LintResultWithEdits value,
          $Res Function(_$LintResultWithEdits) then) =
      __$$LintResultWithEditsCopyWithImpl<$Res>;
  @override
  $Res call(
      {RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction,
      List<EditResult> edits});

  @override
  $RuleCodeCopyWith<$Res> get rule;
}

/// @nodoc
class __$$LintResultWithEditsCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$LintResultWithEditsCopyWith<$Res> {
  __$$LintResultWithEditsCopyWithImpl(
      _$LintResultWithEdits _value, $Res Function(_$LintResultWithEdits) _then)
      : super(_value, (v) => _then(v as _$LintResultWithEdits));

  @override
  _$LintResultWithEdits get _value => super._value as _$LintResultWithEdits;

  @override
  $Res call({
    Object? rule = freezed,
    Object? span = freezed,
    Object? message = freezed,
    Object? severity = freezed,
    Object? correction = freezed,
    Object? edits = freezed,
  }) {
    return _then(_$LintResultWithEdits(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintResultWithEdits extends LintResultWithEdits {
  const _$LintResultWithEdits(
      {required this.rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      required this.message,
      required this.severity,
      this.correction,
      required final List<EditResult> edits,
      final String? $type})
      : _edits = edits,
        $type = $type ?? 'withEdits',
        super._();

  factory _$LintResultWithEdits.fromJson(Map<String, dynamic> json) =>
      _$$LintResultWithEditsFromJson(json);

  @override
  final RuleCode rule;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  final SourceSpan span;
  @override
  final String message;
  @override
  final LintSeverity severity;
  @override
  final String? correction;
  final List<EditResult> _edits;
  @override
  List<EditResult> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult.withEdits(rule: $rule, span: $span, message: $message, severity: $severity, correction: $correction, edits: $edits)';
  }

  @JsonKey(ignore: true)
  @override
  _$$LintResultWithEditsCopyWith<_$LintResultWithEdits> get copyWith =>
      __$$LintResultWithEditsCopyWithImpl<_$LintResultWithEdits>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        withEdits,
  }) {
    return withEdits(rule, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
  }) {
    return withEdits?.call(rule, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) {
    if (withEdits != null) {
      return withEdits(rule, span, message, severity, correction, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(LintResult value) $default, {
    required TResult Function(LintResultWithEdits value) withEdits,
  }) {
    return withEdits(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
  }) {
    return withEdits?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(LintResult value)? $default, {
    TResult Function(LintResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) {
    if (withEdits != null) {
      return withEdits(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintResultWithEditsToJson(
      this,
    );
  }
}

abstract class LintResultWithEdits extends AnalysisResult
    implements Comparable<AnalysisResult> {
  const factory LintResultWithEdits(
      {required final RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      required final String message,
      required final LintSeverity severity,
      final String? correction,
      required final List<EditResult> edits}) = _$LintResultWithEdits;
  const LintResultWithEdits._() : super._();

  factory LintResultWithEdits.fromJson(Map<String, dynamic> json) =
      _$LintResultWithEdits.fromJson;

  @override
  RuleCode get rule;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  @override
  String get message;
  @override
  LintSeverity get severity;
  @override
  String? get correction;
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$LintResultWithEditsCopyWith<_$LintResultWithEdits> get copyWith =>
      throw _privateConstructorUsedError;
}
