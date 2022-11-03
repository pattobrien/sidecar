// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotations_provider.dart';

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

String $sidecarAnnotationsForRootHash() =>
    r'3233a269d68ddfc32817f20fd44d87986cfd1d4d';

/// See also [sidecarAnnotationsForRoot].
class SidecarAnnotationsForRootProvider
    extends AutoDisposeProvider<List<SidecarAnnotatedNode>> {
  SidecarAnnotationsForRootProvider(
    this.root,
  ) : super(
          (ref) => sidecarAnnotationsForRoot(
            ref,
            root,
          ),
          from: sidecarAnnotationsForRootProvider,
          name: r'sidecarAnnotationsForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $sidecarAnnotationsForRootHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is SidecarAnnotationsForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef SidecarAnnotationsForRootRef
    = AutoDisposeProviderRef<List<SidecarAnnotatedNode>>;

/// See also [sidecarAnnotationsForRoot].
final sidecarAnnotationsForRootProvider = SidecarAnnotationsForRootFamily();

class SidecarAnnotationsForRootFamily
    extends Family<List<SidecarAnnotatedNode>> {
  SidecarAnnotationsForRootFamily();

  SidecarAnnotationsForRootProvider call(
    ActiveContextRoot root,
  ) {
    return SidecarAnnotationsForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<List<SidecarAnnotatedNode>> getProviderOverride(
    covariant SidecarAnnotationsForRootProvider provider,
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
  String? get name => r'sidecarAnnotationsForRootProvider';
}
