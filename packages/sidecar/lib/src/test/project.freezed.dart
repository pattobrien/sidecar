// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Project {
  String get name => throw _privateConstructorUsedError;
  Uri get parent => throw _privateConstructorUsedError;
  ResourceProvider get resourceProvider => throw _privateConstructorUsedError;
  ProjectConfiguration? get sidecarConfiguration =>
      throw _privateConstructorUsedError;
  Map<String, String>? get source => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res>;
  $Res call(
      {String name,
      Uri parent,
      ResourceProvider resourceProvider,
      ProjectConfiguration? sidecarConfiguration,
      Map<String, String>? source});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  final Project _value;
  // ignore: unused_field
  final $Res Function(Project) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? parent = freezed,
    Object? resourceProvider = freezed,
    Object? sidecarConfiguration = freezed,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parent: parent == freezed
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Uri,
      resourceProvider: resourceProvider == freezed
          ? _value.resourceProvider
          : resourceProvider // ignore: cast_nullable_to_non_nullable
              as ResourceProvider,
      sidecarConfiguration: sidecarConfiguration == freezed
          ? _value.sidecarConfiguration
          : sidecarConfiguration // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$_ProjectCopyWith(
          _$_Project value, $Res Function(_$_Project) then) =
      __$$_ProjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      Uri parent,
      ResourceProvider resourceProvider,
      ProjectConfiguration? sidecarConfiguration,
      Map<String, String>? source});
}

/// @nodoc
class __$$_ProjectCopyWithImpl<$Res> extends _$ProjectCopyWithImpl<$Res>
    implements _$$_ProjectCopyWith<$Res> {
  __$$_ProjectCopyWithImpl(_$_Project _value, $Res Function(_$_Project) _then)
      : super(_value, (v) => _then(v as _$_Project));

  @override
  _$_Project get _value => super._value as _$_Project;

  @override
  $Res call({
    Object? name = freezed,
    Object? parent = freezed,
    Object? resourceProvider = freezed,
    Object? sidecarConfiguration = freezed,
    Object? source = freezed,
  }) {
    return _then(_$_Project(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parent: parent == freezed
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Uri,
      resourceProvider: resourceProvider == freezed
          ? _value.resourceProvider
          : resourceProvider // ignore: cast_nullable_to_non_nullable
              as ResourceProvider,
      sidecarConfiguration: sidecarConfiguration == freezed
          ? _value.sidecarConfiguration
          : sidecarConfiguration // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration?,
      source: source == freezed
          ? _value._source
          : source // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc

class _$_Project extends _Project {
  const _$_Project(
      {required this.name,
      required this.parent,
      required this.resourceProvider,
      this.sidecarConfiguration,
      final Map<String, String>? source})
      : _source = source,
        super._();

  @override
  final String name;
  @override
  final Uri parent;
  @override
  final ResourceProvider resourceProvider;
  @override
  final ProjectConfiguration? sidecarConfiguration;
  final Map<String, String>? _source;
  @override
  Map<String, String>? get source {
    final value = _source;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Project(name: $name, parent: $parent, resourceProvider: $resourceProvider, sidecarConfiguration: $sidecarConfiguration, source: $source)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Project &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.parent, parent) &&
            const DeepCollectionEquality()
                .equals(other.resourceProvider, resourceProvider) &&
            const DeepCollectionEquality()
                .equals(other.sidecarConfiguration, sidecarConfiguration) &&
            const DeepCollectionEquality().equals(other._source, _source));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(parent),
      const DeepCollectionEquality().hash(resourceProvider),
      const DeepCollectionEquality().hash(sidecarConfiguration),
      const DeepCollectionEquality().hash(_source));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      __$$_ProjectCopyWithImpl<_$_Project>(this, _$identity);
}

abstract class _Project extends Project {
  const factory _Project(
      {required final String name,
      required final Uri parent,
      required final ResourceProvider resourceProvider,
      final ProjectConfiguration? sidecarConfiguration,
      final Map<String, String>? source}) = _$_Project;
  const _Project._() : super._();

  @override
  String get name;
  @override
  Uri get parent;
  @override
  ResourceProvider get resourceProvider;
  @override
  ProjectConfiguration? get sidecarConfiguration;
  @override
  Map<String, String>? get source;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      throw _privateConstructorUsedError;
}
