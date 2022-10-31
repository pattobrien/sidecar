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
  Uri get root => throw _privateConstructorUsedError;
  List<File> get files => throw _privateConstructorUsedError;
  List<Package> get dependencies => throw _privateConstructorUsedError;
  List<LintPackageConfiguration> get lintPackages =>
      throw _privateConstructorUsedError;
  List<AssistPackageConfiguration> get assistPackages =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res>;
  $Res call(
      {Uri root,
      List<File> files,
      List<Package> dependencies,
      List<LintPackageConfiguration> lintPackages,
      List<AssistPackageConfiguration> assistPackages});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  final Project _value;
  // ignore: unused_field
  final $Res Function(Project) _then;

  @override
  $Res call({
    Object? root = freezed,
    Object? files = freezed,
    Object? dependencies = freezed,
    Object? lintPackages = freezed,
    Object? assistPackages = freezed,
  }) {
    return _then(_value.copyWith(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
      dependencies: dependencies == freezed
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lintPackages: lintPackages == freezed
          ? _value.lintPackages
          : lintPackages // ignore: cast_nullable_to_non_nullable
              as List<LintPackageConfiguration>,
      assistPackages: assistPackages == freezed
          ? _value.assistPackages
          : assistPackages // ignore: cast_nullable_to_non_nullable
              as List<AssistPackageConfiguration>,
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
      {Uri root,
      List<File> files,
      List<Package> dependencies,
      List<LintPackageConfiguration> lintPackages,
      List<AssistPackageConfiguration> assistPackages});
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
    Object? root = freezed,
    Object? files = freezed,
    Object? dependencies = freezed,
    Object? lintPackages = freezed,
    Object? assistPackages = freezed,
  }) {
    return _then(_$_Project(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      files: files == freezed
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File>,
      dependencies: dependencies == freezed
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lintPackages: lintPackages == freezed
          ? _value._lintPackages
          : lintPackages // ignore: cast_nullable_to_non_nullable
              as List<LintPackageConfiguration>,
      assistPackages: assistPackages == freezed
          ? _value._assistPackages
          : assistPackages // ignore: cast_nullable_to_non_nullable
              as List<AssistPackageConfiguration>,
    ));
  }
}

/// @nodoc

class _$_Project extends _Project {
  const _$_Project(
      {required this.root,
      final List<File> files = const <File>[],
      final List<Package> dependencies = const <Package>[],
      final List<LintPackageConfiguration> lintPackages =
          const <LintPackageConfiguration>[],
      final List<AssistPackageConfiguration> assistPackages =
          const <AssistPackageConfiguration>[]})
      : _files = files,
        _dependencies = dependencies,
        _lintPackages = lintPackages,
        _assistPackages = assistPackages,
        super._();

  @override
  final Uri root;
  final List<File> _files;
  @override
  @JsonKey()
  List<File> get files {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final List<Package> _dependencies;
  @override
  @JsonKey()
  List<Package> get dependencies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  final List<LintPackageConfiguration> _lintPackages;
  @override
  @JsonKey()
  List<LintPackageConfiguration> get lintPackages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lintPackages);
  }

  final List<AssistPackageConfiguration> _assistPackages;
  @override
  @JsonKey()
  List<AssistPackageConfiguration> get assistPackages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assistPackages);
  }

  @override
  String toString() {
    return 'Project(root: $root, files: $files, dependencies: $dependencies, lintPackages: $lintPackages, assistPackages: $assistPackages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Project &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality()
                .equals(other._lintPackages, _lintPackages) &&
            const DeepCollectionEquality()
                .equals(other._assistPackages, _assistPackages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(_files),
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(_lintPackages),
      const DeepCollectionEquality().hash(_assistPackages));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      __$$_ProjectCopyWithImpl<_$_Project>(this, _$identity);
}

abstract class _Project extends Project {
  const factory _Project(
      {required final Uri root,
      final List<File> files,
      final List<Package> dependencies,
      final List<LintPackageConfiguration> lintPackages,
      final List<AssistPackageConfiguration> assistPackages}) = _$_Project;
  const _Project._() : super._();

  @override
  Uri get root;
  @override
  List<File> get files;
  @override
  List<Package> get dependencies;
  @override
  List<LintPackageConfiguration> get lintPackages;
  @override
  List<AssistPackageConfiguration> get assistPackages;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      throw _privateConstructorUsedError;
}
