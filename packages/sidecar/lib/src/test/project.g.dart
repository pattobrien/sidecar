// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $ProjectNotifierHash() => r'cb5fec1778f7bfc2c13667b4f1e927fa2f0a7bee';

/// See also [ProjectNotifier].
class ProjectNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProjectNotifier, Project> {
  ProjectNotifierProvider(
    this.name, {
    this.isFlutter = true,
  }) : super(
          () => ProjectNotifier()
            ..name = name
            ..isFlutter = isFlutter,
          from: projectNotifierProvider,
          name: r'projectNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $ProjectNotifierHash,
        );

  final String name;
  final bool isFlutter;

  @override
  bool operator ==(Object other) {
    return other is ProjectNotifierProvider &&
        other.name == name &&
        other.isFlutter == isFlutter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);
    hash = _SystemHash.combine(hash, isFlutter.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Project> runNotifierBuild(
    covariant _$ProjectNotifier notifier,
  ) {
    return notifier.build(
      name,
      isFlutter: isFlutter,
    );
  }
}

typedef ProjectNotifierRef = AutoDisposeAsyncNotifierProviderRef<Project>;

/// See also [ProjectNotifier].
final projectNotifierProvider = ProjectNotifierFamily();

class ProjectNotifierFamily extends Family<AsyncValue<Project>> {
  ProjectNotifierFamily();

  ProjectNotifierProvider call(
    String name, {
    bool isFlutter = true,
  }) {
    return ProjectNotifierProvider(
      name,
      isFlutter: isFlutter,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<ProjectNotifier, Project>
      getProviderOverride(
    covariant ProjectNotifierProvider provider,
  ) {
    return call(
      provider.name,
      isFlutter: provider.isFlutter,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'projectNotifierProvider';
}

abstract class _$ProjectNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Project> {
  late final String name;
  late final bool isFlutter;

  FutureOr<Project> build(
    String name, {
    bool isFlutter = true,
  });
}
