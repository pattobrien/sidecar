// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_package_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisPackageConfiguration {
  String get packageName => throw _privateConstructorUsedError;
  SourceSpan get packageNameSpan => throw _privateConstructorUsedError;
  List<Glob> get includes => throw _privateConstructorUsedError;
  List<SidecarConfigException> get sourceErrors =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        lint,
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageConfiguration value) lint,
    required TResult Function(AssistPackageConfiguration value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisPackageConfigurationCopyWith<AnalysisPackageConfiguration>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisPackageConfigurationCopyWith<$Res> {
  factory $AnalysisPackageConfigurationCopyWith(
          AnalysisPackageConfiguration value,
          $Res Function(AnalysisPackageConfiguration) then) =
      _$AnalysisPackageConfigurationCopyWithImpl<$Res>;
  $Res call(
      {String packageName,
      SourceSpan packageNameSpan,
      List<Glob> includes,
      List<SidecarConfigException> sourceErrors});
}

/// @nodoc
class _$AnalysisPackageConfigurationCopyWithImpl<$Res>
    implements $AnalysisPackageConfigurationCopyWith<$Res> {
  _$AnalysisPackageConfigurationCopyWithImpl(this._value, this._then);

  final AnalysisPackageConfiguration _value;
  // ignore: unused_field
  final $Res Function(AnalysisPackageConfiguration) _then;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? packageNameSpan = freezed,
    Object? includes = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageNameSpan: packageNameSpan == freezed
          ? _value.packageNameSpan
          : packageNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      includes: includes == freezed
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>,
      sourceErrors: sourceErrors == freezed
          ? _value.sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<SidecarConfigException>,
    ));
  }
}

/// @nodoc
abstract class _$$LintPackageConfigurationCopyWith<$Res>
    implements $AnalysisPackageConfigurationCopyWith<$Res> {
  factory _$$LintPackageConfigurationCopyWith(_$LintPackageConfiguration value,
          $Res Function(_$LintPackageConfiguration) then) =
      __$$LintPackageConfigurationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      SourceSpan packageNameSpan,
      Map<String, LintConfiguration> lints,
      List<Glob> includes,
      List<SidecarConfigException> sourceErrors});
}

/// @nodoc
class __$$LintPackageConfigurationCopyWithImpl<$Res>
    extends _$AnalysisPackageConfigurationCopyWithImpl<$Res>
    implements _$$LintPackageConfigurationCopyWith<$Res> {
  __$$LintPackageConfigurationCopyWithImpl(_$LintPackageConfiguration _value,
      $Res Function(_$LintPackageConfiguration) _then)
      : super(_value, (v) => _then(v as _$LintPackageConfiguration));

  @override
  _$LintPackageConfiguration get _value =>
      super._value as _$LintPackageConfiguration;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? packageNameSpan = freezed,
    Object? lints = freezed,
    Object? includes = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_$LintPackageConfiguration(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageNameSpan: packageNameSpan == freezed
          ? _value.packageNameSpan
          : packageNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      lints: lints == freezed
          ? _value._lints
          : lints // ignore: cast_nullable_to_non_nullable
              as Map<String, LintConfiguration>,
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>,
      sourceErrors: sourceErrors == freezed
          ? _value._sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<SidecarConfigException>,
    ));
  }
}

/// @nodoc

class _$LintPackageConfiguration extends LintPackageConfiguration {
  const _$LintPackageConfiguration(
      {required this.packageName,
      required this.packageNameSpan,
      required final Map<String, LintConfiguration> lints,
      final List<Glob> includes = const <Glob>[],
      final List<SidecarConfigException> sourceErrors =
          const <SidecarConfigException>[]})
      : _lints = lints,
        _includes = includes,
        _sourceErrors = sourceErrors,
        super._();

  @override
  final String packageName;
  @override
  final SourceSpan packageNameSpan;
  final Map<String, LintConfiguration> _lints;
  @override
  Map<String, LintConfiguration> get lints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lints);
  }

  final List<Glob> _includes;
  @override
  @JsonKey()
  List<Glob> get includes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includes);
  }

  final List<SidecarConfigException> _sourceErrors;
  @override
  @JsonKey()
  List<SidecarConfigException> get sourceErrors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceErrors);
  }

  @override
  String toString() {
    return 'AnalysisPackageConfiguration.lint(packageName: $packageName, packageNameSpan: $packageNameSpan, lints: $lints, includes: $includes, sourceErrors: $sourceErrors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintPackageConfiguration &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.packageNameSpan, packageNameSpan) &&
            const DeepCollectionEquality().equals(other._lints, _lints) &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other._sourceErrors, _sourceErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(packageNameSpan),
      const DeepCollectionEquality().hash(_lints),
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_sourceErrors));

  @JsonKey(ignore: true)
  @override
  _$$LintPackageConfigurationCopyWith<_$LintPackageConfiguration>
      get copyWith =>
          __$$LintPackageConfigurationCopyWithImpl<_$LintPackageConfiguration>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        lint,
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        assist,
  }) {
    return lint(packageName, packageNameSpan, lints, includes, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
  }) {
    return lint?.call(
        packageName, packageNameSpan, lints, includes, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(packageName, packageNameSpan, lints, includes, sourceErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageConfiguration value) lint,
    required TResult Function(AssistPackageConfiguration value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }
}

abstract class LintPackageConfiguration extends AnalysisPackageConfiguration {
  const factory LintPackageConfiguration(
          {required final String packageName,
          required final SourceSpan packageNameSpan,
          required final Map<String, LintConfiguration> lints,
          final List<Glob> includes,
          final List<SidecarConfigException> sourceErrors}) =
      _$LintPackageConfiguration;
  const LintPackageConfiguration._() : super._();

  @override
  String get packageName;
  @override
  SourceSpan get packageNameSpan;
  Map<String, LintConfiguration> get lints;
  @override
  List<Glob> get includes;
  @override
  List<SidecarConfigException> get sourceErrors;
  @override
  @JsonKey(ignore: true)
  _$$LintPackageConfigurationCopyWith<_$LintPackageConfiguration>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistPackageConfigurationCopyWith<$Res>
    implements $AnalysisPackageConfigurationCopyWith<$Res> {
  factory _$$AssistPackageConfigurationCopyWith(
          _$AssistPackageConfiguration value,
          $Res Function(_$AssistPackageConfiguration) then) =
      __$$AssistPackageConfigurationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      SourceSpan packageNameSpan,
      Map<String, AssistConfiguration> assists,
      List<Glob> includes,
      List<SidecarConfigException> sourceErrors});
}

