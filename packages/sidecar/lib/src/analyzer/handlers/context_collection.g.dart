// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_collection.dart';

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

String $createContextCollectionHash() =>
    r'fd8f079362406f7186c71e27f82426825736c86b';

/// See also [createContextCollection].
class CreateContextCollectionProvider
    extends AutoDisposeProvider<AnalysisContextCollection> {
  CreateContextCollectionProvider(
    this.roots,
  ) : super(
          (ref) => createContextCollection(
            ref,
            roots,
          ),
          from: createContextCollectionProvider,
          name: r'createContextCollectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $createContextCollectionHash,
        );

  final List<String> roots;

  @override
  bool operator ==(Object other) {
    return other is CreateContextCollectionProvider && other.roots == roots;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roots.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef CreateContextCollectionRef
    = AutoDisposeProviderRef<AnalysisContextCollection>;

/// See also [createContextCollection].
final createContextCollectionProvider = CreateContextCollectionFamily();

class CreateContextCollectionFamily extends Family<AnalysisContextCollection> {
  CreateContextCollectionFamily();

  CreateContextCollectionProvider call(
    List<String> roots,
  ) {
    return CreateContextCollectionProvider(
      roots,
    );
  }

  @override
  AutoDisposeProvider<AnalysisContextCollection> getProviderOverride(
    covariant CreateContextCollectionProvider provider,
  ) {
    return call(
      provider.roots,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'createContextCollectionProvider';
}
