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
  String get id => throw _privateConstructorUsedError;
  String get packageName => throw _privateConstructorUsedError;
  SourceSpan get lintNameSpan => throw _privateConstructorUsedError;
  List<Glob>? get includes => throw _privateConstructorUsedError;
  YamlMap? get configuration => throw _privateConstructorUsedError;
  bool? get enabled => throw _privateConstructorUsedError;
  List<YamlSourceError> get sourceErrors => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        lint,
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
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
      {String id,
      String packageName,
      SourceSpan lintNameSpan,
      List<Glob>? includes,
      YamlMap? configuration,
      bool? enabled,
      List<YamlSourceError> sourceErrors});
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
    Object? id = freezed,
    Object? packageName = freezed,
    Object? lintNameSpan = freezed,
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      lintNameSpan: lintNameSpan == freezed
          ? _value.lintNameSpan
          : lintNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      includes: includes == freezed
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as YamlMap?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      sourceErrors: sourceErrors == freezed
          ? _value.sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<YamlSourceError>,
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
      {String id,
      String packageName,
      SourceSpan lintNameSpan,
      LintRuleType? severity,
      List<Glob>? includes,
      YamlMap? configuration,
      bool? enabled,
      List<YamlSourceError> sourceErrors});
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
    Object? id = freezed,
    Object? packageName = freezed,
    Object? lintNameSpan = freezed,
    Object? severity = freezed,
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_$LintConfiguration(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      lintNameSpan: lintNameSpan == freezed
          ? _value.lintNameSpan
          : lintNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintRuleType?,
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as YamlMap?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      sourceErrors: sourceErrors == freezed
          ? _value._sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<YamlSourceError>,
    ));
  }
}

/// @nodoc

class _$LintConfiguration extends LintConfiguration {
  const _$LintConfiguration(
      {required this.id,
      required this.packageName,
      required this.lintNameSpan,
      this.severity,
      final List<Glob>? includes,
      this.configuration,
      this.enabled,
      final List<YamlSourceError> sourceErrors = const <YamlSourceError>[]})
      : _includes = includes,
        _sourceErrors = sourceErrors,
        super._();

  @override
  final String id;
  @override
  final String packageName;
  @override
  final SourceSpan lintNameSpan;
  @override
  final LintRuleType? severity;
  final List<Glob>? _includes;
  @override
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final YamlMap? configuration;
  @override
  final bool? enabled;
  final List<YamlSourceError> _sourceErrors;
  @override
  @JsonKey()
  List<YamlSourceError> get sourceErrors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceErrors);
  }

  @override
  String toString() {
    return 'AnalysisConfiguration.lint(id: $id, packageName: $packageName, lintNameSpan: $lintNameSpan, severity: $severity, includes: $includes, configuration: $configuration, enabled: $enabled, sourceErrors: $sourceErrors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintConfiguration &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.lintNameSpan, lintNameSpan) &&
            const DeepCollectionEquality().equals(other.severity, severity) &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other.configuration, configuration) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality()
                .equals(other._sourceErrors, _sourceErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(lintNameSpan),
      const DeepCollectionEquality().hash(severity),
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(configuration),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(_sourceErrors));

  @JsonKey(ignore: true)
  @override
  _$$LintConfigurationCopyWith<_$LintConfiguration> get copyWith =>
      __$$LintConfigurationCopyWithImpl<_$LintConfiguration>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        lint,
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        assist,
  }) {
    return lint(id, packageName, lintNameSpan, severity, includes,
        configuration, enabled, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        assist,
  }) {
    return lint?.call(id, packageName, lintNameSpan, severity, includes,
        configuration, enabled, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(id, packageName, lintNameSpan, severity, includes,
          configuration, enabled, sourceErrors);
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
      {required final String id,
      required final String packageName,
      required final SourceSpan lintNameSpan,
      final LintRuleType? severity,
      final List<Glob>? includes,
      final YamlMap? configuration,
      final bool? enabled,
      final List<YamlSourceError> sourceErrors}) = _$LintConfiguration;
  const LintConfiguration._() : super._();

  @override
  String get id;
  @override
  String get packageName;
  @override
  SourceSpan get lintNameSpan;
  LintRuleType? get severity;
  @override
  List<Glob>? get includes;
  @override
  YamlMap? get configuration;
  @override
  bool? get enabled;
  @override
  List<YamlSourceError> get sourceErrors;
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
      {String id,
      String packageName,
      SourceSpan lintNameSpan,
      List<Glob>? includes,
      YamlMap? configuration,
      bool? enabled,
      List<YamlSourceError> sourceErrors});
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
    Object? id = freezed,
    Object? packageName = freezed,
    Object? lintNameSpan = freezed,
    Object? includes = freezed,
    Object? configuration = freezed,
    Object? enabled = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_$AssistConfiguration(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      lintNameSpan: lintNameSpan == freezed
          ? _value.lintNameSpan
          : lintNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as YamlMap?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      sourceErrors: sourceErrors == freezed
          ? _value._sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<YamlSourceError>,
    ));
  }
}

