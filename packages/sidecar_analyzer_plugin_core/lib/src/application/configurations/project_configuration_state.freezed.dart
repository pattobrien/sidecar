// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_configuration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectConfigurationState {
  ProjectConfiguration? get configuration => throw _privateConstructorUsedError;
  List<YamlSourceError> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectConfigurationStateCopyWith<ProjectConfigurationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectConfigurationStateCopyWith<$Res> {
  factory $ProjectConfigurationStateCopyWith(ProjectConfigurationState value,
          $Res Function(ProjectConfigurationState) then) =
      _$ProjectConfigurationStateCopyWithImpl<$Res>;
  $Res call(
      {ProjectConfiguration? configuration, List<YamlSourceError> errors});
}

/// @nodoc
class _$ProjectConfigurationStateCopyWithImpl<$Res>
    implements $ProjectConfigurationStateCopyWith<$Res> {
  _$ProjectConfigurationStateCopyWithImpl(this._value, this._then);

  final ProjectConfigurationState _value;
  // ignore: unused_field
  final $Res Function(ProjectConfigurationState) _then;

  @override
  $Res call({
    Object? configuration = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration?,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<YamlSourceError>,
    ));
  }
}

/// @nodoc
abstract class _$$_ProjectConfigurationStateCopyWith<$Res>
    implements $ProjectConfigurationStateCopyWith<$Res> {
  factory _$$_ProjectConfigurationStateCopyWith(
          _$_ProjectConfigurationState value,
          $Res Function(_$_ProjectConfigurationState) then) =
      __$$_ProjectConfigurationStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {ProjectConfiguration? configuration, List<YamlSourceError> errors});
}

/// @nodoc
class __$$_ProjectConfigurationStateCopyWithImpl<$Res>
    extends _$ProjectConfigurationStateCopyWithImpl<$Res>
    implements _$$_ProjectConfigurationStateCopyWith<$Res> {
  __$$_ProjectConfigurationStateCopyWithImpl(
      _$_ProjectConfigurationState _value,
      $Res Function(_$_ProjectConfigurationState) _then)
      : super(_value, (v) => _then(v as _$_ProjectConfigurationState));

  @override
  _$_ProjectConfigurationState get _value =>
      super._value as _$_ProjectConfigurationState;

  @override
  $Res call({
    Object? configuration = freezed,
    Object? errors = freezed,
  }) {
    return _then(_$_ProjectConfigurationState(
      configuration: configuration == freezed
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration?,
      errors: errors == freezed
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<YamlSourceError>,
    ));
  }
}

/// @nodoc

class _$_ProjectConfigurationState extends _ProjectConfigurationState {
  const _$_ProjectConfigurationState(
      {required this.configuration,
      final List<YamlSourceError> errors = const []})
      : _errors = errors,
        super._();

  @override
  final ProjectConfiguration? configuration;
  final List<YamlSourceError> _errors;
  @override
  @JsonKey()
  List<YamlSourceError> get errors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'ProjectConfigurationState(configuration: $configuration, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectConfigurationState &&
            const DeepCollectionEquality()
                .equals(other.configuration, configuration) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(configuration),
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectConfigurationStateCopyWith<_$_ProjectConfigurationState>
      get copyWith => __$$_ProjectConfigurationStateCopyWithImpl<
          _$_ProjectConfigurationState>(this, _$identity);
}

abstract class _ProjectConfigurationState extends ProjectConfigurationState {
  const factory _ProjectConfigurationState(
      {required final ProjectConfiguration? configuration,
      final List<YamlSourceError> errors}) = _$_ProjectConfigurationState;
  const _ProjectConfigurationState._() : super._();

  @override
  ProjectConfiguration? get configuration;
  @override
  List<YamlSourceError> get errors;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectConfigurationStateCopyWith<_$_ProjectConfigurationState>
      get copyWith => throw _privateConstructorUsedError;
}
