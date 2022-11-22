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
  return _PackageOptions.fromJson(json);
}

/// @nodoc
mixin _$PackageOptions {
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes => throw _privateConstructorUsedError;
  Map<String, RuleOptions>? get rules => throw _privateConstructorUsedError;

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
          List<Glob>? excludes,
      Map<String, RuleOptions>? rules});
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
    Object? rules = freezed,
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
      rules: rules == freezed
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Map<String, RuleOptions>?,
    ));
  }
}

/// @nodoc
abstract class _$$_PackageOptionsCopyWith<$Res>
    implements $PackageOptionsCopyWith<$Res> {
  factory _$$_PackageOptionsCopyWith(
          _$_PackageOptions value, $Res Function(_$_PackageOptions) then) =
      __$$_PackageOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      Map<String, RuleOptions>? rules});
}

/// @nodoc
class __$$_PackageOptionsCopyWithImpl<$Res>
    extends _$PackageOptionsCopyWithImpl<$Res>
    implements _$$_PackageOptionsCopyWith<$Res> {
  __$$_PackageOptionsCopyWithImpl(
      _$_PackageOptions _value, $Res Function(_$_PackageOptions) _then)
      : super(_value, (v) => _then(v as _$_PackageOptions));

  @override
  _$_PackageOptions get _value => super._value as _$_PackageOptions;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? rules = freezed,
  }) {
    return _then(_$_PackageOptions(
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
              as Map<String, RuleOptions>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PackageOptions extends _PackageOptions {
  const _$_PackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, RuleOptions>? rules})
      : _includes = includes,
        _excludes = excludes,
        _rules = rules,
        super._();

  factory _$_PackageOptions.fromJson(Map<String, dynamic> json) =>
      _$$_PackageOptionsFromJson(json);

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

  final Map<String, RuleOptions>? _rules;
  @override
  Map<String, RuleOptions>? get rules {
    final value = _rules;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PackageOptions(includes: $includes, excludes: $excludes, rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageOptions &&
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
  _$$_PackageOptionsCopyWith<_$_PackageOptions> get copyWith =>
      __$$_PackageOptionsCopyWithImpl<_$_PackageOptions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageOptionsToJson(
      this,
    );
  }
}

abstract class _PackageOptions extends PackageOptions {
  const factory _PackageOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, RuleOptions>? rules}) = _$_PackageOptions;
  const _PackageOptions._() : super._();

  factory _PackageOptions.fromJson(Map<String, dynamic> json) =
      _$_PackageOptions.fromJson;

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  @override
  Map<String, RuleOptions>? get rules;
  @override
  @JsonKey(ignore: true)
  _$$_PackageOptionsCopyWith<_$_PackageOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
