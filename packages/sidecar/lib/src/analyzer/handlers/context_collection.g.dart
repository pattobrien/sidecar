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

String $contextCollectionHash() => r'42d8764cbac783ba94bbce81ecd9423ec715746f';

/// See also [contextCollection].
class ContextCollectionProvider
    extends AutoDisposeProvider<AnalysisContextCollection> {
  ContextCollectionProvider(
    this.roots,
  ) : super(
          (ref) => contextCollection(
            ref,
            roots,
          ),
          from: contextCollectionProvider,
          name: r'contextCollectionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $contextCollectionHash,
        );

  final List<String> roots;

  @override
  bool operator ==(Object other) {
    return other is ContextCollectionProvider && other.roots == roots;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roots.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ContextCollectionRef
    = AutoDisposeProviderRef<AnalysisContextCollection>;

/// See also [contextCollection].
final contextCollectionProvider = ContextCollectionFamily();

class ContextCollectionFamily extends Family<AnalysisContextCollection> {
  ContextCollectionFamily();

  ContextCollectionProvider call(
    List<String> roots,
  ) {
    return ContextCollectionProvider(
      roots,
    );
  }

  @override
  AutoDisposeProvider<AnalysisContextCollection> getProviderOverride(
    covariant ContextCollectionProvider provider,
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
  String? get name => r'contextCollectionProvider';
}
