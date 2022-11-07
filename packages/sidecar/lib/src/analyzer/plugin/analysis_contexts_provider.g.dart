// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_contexts_provider.dart';

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

String $AllContextsNotifierHash() =>
    r'f0b770589dc9740b20780c9dad97ef79e10676a5';

/// See also [AllContextsNotifier].
final allContextsNotifierProvider =
    NotifierProvider<AllContextsNotifier, List<AnalysisContext>>(
  AllContextsNotifier.new,
  name: r'allContextsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $AllContextsNotifierHash,
);
typedef AllContextsNotifierRef = NotifierProviderRef<List<AnalysisContext>>;

abstract class _$AllContextsNotifier extends Notifier<List<AnalysisContext>> {
  @override
  List<AnalysisContext> build();
}

String $ActiveContextNotifierHash() =>
    r'05f2970bbea4e0dc88ef1075c1a4e4c89f1556c4';

/// See also [ActiveContextNotifier].
final activeContextNotifierProvider =
    NotifierProvider<ActiveContextNotifier, ActiveContext?>(
  ActiveContextNotifier.new,
  name: r'activeContextNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $ActiveContextNotifierHash,
);
typedef ActiveContextNotifierRef = NotifierProviderRef<ActiveContext?>;

abstract class _$ActiveContextNotifier extends Notifier<ActiveContext?> {
  @override
  ActiveContext? build();
}

String $analysisContextForRootHash() =>
    r'ee1f4f5cfb86e56af9bb537eb1340ca795066be7';

/// See also [analysisContextForRoot].
class AnalysisContextForRootProvider extends Provider<AnalysisContext> {
  AnalysisContextForRootProvider(
    this.context,
  ) : super(
          (ref) => analysisContextForRoot(
            ref,
            context,
          ),
          from: analysisContextForRootProvider,
          name: r'analysisContextForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analysisContextForRootHash,
        );

  final Context context;

  @override
  bool operator ==(Object other) {
    return other is AnalysisContextForRootProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalysisContextForRootRef = ProviderRef<AnalysisContext>;

/// See also [analysisContextForRoot].
final analysisContextForRootProvider = AnalysisContextForRootFamily();

class AnalysisContextForRootFamily extends Family<AnalysisContext> {
  AnalysisContextForRootFamily();

  AnalysisContextForRootProvider call(
    Context context,
  ) {
    return AnalysisContextForRootProvider(
      context,
    );
  }

  @override
  Provider<AnalysisContext> getProviderOverride(
    covariant AnalysisContextForRootProvider provider,
  ) {
    return call(
      provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'analysisContextForRootProvider';
}
