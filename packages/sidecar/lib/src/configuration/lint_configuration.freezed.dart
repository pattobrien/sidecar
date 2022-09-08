// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lint_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LintConfiguration _$LintConfigurationFromJson(Map<String, dynamic> json) {
  return _LintConfiguration.fromJson(json);
}

/// @nodoc
mixin _$LintConfiguration {
  String get id => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get configuration =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LintConfigurationCopyWith<LintConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LintConfigurationCopyWith<$Res> {
  factory $LintConfigurationCopyWith(
          LintConfiguration value, $Res Function(LintConfiguration) then) =
      _$LintConfigurationCopyWithImpl<$Res>;
  $Res call({String id, bool enabled, Map<dynamic, dynamic>? configuration});
}

/// @nodoc
class _$LintConfigurationCopyWithImpl<$Res>
    implements $LintConfigurationCopyWith<$Res> {
  _$LintConfigurationCopyWithImpl(this._value, this._then);

  final LintConfiguration _value;
  // ignore: unused_field
  final $Res Function(LintConfiguration) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? enabled = freezed,
    Object? configuration = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$$_LintConfigurationCopyWith<$Res>
    implements $LintConfigurationCopyWith<$Res> {
  factory _$$_LintConfigurationCopyWith(_$_LintConfiguration value,
          $Res Function(_$_LintConfiguration) then) =
      __$$_LintConfigurationCopyWithImpl<$Res>;
  @override
  $Res call({String id, bool enabled, Map<dynamic, dynamic>? configuration});
}

/// @nodoc
class __$$_LintConfigurationCopyWithImpl<$Res>
    extends _$LintConfigurationCopyWithImpl<$Res>
    implements _$$_LintConfigurationCopyWith<$Res> {
  __$$_LintConfigurationCopyWithImpl(
      _$_LintConfiguration _value, $Res Function(_$_LintConfiguration) _then)
      : super(_value, (v) => _then(v as _$_LintConfiguration));

  @override
  _$_LintConfiguration get _value => super._value as _$_LintConfiguration;

  @override
  $Res call({
    Object? id = freezed,
    Object? enabled = freezed,
    Object? configuration = freezed,
  }) {
    return _then(_$_LintConfiguration(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      configuration: configuration == freezed
          ? _value._configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LintConfiguration extends _LintConfiguration {
  const _$_LintConfiguration(
      {required this.id,
      required this.enabled,
      required final Map<dynamic, dynamic>? configuration})
      : _configuration = configuration,
        super._();

  factory _$_LintConfiguration.fromJson(Map<String, dynamic> json) =>
      _$$_LintConfigurationFromJson(json);

  @override
  final String id;
  @override
  final bool enabled;
  final Map<dynamic, dynamic>? _configuration;
  @override
  Map<dynamic, dynamic>? get configuration {
    final value = _configuration;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LintConfiguration(id: $id, enabled: $enabled, configuration: $configuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LintConfiguration &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality()
                .equals(other._configuration, _configuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(_configuration));

  @JsonKey(ignore: true)
  @override
  _$$_LintConfigurationCopyWith<_$_LintConfiguration> get copyWith =>
      __$$_LintConfigurationCopyWithImpl<_$_LintConfiguration>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LintConfigurationToJson(
      this,
    );
  }
}

abstract class _LintConfiguration extends LintConfiguration {
  const factory _LintConfiguration(
          {required final String id,
          required final bool enabled,
          required final Map<dynamic, dynamic>? configuration}) =
      _$_LintConfiguration;
  const _LintConfiguration._() : super._();

  factory _LintConfiguration.fromJson(Map<String, dynamic> json) =
      _$_LintConfiguration.fromJson;

  @override
  String get id;
  @override
  bool get enabled;
  @override
  Map<dynamic, dynamic>? get configuration;
  @override
  @JsonKey(ignore: true)
  _$$_LintConfigurationCopyWith<_$_LintConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}
