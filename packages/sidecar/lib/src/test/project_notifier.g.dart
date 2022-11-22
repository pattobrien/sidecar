// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_notifier.dart';

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

String $ProjectNotifierHash() => r'26f258b976974adfae612825d7da5f9291c3039f';

/// See also [ProjectNotifier].
class ProjectNotifierProvider
    extends AutoDisposeNotifierProviderImpl<ProjectNotifier, Project> {
  ProjectNotifierProvider(
    this.name,
    this.folder, {
    this.sidecarConfiguration,
    this.source,
  }) : super(
          () => ProjectNotifier()
            ..name = name
            ..folder = folder
            ..sidecarConfiguration = sidecarConfiguration
            ..source = source,
          from: projectNotifierProvider,
          name: r'projectNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $ProjectNotifierHash,
        );

  final String name;
  final Folder folder;
  final SidecarSpec? sidecarConfiguration;
  final Map<String, String>? source;

  @override
  bool operator ==(Object other) {
    return other is ProjectNotifierProvider &&
        other.name == name &&
        other.folder == folder &&
        other.sidecarConfiguration == sidecarConfiguration &&
        other.source == source;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);
    hash = _SystemHash.combine(hash, folder.hashCode);
    hash = _SystemHash.combine(hash, sidecarConfiguration.hashCode);
    hash = _SystemHash.combine(hash, source.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Project runNotifierBuild(
    covariant _$ProjectNotifier notifier,
  ) {
    return notifier.build(
      name,
      folder,
      sidecarConfiguration: sidecarConfiguration,
      source: source,
    );
  }
}

typedef ProjectNotifierRef = AutoDisposeNotifierProviderRef<Project>;

/// See also [ProjectNotifier].
final projectNotifierProvider = ProjectNotifierFamily();

class ProjectNotifierFamily extends Family<Project> {
  ProjectNotifierFamily();

  ProjectNotifierProvider call(
    String name,
    Folder folder, {
    SidecarSpec? sidecarConfiguration,
    Map<String, String>? source,
  }) {
    return ProjectNotifierProvider(
      name,
      folder,
      sidecarConfiguration: sidecarConfiguration,
      source: source,
    );
  }

  @override
  AutoDisposeNotifierProviderImpl<ProjectNotifier, Project> getProviderOverride(
    covariant ProjectNotifierProvider provider,
  ) {
    return call(
      provider.name,
      provider.folder,
      sidecarConfiguration: provider.sidecarConfiguration,
      source: provider.source,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'projectNotifierProvider';
}

abstract class _$ProjectNotifier extends BuildlessAutoDisposeNotifier<Project> {
  late final String name;
  late final Folder folder;
  late final SidecarSpec? sidecarConfiguration;
  late final Map<String, String>? source;

  Project build(
    String name,
    Folder folder, {
    SidecarSpec? sidecarConfiguration,
    Map<String, String>? source,
  });
}
