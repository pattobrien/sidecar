// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisConfiguration {
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get configuration =>
      throw _privateConstructorUsedError;
  bool? get enabled => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintConfiguration value) lint,
    required TResult Function(AssistConfiguration value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisConfigurationCopyWith<AnalysisConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisConfigurationCopyWith<$Res> {
  factory $AnalysisConfigurationCopyWith(AnalysisConfiguration value,
          $Res Function(AnalysisConfiguration) then) =
      _$AnalysisConfigurationCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(toJson: globsToString, fromJson: globsFromString)
          List<Glob>? includes,
      Map<dynamic, dynamic>? configuration,
      bool? enabled});
}

/// @nodoc
class _$AnalysisConfigurationCopyWithImpl<$Res>
    implements $AnalysisConfigurationCopyWith<$Res> {
  _$AnalysisConfigurationCopyWithImpl(this._value, this._then);

  final AnalysisConfiguration _value;
  // ignore: unused_field
  final $Res Function(AnalysisConfiguration) _then;

  @override
  $Res call({
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      includes: includes == freezed
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$LintConfigurationCopyWith<$Res>
    implements $AnalysisConfigurationCopyWith<$Res> {
  factory _$$LintConfigurationCopyWith(
          _$LintConfiguration value, $Res Function(_$LintConfiguration) then) =
      __$$LintConfigurationCopyWithImpl<$Res>;
  @override
  $Res call(
      {LintSeverity? severity,
      @JsonKey(toJson: globsToString, fromJson: globsFromString)
          List<Glob>? includes,
      Map<dynamic, dynamic>? configuration,
      bool? enabled});
}

/// @nodoc
class __$$LintConfigurationCopyWithImpl<$Res>
    extends _$AnalysisConfigurationCopyWithImpl<$Res>
    implements _$$LintConfigurationCopyWith<$Res> {
  __$$LintConfigurationCopyWithImpl(
      _$LintConfiguration _value, $Res Function(_$LintConfiguration) _then)
      : super(_value, (v) => _then(v as _$LintConfiguration));

  @override
  _$LintConfiguration get _value => super._value as _$LintConfiguration;

  @override
  $Res call({
    Object? severity = freezed,
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
  }) {
    return _then(_$LintConfiguration(
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity?,
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value._configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true)
class _$LintConfiguration extends LintConfiguration {
  const _$LintConfiguration(
      {this.severity,
      @JsonKey(toJson: globsToString, fromJson: globsFromString)
          final List<Glob>? includes,
      final Map<dynamic, dynamic>? configuration,
      this.enabled})
      : _includes = includes,
        _configuration = configuration,
        super._();

  @override
  final LintSeverity? severity;
  final List<Glob>? _includes;
  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<dynamic, dynamic>? _configuration;
  @override
  Map<dynamic, dynamic>? get configuration {
    final value = _configuration;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? enabled;

  @override
  String toString() {
    return 'AnalysisConfiguration.lint(severity: $severity, includes: $includes, configuration: $configuration, enabled: $enabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintConfiguration &&
            const DeepCollectionEquality().equals(other.severity, severity) &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other._configuration, _configuration) &&
            const DeepCollectionEquality().equals(other.enabled, enabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(severity),
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_configuration),
      const DeepCollectionEquality().hash(enabled));

  @JsonKey(ignore: true)
  @override
  _$$LintConfigurationCopyWith<_$LintConfiguration> get copyWith =>
      __$$LintConfigurationCopyWithImpl<_$LintConfiguration>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        assist,
  }) {
    return lint(severity, includes, configuration, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
  }) {
    return lint?.call(severity, includes, configuration, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(severity, includes, configuration, enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintConfiguration value) lint,
    required TResult Function(AssistConfiguration value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }
}

abstract class LintConfiguration extends AnalysisConfiguration {
  const factory LintConfiguration(
      {final LintSeverity? severity,
      @JsonKey(toJson: globsToString, fromJson: globsFromString)
          final List<Glob>? includes,
      final Map<dynamic, dynamic>? configuration,
      final bool? enabled}) = _$LintConfiguration;
  const LintConfiguration._() : super._();

  LintSeverity? get severity;
  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  List<Glob>? get includes;
  @override
  Map<dynamic, dynamic>? get configuration;
  @override
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$LintConfigurationCopyWith<_$LintConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistConfigurationCopyWith<$Res>
    implements $AnalysisConfigurationCopyWith<$Res> {
  factory _$$AssistConfigurationCopyWith(_$AssistConfiguration value,
          $Res Function(_$AssistConfiguration) then) =
      __$$AssistConfigurationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToString, fromJson: globsFromString)
          List<Glob>? includes,
      Map<dynamic, dynamic>? configuration,
      bool? enabled});
}

/// @nodoc
class __$$AssistConfigurationCopyWithImpl<$Res>
    extends _$AnalysisConfigurationCopyWithImpl<$Res>
    implements _$$AssistConfigurationCopyWith<$Res> {
  __$$AssistConfigurationCopyWithImpl(
      _$AssistConfiguration _value, $Res Function(_$AssistConfiguration) _then)
      : super(_value, (v) => _then(v as _$AssistConfiguration));

  @override
  _$AssistConfiguration get _value => super._value as _$AssistConfiguration;

  @override
  $Res call({
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
  }) {
    return _then(_$AssistConfiguration(
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value._configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(anyMap: true)
class _$AssistConfiguration extends AssistConfiguration {
  const _$AssistConfiguration(
      {@JsonKey(toJson: globsToString, fromJson: globsFromString)
          final List<Glob>? includes,
      final Map<dynamic, dynamic>? configuration,
      this.enabled})
      : _includes = includes,
        _configuration = configuration,
        super._();

  final List<Glob>? _includes;
  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<dynamic, dynamic>? _configuration;
  @override
  Map<dynamic, dynamic>? get configuration {
    final value = _configuration;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? enabled;

  @override
  String toString() {
    return 'AnalysisConfiguration.assist(includes: $includes, configuration: $configuration, enabled: $enabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistConfiguration &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other._configuration, _configuration) &&
            const DeepCollectionEquality().equals(other.enabled, enabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_configuration),
      const DeepCollectionEquality().hash(enabled));

  @JsonKey(ignore: true)
  @override
  _$$AssistConfigurationCopyWith<_$AssistConfiguration> get copyWith =>
      __$$AssistConfigurationCopyWithImpl<_$AssistConfiguration>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)
        assist,
  }) {
    return assist(includes, configuration, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
  }) {
    return assist?.call(includes, configuration, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LintSeverity? severity,
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToString, fromJson: globsFromString)
                List<Glob>? includes,
            Map<dynamic, dynamic>? configuration,
            bool? enabled)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(includes, configuration, enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintConfiguration value) lint,
    required TResult Function(AssistConfiguration value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintConfiguration value)? lint,
    TResult Function(AssistConfiguration value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }
}

abstract class AssistConfiguration extends AnalysisConfiguration {
  const factory AssistConfiguration(
      {@JsonKey(toJson: globsToString, fromJson: globsFromString)
          final List<Glob>? includes,
      final Map<dynamic, dynamic>? configuration,
      final bool? enabled}) = _$AssistConfiguration;
  const AssistConfiguration._() : super._();

  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  List<Glob>? get includes;
  @override
  Map<dynamic, dynamic>? get configuration;
  @override
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$AssistConfigurationCopyWith<_$AssistConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}
