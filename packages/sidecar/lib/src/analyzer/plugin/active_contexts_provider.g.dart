// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_contexts_provider.dart';

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

String $activeContextsHash() => r'0bcdc3f53b8d91c1d357c97cb2cb9d99178f1e28';

/// See also [activeContexts].
final activeContextsProvider = AutoDisposeProvider<List<ActiveContext>>(
  activeContexts,
  name: r'activeContextsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $activeContextsHash,
);
typedef ActiveContextsRef = AutoDisposeProviderRef<List<ActiveContext>>;
String $activeContextForRootHash() =>
    r'a17cd7000c947a170159d44fb40c89aca8d4e99b';

/// See also [activeContextForRoot].
class ActiveContextForRootProvider extends AutoDisposeProvider<ActiveContext> {
  ActiveContextForRootProvider(
    this.root,
  ) : super(
          (ref) => activeContextForRoot(
            ref,
            root,
          ),
          from: activeContextForRootProvider,
          name: r'activeContextForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $activeContextForRootHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is ActiveContextForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ActiveContextForRootRef = AutoDisposeProviderRef<ActiveContext>;

/// See also [activeContextForRoot].
final activeContextForRootProvider = ActiveContextForRootFamily();

class ActiveContextForRootFamily extends Family<ActiveContext> {
  ActiveContextForRootFamily();

  ActiveContextForRootProvider call(
    ActiveContextRoot root,
  ) {
    return ActiveContextForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<ActiveContext> getProviderOverride(
    covariant ActiveContextForRootProvider provider,
  ) {
    return call(
      provider.root,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'activeContextForRootProvider';
}

String $activeContextRootsHash() => r'6f58bff3f87100dfa949ab1029cec44affc30fa6';

/// See also [activeContextRoots].
class ActiveContextRootsProvider
    extends AutoDisposeProvider<List<ActiveContextRoot>> {
  ActiveContextRootsProvider(
    this.analyzer,
  ) : super(
          (ref) => activeContextRoots(
            ref,
            analyzer,
          ),
          from: activeContextRootsProvider,
          name: r'activeContextRootsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $activeContextRootsHash,
        );

  final SidecarAnalyzer analyzer;

  @override
  bool operator ==(Object other) {
    return other is ActiveContextRootsProvider && other.analyzer == analyzer;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, analyzer.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ActiveContextRootsRef = AutoDisposeProviderRef<List<ActiveContextRoot>>;

/// See also [activeContextRoots].
final activeContextRootsProvider = ActiveContextRootsFamily();

class ActiveContextRootsFamily extends Family<List<ActiveContextRoot>> {
  ActiveContextRootsFamily();

  ActiveContextRootsProvider call(
    SidecarAnalyzer analyzer,
  ) {
    return ActiveContextRootsProvider(
      analyzer,
    );
  }

  @override
  AutoDisposeProvider<List<ActiveContextRoot>> getProviderOverride(
    covariant ActiveContextRootsProvider provider,
  ) {
    return call(
      provider.analyzer,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'activeContextRootsProvider';
}
