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
    case 'lint':
      return LintResult.fromJson(json);
    case 'lintWithEdits':
      return LintWithEditsResult.fromJson(json);
    case 'totalData':
      return TotalDataResult.fromJson(json);
    case 'singleData':
      return SingleDataResult.fromJson(json);
    case 'assist':
      return AssistResult.fromJson(json);
    case 'assistWithEdits':
      return AssistWithEditsResult.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AnalysisResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AnalysisResult {
  RuleCode get code => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(LintResult value)? $default, {
    TResult? Function(LintResultWithEdits value)? withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
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
      _$AnalysisResultCopyWithImpl<$Res, AnalysisResult>;
  @useResult
  $Res call(
      {RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res, $Val extends AnalysisResult>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? span = null,
    Object? message = null,
    Object? severity = null,
    Object? correction = freezed,
  }) {
    return _then(_value.copyWith(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: freezed == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RuleCodeCopyWith<$Res> get rule {
    return $RuleCodeCopyWith<$Res>(_value.rule, (value) {
      return _then(_value.copyWith(rule: value) as $Val);
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
  @useResult
  $Res call(
      {RuleCode code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction,
      @JsonKey(ignore: true)
          EditsComputer? editsComputer});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$LintResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$LintResult>
    implements _$$LintResultCopyWith<$Res> {
  __$$LintResultCopyWithImpl(
      _$LintResult _value, $Res Function(_$LintResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? span = null,
    Object? message = null,
    Object? severity = null,
    Object? correction = freezed,
    Object? editsComputer = freezed,
  }) {
    return _then(_$LintResult(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: freezed == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      editsComputer: freezed == editsComputer
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
      {required this.code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      required this.message,
      required this.severity,
      this.correction,
      @JsonKey(ignore: true)
          this.editsComputer,
      final String? $type})
      : $type = $type ?? 'lint',
        super._();

  factory _$LintResult.fromJson(Map<String, dynamic> json) =>
      _$$LintResultFromJson(json);

  @override
  final RuleCode code;
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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintResult &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.correction, correction) ||
                other.correction == correction) &&
            (identical(other.editsComputer, editsComputer) ||
                other.editsComputer == editsComputer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, rule, span, message, severity, correction, editsComputer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      __$$LintResultCopyWithImpl<_$LintResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return lint(code, span, message, severity, correction, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return lint?.call(code, span, message, severity, correction, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(code, span, message, severity, correction, editsComputer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(LintResult value)? $default, {
    TResult? Function(LintResultWithEdits value)? withEdits,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
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
      {required final RuleCode code,
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
  RuleCode get code;
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  String get message;
  LintSeverity get severity;
  String? get correction;
  @JsonKey(ignore: true)
  EditsComputer? get editsComputer;
  @override
  @JsonKey(ignore: true)
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LintWithEditsResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$LintWithEditsResultCopyWith(_$LintWithEditsResult value,
          $Res Function(_$LintWithEditsResult) then) =
      __$$LintWithEditsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      String message,
      LintSeverity severity,
      String? correction,
      List<EditResult> edits});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$LintResultWithEditsCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$LintResultWithEdits>
    implements _$$LintResultWithEditsCopyWith<$Res> {
  __$$LintResultWithEditsCopyWithImpl(
      _$LintResultWithEdits _value, $Res Function(_$LintResultWithEdits) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? span = null,
    Object? message = null,
    Object? severity = null,
    Object? correction = freezed,
    Object? edits = null,
  }) {
    return _then(_$LintResultWithEdits(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: freezed == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      edits: null == edits
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintWithEditsResult extends LintWithEditsResult {
  const _$LintWithEditsResult(
      {required this.code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      required this.message,
      required this.severity,
      this.correction,
      required final List<EditResult> edits,
      final String? $type})
      : _edits = edits,
        $type = $type ?? 'lintWithEdits',
        super._();

  factory _$LintWithEditsResult.fromJson(Map<String, dynamic> json) =>
      _$$LintWithEditsResultFromJson(json);

  @override
  final RuleCode code;
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

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintResultWithEdits &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.correction, correction) ||
                other.correction == correction) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rule, span, message, severity,
      correction, const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LintResultWithEditsCopyWith<_$LintResultWithEdits> get copyWith =>
      __$$LintResultWithEditsCopyWithImpl<_$LintResultWithEdits>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return lintWithEdits(code, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return lintWithEdits?.call(
        code, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (lintWithEdits != null) {
      return lintWithEdits(code, span, message, severity, correction, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return lintWithEdits(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(LintResult value)? $default, {
    TResult? Function(LintResultWithEdits value)? withEdits,
  }) {
    return lintWithEdits?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (lintWithEdits != null) {
      return lintWithEdits(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintWithEditsResultToJson(
      this,
    );
  }
}

abstract class LintWithEditsResult extends AnalysisResult
    implements Comparable<AnalysisResult> {
  const factory LintWithEditsResult(
      {required final RuleCode code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      required final String message,
      required final LintSeverity severity,
      final String? correction,
      required final List<EditResult> edits}) = _$LintWithEditsResult;
  const LintWithEditsResult._() : super._();

  factory LintWithEditsResult.fromJson(Map<String, dynamic> json) =
      _$LintWithEditsResult.fromJson;

  @override
  RuleCode get code;
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  String get message;
  LintSeverity get severity;
  String? get correction;
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$LintWithEditsResultCopyWith<_$LintWithEditsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TotalDataResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$TotalDataResultCopyWith(
          _$TotalDataResult value, $Res Function(_$TotalDataResult) then) =
      __$$TotalDataResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RuleCode code, List<Object> data});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$TotalDataResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$TotalDataResult>
    implements _$$TotalDataResultCopyWith<$Res> {
  __$$TotalDataResultCopyWithImpl(
      _$TotalDataResult _value, $Res Function(_$TotalDataResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? data = null,
  }) {
    return _then(_$TotalDataResult(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Object>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TotalDataResult extends TotalDataResult {
  const _$TotalDataResult(
      {required this.code,
      required final List<Object> data,
      final String? $type})
      : _data = data,
        $type = $type ?? 'totalData',
        super._();

  factory _$TotalDataResult.fromJson(Map<String, dynamic> json) =>
      _$$TotalDataResultFromJson(json);

  @override
  final RuleCode code;
  final List<Object> _data;
  @override
  List<Object> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult.totalData(code: $code, data: $data)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TotalDataResultCopyWith<_$TotalDataResult> get copyWith =>
      __$$TotalDataResultCopyWithImpl<_$TotalDataResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return totalData(code, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return totalData?.call(code, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (totalData != null) {
      return totalData(code, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return totalData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintResult value)? lint,
    TResult? Function(LintWithEditsResult value)? lintWithEdits,
    TResult? Function(TotalDataResult value)? totalData,
    TResult? Function(SingleDataResult value)? singleData,
    TResult? Function(AssistResult value)? assist,
    TResult? Function(AssistWithEditsResult value)? assistWithEdits,
  }) {
    return totalData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (totalData != null) {
      return totalData(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TotalDataResultToJson(
      this,
    );
  }
}

abstract class TotalDataResult extends AnalysisResult {
  const factory TotalDataResult(
      {required final RuleCode code,
      required final List<Object> data}) = _$TotalDataResult;
  const TotalDataResult._() : super._();

  factory TotalDataResult.fromJson(Map<String, dynamic> json) =
      _$TotalDataResult.fromJson;

  @override
  RuleCode get code;
  List<Object> get data;
  @override
  @JsonKey(ignore: true)
  _$$TotalDataResultCopyWith<_$TotalDataResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SingleDataResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$SingleDataResultCopyWith(
          _$SingleDataResult value, $Res Function(_$SingleDataResult) then) =
      __$$SingleDataResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RuleCode code, Object data});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$SingleDataResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$SingleDataResult>
    implements _$$SingleDataResultCopyWith<$Res> {
  __$$SingleDataResultCopyWithImpl(
      _$SingleDataResult _value, $Res Function(_$SingleDataResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? data = null,
  }) {
    return _then(_$SingleDataResult(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      data: null == data ? _value.data : data,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SingleDataResult extends SingleDataResult {
  const _$SingleDataResult(
      {required this.code, required this.data, final String? $type})
      : $type = $type ?? 'singleData',
        super._();

  factory _$SingleDataResult.fromJson(Map<String, dynamic> json) =>
      _$$SingleDataResultFromJson(json);

  @override
  final RuleCode code;
  @override
  final Object data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult.singleData(code: $code, data: $data)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleDataResultCopyWith<_$SingleDataResult> get copyWith =>
      __$$SingleDataResultCopyWithImpl<_$SingleDataResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return singleData(code, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return singleData?.call(code, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (singleData != null) {
      return singleData(code, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return singleData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintResult value)? lint,
    TResult? Function(LintWithEditsResult value)? lintWithEdits,
    TResult? Function(TotalDataResult value)? totalData,
    TResult? Function(SingleDataResult value)? singleData,
    TResult? Function(AssistResult value)? assist,
    TResult? Function(AssistWithEditsResult value)? assistWithEdits,
  }) {
    return singleData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (singleData != null) {
      return singleData(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SingleDataResultToJson(
      this,
    );
  }
}

abstract class SingleDataResult extends AnalysisResult {
  const factory SingleDataResult(
      {required final RuleCode code,
      required final Object data}) = _$SingleDataResult;
  const SingleDataResult._() : super._();

  factory SingleDataResult.fromJson(Map<String, dynamic> json) =
      _$SingleDataResult.fromJson;

  @override
  RuleCode get code;
  Object get data;
  @override
  @JsonKey(ignore: true)
  _$$SingleDataResultCopyWith<_$SingleDataResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AssistResultCopyWith(
          _$AssistResult value, $Res Function(_$AssistResult) then) =
      __$$AssistResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      @JsonKey(ignore: true)
          EditsComputer? editsComputer});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$AssistResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$AssistResult>
    implements _$$AssistResultCopyWith<$Res> {
  __$$AssistResultCopyWithImpl(
      _$AssistResult _value, $Res Function(_$AssistResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? span = null,
    Object? editsComputer = freezed,
  }) {
    return _then(_$AssistResult(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      editsComputer: freezed == editsComputer
          ? _value.editsComputer
          : editsComputer // ignore: cast_nullable_to_non_nullable
              as EditsComputer?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistResult extends AssistResult {
  const _$AssistResult(
      {required this.code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      @JsonKey(ignore: true)
          this.editsComputer,
      final String? $type})
      : $type = $type ?? 'assist',
        super._();

  factory _$AssistResult.fromJson(Map<String, dynamic> json) =>
      _$$AssistResultFromJson(json);

  @override
  final RuleCode code;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  final SourceSpan span;
  @override
  @JsonKey(ignore: true)
  final EditsComputer? editsComputer;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult.assist(code: $code, span: $span, editsComputer: $editsComputer)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistResultCopyWith<_$AssistResult> get copyWith =>
      __$$AssistResultCopyWithImpl<_$AssistResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return assist(code, span, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return assist?.call(code, span, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(code, span, editsComputer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintResult value)? lint,
    TResult? Function(LintWithEditsResult value)? lintWithEdits,
    TResult? Function(TotalDataResult value)? totalData,
    TResult? Function(SingleDataResult value)? singleData,
    TResult? Function(AssistResult value)? assist,
    TResult? Function(AssistWithEditsResult value)? assistWithEdits,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistResultToJson(
      this,
    );
  }
}

abstract class AssistResult extends AnalysisResult {
  const factory AssistResult(
      {required final RuleCode code,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      @JsonKey(ignore: true)
          final EditsComputer? editsComputer}) = _$AssistResult;
  const AssistResult._() : super._();

  factory AssistResult.fromJson(Map<String, dynamic> json) =
      _$AssistResult.fromJson;

  @override
  RuleCode get code;
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  @JsonKey(ignore: true)
  EditsComputer? get editsComputer;
  @override
  @JsonKey(ignore: true)
  _$$AssistResultCopyWith<_$AssistResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistWithEditsResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AssistWithEditsResultCopyWith(_$AssistWithEditsResult value,
          $Res Function(_$AssistWithEditsResult) then) =
      __$$AssistWithEditsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      List<EditResult> edits});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$AssistWithEditsResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$AssistWithEditsResult>
    implements _$$AssistWithEditsResultCopyWith<$Res> {
  __$$AssistWithEditsResultCopyWithImpl(_$AssistWithEditsResult _value,
      $Res Function(_$AssistWithEditsResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? span = null,
    Object? edits = null,
  }) {
    return _then(_$AssistWithEditsResult(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      edits: null == edits
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistWithEditsResult extends AssistWithEditsResult {
  const _$AssistWithEditsResult(
      {required this.code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      final List<EditResult> edits = const <EditResult>[],
      final String? $type})
      : _edits = edits,
        $type = $type ?? 'assistWithEdits',
        super._();

  factory _$AssistWithEditsResult.fromJson(Map<String, dynamic> json) =>
      _$$AssistWithEditsResultFromJson(json);

  @override
  final RuleCode code;
  @override
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  final SourceSpan span;
  final List<EditResult> _edits;
  @override
  @JsonKey()
  List<EditResult> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AnalysisResult.assistWithEdits(code: $code, span: $span, edits: $edits)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistWithEditsResultCopyWith<_$AssistWithEditsResult> get copyWith =>
      __$$AssistWithEditsResultCopyWithImpl<_$AssistWithEditsResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        lint,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lintWithEdits,
    required TResult Function(RuleCode code, List<Object> data) totalData,
    required TResult Function(RuleCode code, Object data) singleData,
    required TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        assist,
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        assistWithEdits,
  }) {
    return assistWithEdits(code, span, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult? Function(RuleCode code, List<Object> data)? totalData,
    TResult? Function(RuleCode code, Object data)? singleData,
    TResult? Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
  }) {
    return assistWithEdits?.call(code, span, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        lint,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)?
        lintWithEdits,
    TResult Function(RuleCode code, List<Object> data)? totalData,
    TResult Function(RuleCode code, Object data)? singleData,
    TResult Function(
            RuleCode code,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        assist,
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        assistWithEdits,
    required TResult orElse(),
  }) {
    if (assistWithEdits != null) {
      return assistWithEdits(code, span, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(LintWithEditsResult value) lintWithEdits,
    required TResult Function(TotalDataResult value) totalData,
    required TResult Function(SingleDataResult value) singleData,
    required TResult Function(AssistResult value) assist,
    required TResult Function(AssistWithEditsResult value) assistWithEdits,
  }) {
    return assistWithEdits(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintResult value)? lint,
    TResult? Function(LintWithEditsResult value)? lintWithEdits,
    TResult? Function(TotalDataResult value)? totalData,
    TResult? Function(SingleDataResult value)? singleData,
    TResult? Function(AssistResult value)? assist,
    TResult? Function(AssistWithEditsResult value)? assistWithEdits,
  }) {
    return assistWithEdits?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(LintWithEditsResult value)? lintWithEdits,
    TResult Function(TotalDataResult value)? totalData,
    TResult Function(SingleDataResult value)? singleData,
    TResult Function(AssistResult value)? assist,
    TResult Function(AssistWithEditsResult value)? assistWithEdits,
    required TResult orElse(),
  }) {
    if (assistWithEdits != null) {
      return assistWithEdits(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistWithEditsResultToJson(
      this,
    );
  }
}

abstract class AssistWithEditsResult extends AnalysisResult {
  const factory AssistWithEditsResult(
      {required final RuleCode code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      final List<EditResult> edits}) = _$AssistWithEditsResult;
  const AssistWithEditsResult._() : super._();

  factory AssistWithEditsResult.fromJson(Map<String, dynamic> json) =
      _$AssistWithEditsResult.fromJson;

  @override
  RuleCode get code;
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$AssistWithEditsResultCopyWith<_$AssistWithEditsResult> get copyWith =>
      throw _privateConstructorUsedError;
}