/// @nodoc

class _$AssistConfiguration extends AssistConfiguration {
  const _$AssistConfiguration(
      {required this.id,
      required this.packageName,
      required this.lintNameSpan,
      final List<Glob>? includes,
      this.configuration,
      this.enabled,
      final List<YamlSourceError> sourceErrors = const <YamlSourceError>[]})
      : _includes = includes,
        _sourceErrors = sourceErrors,
        super._();

  @override
  final String id;
  @override
  final String packageName;
  @override
  final SourceSpan lintNameSpan;
  final List<Glob>? _includes;
  @override
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final YamlMap? configuration;
  @override
  final bool? enabled;
  final List<YamlSourceError> _sourceErrors;
  @override
  @JsonKey()
  List<YamlSourceError> get sourceErrors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceErrors);
  }

  @override
  String toString() {
    return 'AnalysisConfiguration.assist(id: $id, packageName: $packageName, lintNameSpan: $lintNameSpan, includes: $includes, configuration: $configuration, enabled: $enabled, sourceErrors: $sourceErrors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistConfiguration &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.lintNameSpan, lintNameSpan) &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other.configuration, configuration) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality()
                .equals(other._sourceErrors, _sourceErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(lintNameSpan),
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(configuration),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(_sourceErrors));

  @JsonKey(ignore: true)
  @override
  _$$AssistConfigurationCopyWith<_$AssistConfiguration> get copyWith =>
      __$$AssistConfigurationCopyWithImpl<_$AssistConfiguration>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        lint,
    required TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)
        assist,
  }) {
    return assist(id, packageName, lintNameSpan, includes, configuration,
        enabled, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        assist,
  }) {
    return assist?.call(id, packageName, lintNameSpan, includes, configuration,
        enabled, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            LintRuleType? severity,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        lint,
    TResult Function(
            String id,
            String packageName,
            SourceSpan lintNameSpan,
            List<Glob>? includes,
            YamlMap? configuration,
            bool? enabled,
            List<YamlSourceError> sourceErrors)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(id, packageName, lintNameSpan, includes, configuration,
          enabled, sourceErrors);
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
      {required final String id,
      required final String packageName,
      required final SourceSpan lintNameSpan,
      final List<Glob>? includes,
      final YamlMap? configuration,
      final bool? enabled,
      final List<YamlSourceError> sourceErrors}) = _$AssistConfiguration;
  const AssistConfiguration._() : super._();

  @override
  String get id;
  @override
  String get packageName;
  @override
  SourceSpan get lintNameSpan;
  @override
  List<Glob>? get includes;
  @override
  YamlMap? get configuration;
  @override
  bool? get enabled;
  @override
  List<YamlSourceError> get sourceErrors;
  @override
  @JsonKey(ignore: true)
  _$$AssistConfigurationCopyWith<_$AssistConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}
