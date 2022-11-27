// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'package_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PackageOptions _$PackageOptionsFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'lint':
      return LintPackageOptions.fromJson(json);
    case 'assist':
      return AssistPackageOptions.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PackageOptions',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PackageOptions {
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
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
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
        assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageOptions value) lint,
    required TResult Function(AssistPackageOptions value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageOptionsCopyWith<PackageOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageOptionsCopyWith<$Res> {
  factory $PackageOptionsCopyWith(
          PackageOptions value, $Res Function(PackageOptions) then) =
      _$PackageOptionsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes});
}

/// @nodoc
class _$PackageOptionsCopyWithImpl<$Res>
    implements $PackageOptionsCopyWith<$Res> {
  _$PackageOptionsCopyWithImpl(this._value, this._then);

  final PackageOptions _value;
  // ignore: unused_field
  final $Res Function(PackageOptions) _then;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
  }) {
    return _then(_value.copyWith(
      includes: includes == freezed
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value.excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
    ));
  }
}

/// @nodoc
abstract class _$$LintPackageOptionsCopyWith<$Res>
    implements $PackageOptionsCopyWith<$Res> {
  factory _$$LintPackageOptionsCopyWith(_$LintPackageOptions value,
          $Res Function(_$LintPackageOptions) then) =
      __$$LintPackageOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      Map<String, LintOptions>? rules});
}

/// @nodoc
class __$$LintPackageOptionsCopyWithImpl<$Res>
    extends _$PackageOptionsCopyWithImpl<$Res>
    implements _$$LintPackageOptionsCopyWith<$Res> {
  __$$LintPackageOptionsCopyWithImpl(
      _$LintPackageOptions _value, $Res Function(_$LintPackageOptions) _then)
      : super(_value, (v) => _then(v as _$LintPackageOptions));

  @override
  _$LintPackageOptions get _value => super._value as _$LintPackageOptions;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? rules = freezed,
  }) {
    return _then(_$LintPackageOptions(
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      rules: rules == freezed
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, LintOptions>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LintPackageOptions extends LintPackageOptions {
  const _$LintPackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, LintOptions>? rules,
      final String? $type})
      : _includes = includes,
        _excludes = excludes,
        _rules = rules,
        $type = $type ?? 'lint',
        super._();

  factory _$LintPackageOptions.fromJson(Map<String, dynamic> json) =>
      _$$LintPackageOptionsFromJson(json);

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

  final Map<String, LintOptions>? _rules;
  @override
  Map<String, LintOptions>? get rules {
    final value = _rules;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PackageOptions.lint(includes: $includes, excludes: $excludes, rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintPackageOptions &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            const DeepCollectionEquality().equals(other._rules, _rules));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      const DeepCollectionEquality().hash(_rules));

  @JsonKey(ignore: true)
  @override
  _$$LintPackageOptionsCopyWith<_$LintPackageOptions> get copyWith =>
      __$$LintPackageOptionsCopyWithImpl<_$LintPackageOptions>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)
        assist,
  }) {
    return lint(includes, excludes, rules);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
        assist,
  }) {
    return lint?.call(includes, excludes, rules);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(includes, excludes, rules);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageOptions value) lint,
    required TResult Function(AssistPackageOptions value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintPackageOptionsToJson(
      this,
    );
  }
}

abstract class LintPackageOptions extends PackageOptions {
  const factory LintPackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, LintOptions>? rules}) = _$LintPackageOptions;
  const LintPackageOptions._() : super._();

  factory LintPackageOptions.fromJson(Map<String, dynamic> json) =
      _$LintPackageOptions.fromJson;

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  Map<String, LintOptions>? get rules;
  @override
  @JsonKey(ignore: true)
  _$$LintPackageOptionsCopyWith<_$LintPackageOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistPackageOptionsCopyWith<$Res>
    implements $PackageOptionsCopyWith<$Res> {
  factory _$$AssistPackageOptionsCopyWith(_$AssistPackageOptions value,
          $Res Function(_$AssistPackageOptions) then) =
      __$$AssistPackageOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      Map<String, AssistOptions>? rules});
}

/// @nodoc
class __$$AssistPackageOptionsCopyWithImpl<$Res>
    extends _$PackageOptionsCopyWithImpl<$Res>
    implements _$$AssistPackageOptionsCopyWith<$Res> {
  __$$AssistPackageOptionsCopyWithImpl(_$AssistPackageOptions _value,
      $Res Function(_$AssistPackageOptions) _then)
      : super(_value, (v) => _then(v as _$AssistPackageOptions));

  @override
  _$AssistPackageOptions get _value => super._value as _$AssistPackageOptions;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? rules = freezed,
  }) {
    return _then(_$AssistPackageOptions(
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      rules: rules == freezed
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, AssistOptions>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistPackageOptions extends AssistPackageOptions {
  const _$AssistPackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, AssistOptions>? rules,
      final String? $type})
      : _includes = includes,
        _excludes = excludes,
        _rules = rules,
        $type = $type ?? 'assist',
        super._();

  factory _$AssistPackageOptions.fromJson(Map<String, dynamic> json) =>
      _$$AssistPackageOptionsFromJson(json);

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

  final Map<String, AssistOptions>? _rules;
  @override
  Map<String, AssistOptions>? get rules {
    final value = _rules;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PackageOptions.assist(includes: $includes, excludes: $excludes, rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistPackageOptions &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            const DeepCollectionEquality().equals(other._rules, _rules));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      const DeepCollectionEquality().hash(_rules));

  @JsonKey(ignore: true)
  @override
  _$$AssistPackageOptionsCopyWith<_$AssistPackageOptions> get copyWith =>
      __$$AssistPackageOptionsCopyWithImpl<_$AssistPackageOptions>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)
        lint,
    required TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)
        assist,
  }) {
    return assist(includes, excludes, rules);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
        assist,
  }) {
    return assist?.call(includes, excludes, rules);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, LintOptions>? rules)?
        lint,
    TResult Function(
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? includes,
            @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
                List<Glob>? excludes,
            Map<String, AssistOptions>? rules)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(includes, excludes, rules);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintPackageOptions value) lint,
    required TResult Function(AssistPackageOptions value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintPackageOptions value)? lint,
    TResult Function(AssistPackageOptions value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistPackageOptionsToJson(
      this,
    );
  }
}

abstract class AssistPackageOptions extends PackageOptions {
  const factory AssistPackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, AssistOptions>? rules}) = _$AssistPackageOptions;
  const AssistPackageOptions._() : super._();

  factory AssistPackageOptions.fromJson(Map<String, dynamic> json) =
      _$AssistPackageOptions.fromJson;

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  Map<String, AssistOptions>? get rules;
  @override
  @JsonKey(ignore: true)
  _$$AssistPackageOptionsCopyWith<_$AssistPackageOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