/// @nodoc
class __$$AssistPackageConfigurationCopyWithImpl<$Res>
    extends _$AnalysisPackageConfigurationCopyWithImpl<$Res>
    implements _$$AssistPackageConfigurationCopyWith<$Res> {
  __$$AssistPackageConfigurationCopyWithImpl(
      _$AssistPackageConfiguration _value,
      $Res Function(_$AssistPackageConfiguration) _then)
      : super(_value, (v) => _then(v as _$AssistPackageConfiguration));

  @override
  _$AssistPackageConfiguration get _value =>
      super._value as _$AssistPackageConfiguration;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? packageNameSpan = freezed,
    Object? assists = freezed,
    Object? includes = freezed,
    Object? sourceErrors = freezed,
  }) {
    return _then(_$AssistPackageConfiguration(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageNameSpan: packageNameSpan == freezed
          ? _value.packageNameSpan
          : packageNameSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      assists: assists == freezed
          ? _value._assists
          : assists // ignore: cast_nullable_to_non_nullable
              as Map<String, AssistConfiguration>,
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>,
      sourceErrors: sourceErrors == freezed
          ? _value._sourceErrors
          : sourceErrors // ignore: cast_nullable_to_non_nullable
              as List<SidecarConfigException>,
    ));
  }
}

/// @nodoc

class _$AssistPackageConfiguration extends AssistPackageConfiguration {
  const _$AssistPackageConfiguration(
      {required this.packageName,
      required this.packageNameSpan,
      required final Map<String, AssistConfiguration> assists,
      final List<Glob> includes = const <Glob>[],
      final List<SidecarConfigException> sourceErrors =
          const <SidecarConfigException>[]})
      : _assists = assists,
        _includes = includes,
        _sourceErrors = sourceErrors,
        super._();

  @override
  final String packageName;
  @override
  final SourceSpan packageNameSpan;
  final Map<String, AssistConfiguration> _assists;
  @override
  Map<String, AssistConfiguration> get assists {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_assists);
  }

  final List<Glob> _includes;
  @override
  @JsonKey()
  List<Glob> get includes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includes);
  }

  final List<SidecarConfigException> _sourceErrors;
  @override
  @JsonKey()
  List<SidecarConfigException> get sourceErrors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourceErrors);
  }

  @override
  String toString() {
    return 'AnalysisPackageConfiguration.assist(packageName: $packageName, packageNameSpan: $packageNameSpan, assists: $assists, includes: $includes, sourceErrors: $sourceErrors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistPackageConfiguration &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.packageNameSpan, packageNameSpan) &&
            const DeepCollectionEquality().equals(other._assists, _assists) &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality()
                .equals(other._sourceErrors, _sourceErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(packageNameSpan),
      const DeepCollectionEquality().hash(_assists),
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_sourceErrors));

  @JsonKey(ignore: true)
  @override
  _$$AssistPackageConfigurationCopyWith<_$AssistPackageConfiguration>
      get copyWith => __$$AssistPackageConfigurationCopyWithImpl<
          _$AssistPackageConfiguration>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        lint,
    required TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)
        assist,
  }) {
    return assist(
        packageName, packageNameSpan, assists, includes, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
  }) {
    return assist?.call(
        packageName, packageNameSpan, assists, includes, sourceErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, LintConfiguration> lints,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        lint,
    TResult Function(
            String packageName,
            SourceSpan packageNameSpan,
            Map<String, AssistConfiguration> assists,
            List<Glob> includes,
            List<SidecarConfigException> sourceErrors)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(
          packageName, packageNameSpan, assists, includes, sourceErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageConfiguration value) lint,
    required TResult Function(AssistPackageConfiguration value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageConfiguration value)? lint,
    TResult Function(AssistPackageConfiguration value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }
}

abstract class AssistPackageConfiguration extends AnalysisPackageConfiguration {
  const factory AssistPackageConfiguration(
          {required final String packageName,
          required final SourceSpan packageNameSpan,
          required final Map<String, AssistConfiguration> assists,
          final List<Glob> includes,
          final List<SidecarConfigException> sourceErrors}) =
      _$AssistPackageConfiguration;
  const AssistPackageConfiguration._() : super._();

  @override
  String get packageName;
  @override
  SourceSpan get packageNameSpan;
  Map<String, AssistConfiguration> get assists;
  @override
  List<Glob> get includes;
  @override
  List<SidecarConfigException> get sourceErrors;
  @override
  @JsonKey(ignore: true)
  _$$AssistPackageConfigurationCopyWith<_$AssistPackageConfiguration>
      get copyWith => throw _privateConstructorUsedError;
}
