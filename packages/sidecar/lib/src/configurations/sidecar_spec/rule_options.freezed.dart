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

RuleOptions _$RuleOptionsFromJson(Map<String, dynamic> json) {
  return _RuleOptions.fromJson(json);
}

/// @nodoc
mixin _$RuleOptions {
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes => throw _privateConstructorUsedError;
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RuleOptionsCopyWith<RuleOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RuleOptionsCopyWith<$Res> {
  factory $RuleOptionsCopyWith(
          RuleOptions value, $Res Function(RuleOptions) then) =
      _$RuleOptionsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      bool? enabled});
}

/// @nodoc
class _$RuleOptionsCopyWithImpl<$Res> implements $RuleOptionsCopyWith<$Res> {
  _$RuleOptionsCopyWithImpl(this._value, this._then);

  final RuleOptions _value;
  // ignore: unused_field
  final $Res Function(RuleOptions) _then;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? enabled = freezed,
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
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_RuleOptionsCopyWith<$Res>
    implements $RuleOptionsCopyWith<$Res> {
  factory _$$_RuleOptionsCopyWith(
          _$_RuleOptions value, $Res Function(_$_RuleOptions) then) =
      __$$_RuleOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      bool? enabled});
}

/// @nodoc
class __$$_RuleOptionsCopyWithImpl<$Res> extends _$RuleOptionsCopyWithImpl<$Res>
    implements _$$_RuleOptionsCopyWith<$Res> {
  __$$_RuleOptionsCopyWithImpl(
      _$_RuleOptions _value, $Res Function(_$_RuleOptions) _then)
      : super(_value, (v) => _then(v as _$_RuleOptions));

  @override
  _$_RuleOptions get _value => super._value as _$_RuleOptions;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? enabled = freezed,
  }) {
    return _then(_$_RuleOptions(
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RuleOptions extends _RuleOptions {
  const _$_RuleOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      this.enabled})
      : _includes = includes,
        _excludes = excludes,
        super._();

  factory _$_RuleOptions.fromJson(Map<String, dynamic> json) =>
      _$$_RuleOptionsFromJson(json);

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

  @override
  String toString() {
    return 'RuleOptions(includes: $includes, excludes: $excludes, enabled: $enabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RuleOptions &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            const DeepCollectionEquality().equals(other.enabled, enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      const DeepCollectionEquality().hash(enabled));

  @JsonKey(ignore: true)
  @override
  _$$_RuleOptionsCopyWith<_$_RuleOptions> get copyWith =>
      __$$_RuleOptionsCopyWithImpl<_$_RuleOptions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RuleOptionsToJson(
      this,
    );
  }
}

abstract class _RuleOptions extends RuleOptions {
  const factory _RuleOptions(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final bool? enabled}) = _$_RuleOptions;
  const _RuleOptions._() : super._();

  factory _RuleOptions.fromJson(Map<String, dynamic> json) =
      _$_RuleOptions.fromJson;

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  @override
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$_RuleOptionsCopyWith<_$_RuleOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
