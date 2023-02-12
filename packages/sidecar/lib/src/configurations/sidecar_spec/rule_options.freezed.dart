// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rule_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RuleOptions {
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes => throw _privateConstructorUsedError;
  bool? get enabled => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get configuration =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintOptions value) lint,
    required TResult Function(AssistOptions value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintOptions value)? lint,
    TResult? Function(AssistOptions value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintOptions value)? lint,
    TResult Function(AssistOptions value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RuleOptionsCopyWith<RuleOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RuleOptionsCopyWith<$Res> {
  factory $RuleOptionsCopyWith(
          RuleOptions value, $Res Function(RuleOptions) then) =
      _$RuleOptionsCopyWithImpl<$Res, RuleOptions>;
  @useResult
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      bool? enabled,
      Map<dynamic, dynamic>? configuration});
}

/// @nodoc
class _$RuleOptionsCopyWithImpl<$Res, $Val extends RuleOptions>
    implements $RuleOptionsCopyWith<$Res> {
  _$RuleOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? enabled = freezed,
    Object? configuration = freezed,
  }) {
    return _then(_value.copyWith(
      includes: freezed == includes
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: freezed == excludes
          ? _value.excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      configuration: freezed == configuration
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LintOptionsCopyWith<$Res>
    implements $RuleOptionsCopyWith<$Res> {
  factory _$$LintOptionsCopyWith(
          _$LintOptions value, $Res Function(_$LintOptions) then) =
      __$$LintOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      bool? enabled,
      Map<dynamic, dynamic>? configuration,
      LintSeverity? severity});
}

/// @nodoc
class __$$LintOptionsCopyWithImpl<$Res>
    extends _$RuleOptionsCopyWithImpl<$Res, _$LintOptions>
    implements _$$LintOptionsCopyWith<$Res> {
  __$$LintOptionsCopyWithImpl(
      _$LintOptions _value, $Res Function(_$LintOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? enabled = freezed,
    Object? configuration = freezed,
    Object? severity = freezed,
  }) {
    return _then(_$LintOptions(
      includes: freezed == includes
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: freezed == excludes
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      configuration: freezed == configuration
          ? _value._configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$LintOptions extends LintOptions {
  const _$LintOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      this.enabled,
      final Map<dynamic, dynamic>? configuration,
      this.severity,
      final String? $type})
      : _includes = includes,
        _excludes = excludes,
        _configuration = configuration,
        $type = $type ?? 'lint',
        super._();

  final List<Glob>? _includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Glob>? _excludes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes {
    final value = _excludes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? enabled;
  final Map<dynamic, dynamic>? _configuration;
  @override
  Map<dynamic, dynamic>? get configuration {
    final value = _configuration;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final LintSeverity? severity;

  @JsonKey(name: '')
  final String $type;

  @override
  String toString() {
    return 'RuleOptions.lint(includes: $includes, excludes: $excludes, enabled: $enabled, configuration: $configuration, severity: $severity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintOptions &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._configuration, _configuration) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      enabled,
      const DeepCollectionEquality().hash(_configuration),
      severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LintOptionsCopyWith<_$LintOptions> get copyWith =>
      __$$LintOptionsCopyWithImpl<_$LintOptions>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)
        assist,
  }) {
    return lint(includes, excludes, enabled, configuration, severity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
  }) {
    return lint?.call(includes, excludes, enabled, configuration, severity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(includes, excludes, enabled, configuration, severity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintOptions value) lint,
    required TResult Function(AssistOptions value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintOptions value)? lint,
    TResult? Function(AssistOptions value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintOptions value)? lint,
    TResult Function(AssistOptions value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintOptionsToJson(
      this,
    );
  }
}

abstract class LintOptions extends RuleOptions {
  const factory LintOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final bool? enabled,
      final Map<dynamic, dynamic>? configuration,
      final LintSeverity? severity}) = _$LintOptions;
  const LintOptions._() : super._();

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  @override
  bool? get enabled;
  @override
  Map<dynamic, dynamic>? get configuration;
  LintSeverity? get severity;
  @override
  @JsonKey(ignore: true)
  _$$LintOptionsCopyWith<_$LintOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistOptionsCopyWith<$Res>
    implements $RuleOptionsCopyWith<$Res> {
  factory _$$AssistOptionsCopyWith(
          _$AssistOptions value, $Res Function(_$AssistOptions) then) =
      __$$AssistOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      bool? enabled,
      Map<dynamic, dynamic>? configuration});
}

/// @nodoc
class __$$AssistOptionsCopyWithImpl<$Res>
    extends _$RuleOptionsCopyWithImpl<$Res, _$AssistOptions>
    implements _$$AssistOptionsCopyWith<$Res> {
  __$$AssistOptionsCopyWithImpl(
      _$AssistOptions _value, $Res Function(_$AssistOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? enabled = freezed,
    Object? configuration = freezed,
  }) {
    return _then(_$AssistOptions(
      includes: freezed == includes
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: freezed == excludes
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      configuration: freezed == configuration
          ? _value._configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$AssistOptions extends AssistOptions {
  const _$AssistOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      this.enabled,
      final Map<dynamic, dynamic>? configuration,
      final String? $type})
      : _includes = includes,
        _excludes = excludes,
        _configuration = configuration,
        $type = $type ?? 'assist',
        super._();

  final List<Glob>? _includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Glob>? _excludes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes {
    final value = _excludes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? enabled;
  final Map<dynamic, dynamic>? _configuration;
  @override
  Map<dynamic, dynamic>? get configuration {
    final value = _configuration;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: '')
  final String $type;

  @override
  String toString() {
    return 'RuleOptions.assist(includes: $includes, excludes: $excludes, enabled: $enabled, configuration: $configuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistOptions &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._configuration, _configuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      enabled,
      const DeepCollectionEquality().hash(_configuration));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistOptionsCopyWith<_$AssistOptions> get copyWith =>
      __$$AssistOptionsCopyWithImpl<_$AssistOptions>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)
        assist,
  }) {
    return assist(includes, excludes, enabled, configuration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult? Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
  }) {
    return assist?.call(includes, excludes, enabled, configuration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration,
            LintSeverity? severity)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            bool? enabled,
            Map<dynamic, dynamic>? configuration)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(includes, excludes, enabled, configuration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintOptions value) lint,
    required TResult Function(AssistOptions value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LintOptions value)? lint,
    TResult? Function(AssistOptions value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintOptions value)? lint,
    TResult Function(AssistOptions value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistOptionsToJson(
      this,
    );
  }
}

abstract class AssistOptions extends RuleOptions {
  const factory AssistOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final bool? enabled,
      final Map<dynamic, dynamic>? configuration}) = _$AssistOptions;
  const AssistOptions._() : super._();

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  @override
  bool? get enabled;
  @override
  Map<dynamic, dynamic>? get configuration;
  @override
  @JsonKey(ignore: true)
  _$$AssistOptionsCopyWith<_$AssistOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
