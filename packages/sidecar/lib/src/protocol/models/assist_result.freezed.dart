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
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
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
      _$AssistResultCopyWithImpl<$Res>;
  $Res call(
      {@Assert('span.sourceUrl != null')
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span});
}

/// @nodoc
class _$AssistResultCopyWithImpl<$Res> implements $AssistResultCopyWith<$Res> {
  _$AssistResultCopyWithImpl(this._value, this._then);

  final AssistResult _value;
  // ignore: unused_field
  final $Res Function(AssistResult) _then;

  @override
  $Res call({
    Object? span = freezed,
  }) {
    return _then(_value.copyWith(
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
    ));
  }
}

/// @nodoc
abstract class _$$AssistFilterResultCopyWith<$Res>
    implements $AssistResultCopyWith<$Res> {
  factory _$$AssistFilterResultCopyWith(_$AssistFilterResult value,
          $Res Function(_$AssistFilterResult) then) =
      __$$AssistFilterResultCopyWithImpl<$Res>;
  @override
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
    extends _$AssistResultCopyWithImpl<$Res>
    implements _$$AssistFilterResultCopyWith<$Res> {
  __$$AssistFilterResultCopyWithImpl(
      _$AssistFilterResult _value, $Res Function(_$AssistFilterResult) _then)
      : super(_value, (v) => _then(v as _$AssistFilterResult));

  @override
  _$AssistFilterResult get _value => super._value as _$AssistFilterResult;

  @override
  $Res call({
    Object? rule = freezed,
    Object? span = freezed,
    Object? editsComputer = freezed,
  }) {
    return _then(_$AssistFilterResult(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      editsComputer: editsComputer == freezed
          ? _value.editsComputer
          : editsComputer // ignore: cast_nullable_to_non_nullable
              as EditsComputer?,
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
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.span, span) &&
            (identical(other.editsComputer, editsComputer) ||
                other.editsComputer == editsComputer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(span),
      editsComputer);

  @JsonKey(ignore: true)
  @override
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
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
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
  $Res call(
      {RuleCode code,
      @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
          SourceSpan span,
      List<EditResult> edits});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$AssistResultWithEditsCopyWithImpl<$Res>
    extends _$AssistResultCopyWithImpl<$Res>
    implements _$$AssistResultWithEditsCopyWith<$Res> {
  __$$AssistResultWithEditsCopyWithImpl(_$AssistResultWithEdits _value,
      $Res Function(_$AssistResultWithEdits) _then)
      : super(_value, (v) => _then(v as _$AssistResultWithEdits));

  @override
  _$AssistResultWithEdits get _value => super._value as _$AssistResultWithEdits;

  @override
  $Res call({
    Object? code = freezed,
    Object? span = freezed,
    Object? edits = freezed,
  }) {
    return _then(_$AssistResultWithEdits(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }

  @override
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
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.span, span) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(span),
      const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
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
    TResult Function(AssistFilterResult value)? $default, {
    TResult Function(AssistResultWithEdits value)? withEdits,
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
