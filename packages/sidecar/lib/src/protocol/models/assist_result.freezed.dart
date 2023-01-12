// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'assist_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssistResult _$AssistResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return AssistFilterResult.fromJson(json);
    case 'withEdits':
      return AssistResultWithEdits.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AssistResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AssistResult {
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
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
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(AssistFilterResult value) $default, {
    required TResult Function(AssistResultWithEdits value) withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(AssistFilterResult value)? $default, {
    TResult? Function(AssistResultWithEdits value)? withEdits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssistResultCopyWith<AssistResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssistResultCopyWith<$Res> {
  factory $AssistResultCopyWith(
          AssistResult value, $Res Function(AssistResult) then) =
      _$AssistResultCopyWithImpl<$Res, AssistResult>;
  @useResult
  $Res call(
      {@Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span});
}

/// @nodoc
class _$AssistResultCopyWithImpl<$Res, $Val extends AssistResult>
    implements $AssistResultCopyWith<$Res> {
  _$AssistResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? span = null,
  }) {
    return _then(_value.copyWith(
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssistFilterResultCopyWith<$Res>
    implements $AssistResultCopyWith<$Res> {
  factory _$$AssistFilterResultCopyWith(_$AssistFilterResult value,
          $Res Function(_$AssistFilterResult) then) =
      __$$AssistFilterResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      @JsonKey(ignore: true)
          EditsComputer? editsComputer});

  $RuleCodeCopyWith<$Res> get rule;
}

/// @nodoc
class __$$AssistFilterResultCopyWithImpl<$Res>
    extends _$AssistResultCopyWithImpl<$Res, _$AssistFilterResult>
    implements _$$AssistFilterResultCopyWith<$Res> {
  __$$AssistFilterResultCopyWithImpl(
      _$AssistFilterResult _value, $Res Function(_$AssistFilterResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? span = null,
    Object? editsComputer = freezed,
  }) {
    return _then(_$AssistFilterResult(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
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

  @override
  @pragma('vm:prefer-inline')
  $RuleCodeCopyWith<$Res> get rule {
    return $RuleCodeCopyWith<$Res>(_value.rule, (value) {
      return _then(_value.copyWith(rule: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistFilterResult extends AssistFilterResult {
  const _$AssistFilterResult(
      {required this.rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      @JsonKey(ignore: true)
          this.editsComputer,
      final String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$AssistFilterResult.fromJson(Map<String, dynamic> json) =>
      _$$AssistFilterResultFromJson(json);

  @override
  final RuleCode rule;
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
    return 'AssistResult(rule: $rule, span: $span, editsComputer: $editsComputer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistFilterResult &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.editsComputer, editsComputer) ||
                other.editsComputer == editsComputer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rule, span, editsComputer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistFilterResultCopyWith<_$AssistFilterResult> get copyWith =>
      __$$AssistFilterResultCopyWithImpl<_$AssistFilterResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        withEdits,
  }) {
    return $default(rule, span, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        withEdits,
  }) {
    return $default?.call(rule, span, editsComputer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(rule, span, editsComputer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(AssistFilterResult value) $default, {
    required TResult Function(AssistResultWithEdits value) withEdits,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(AssistFilterResult value)? $default, {
    TResult? Function(AssistResultWithEdits value)? withEdits,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistFilterResultToJson(
      this,
    );
  }
}

abstract class AssistFilterResult extends AssistResult {
  const factory AssistFilterResult(
      {required final RuleCode rule,
      @Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      @JsonKey(ignore: true)
          final EditsComputer? editsComputer}) = _$AssistFilterResult;
  const AssistFilterResult._() : super._();

  factory AssistFilterResult.fromJson(Map<String, dynamic> json) =
      _$AssistFilterResult.fromJson;

  RuleCode get rule;
  @override
  @Assert('span.sourceUrl != null')
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  @JsonKey(ignore: true)
  EditsComputer? get editsComputer;
  @override
  @JsonKey(ignore: true)
  _$$AssistFilterResultCopyWith<_$AssistFilterResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistResultWithEditsCopyWith<$Res>
    implements $AssistResultCopyWith<$Res> {
  factory _$$AssistResultWithEditsCopyWith(_$AssistResultWithEdits value,
          $Res Function(_$AssistResultWithEdits) then) =
      __$$AssistResultWithEditsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      List<EditResult> edits});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$AssistResultWithEditsCopyWithImpl<$Res>
    extends _$AssistResultCopyWithImpl<$Res, _$AssistResultWithEdits>
    implements _$$AssistResultWithEditsCopyWith<$Res> {
  __$$AssistResultWithEditsCopyWithImpl(_$AssistResultWithEdits _value,
      $Res Function(_$AssistResultWithEdits) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? span = null,
    Object? edits = null,
  }) {
    return _then(_$AssistResultWithEdits(
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

  @override
  @pragma('vm:prefer-inline')
  $RuleCodeCopyWith<$Res> get code {
    return $RuleCodeCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistResultWithEdits extends AssistResultWithEdits {
  const _$AssistResultWithEdits(
      {required this.code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required this.span,
      final List<EditResult> edits = const <EditResult>[],
      final String? $type})
      : _edits = edits,
        $type = $type ?? 'withEdits',
        super._();

  factory _$AssistResultWithEdits.fromJson(Map<String, dynamic> json) =>
      _$$AssistResultWithEditsFromJson(json);

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
    return 'AssistResult.withEdits(code: $code, span: $span, edits: $edits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistResultWithEdits &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.span, span) || other.span == span) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, span, const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistResultWithEditsCopyWith<_$AssistResultWithEdits> get copyWith =>
      __$$AssistResultWithEditsCopyWithImpl<_$AssistResultWithEdits>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)
        $default, {
    required TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)
        withEdits,
  }) {
    return withEdits(code, span, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult? Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        withEdits,
  }) {
    return withEdits?.call(code, span, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            RuleCode rule,
            @Assert('span.sourceUrl != null')
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            @JsonKey(ignore: true)
                EditsComputer? editsComputer)?
        $default, {
    TResult Function(
            RuleCode code,
            @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
                SourceSpan span,
            List<EditResult> edits)?
        withEdits,
    required TResult orElse(),
  }) {
    if (withEdits != null) {
      return withEdits(code, span, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(AssistFilterResult value) $default, {
    required TResult Function(AssistResultWithEdits value) withEdits,
  }) {
    return withEdits(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(AssistFilterResult value)? $default, {
    TResult? Function(AssistResultWithEdits value)? withEdits,
  }) {
    return withEdits?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
    required TResult orElse(),
  }) {
    if (withEdits != null) {
      return withEdits(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistResultWithEditsToJson(
      this,
    );
  }
}

abstract class AssistResultWithEdits extends AssistResult {
  const factory AssistResultWithEdits(
      {required final RuleCode code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          required final SourceSpan span,
      final List<EditResult> edits}) = _$AssistResultWithEdits;
  const AssistResultWithEdits._() : super._();

  factory AssistResultWithEdits.fromJson(Map<String, dynamic> json) =
      _$AssistResultWithEdits.fromJson;

  RuleCode get code;
  @override
  @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
  SourceSpan get span;
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$AssistResultWithEditsCopyWith<_$AssistResultWithEdits> get copyWith =>
      throw _privateConstructorUsedError;
}
