// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_fix_results.dart';

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

String $requestQuickFixesHash() => r'9eadf2e584fa47b27e587b4e3f972f98208f7a8b';

/// See also [requestQuickFixes].
class RequestQuickFixesProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  RequestQuickFixesProvider(
    this.analyzer,
    this.request,
  ) : super(
          (ref) => requestQuickFixes(
            ref,
            analyzer,
            request,
          ),
          from: requestQuickFixesProvider,
          name: r'requestQuickFixesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $requestQuickFixesHash,
        );

  final dynamic analyzer;
  final dynamic request;

  @override
  bool operator ==(Object other) {
    return other is RequestQuickFixesProvider &&
        other.analyzer == analyzer &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, analyzer.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef RequestQuickFixesRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [requestQuickFixes].
final requestQuickFixesProvider = RequestQuickFixesFamily();

class RequestQuickFixesFamily extends Family<AsyncValue<List<dynamic>>> {
  RequestQuickFixesFamily();

  RequestQuickFixesProvider call(
    dynamic analyzer,
    dynamic request,
  ) {
    return RequestQuickFixesProvider(
      analyzer,
      request,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
    covariant RequestQuickFixesProvider provider,
  ) {
    return call(
      provider.analyzer,
      provider.request,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'requestQuickFixesProvider';
}

String $quickFixResultsForRootHash() =>
    r'b32f4523b26ad42e103c76334c05bd1ccc56425e';

/// See also [quickFixResultsForRoot].
class QuickFixResultsForRootProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  QuickFixResultsForRootProvider(
    this.root,
  ) : super(
          (ref) => quickFixResultsForRoot(
            ref,
            root,
          ),
          from: quickFixResultsForRootProvider,
          name: r'quickFixResultsForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $quickFixResultsForRootHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is QuickFixResultsForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef QuickFixResultsForRootRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [quickFixResultsForRoot].
final quickFixResultsForRootProvider = QuickFixResultsForRootFamily();

class QuickFixResultsForRootFamily extends Family<AsyncValue<List<dynamic>>> {
  QuickFixResultsForRootFamily();

  QuickFixResultsForRootProvider call(
    ActiveContextRoot root,
  ) {
    return QuickFixResultsForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
    covariant QuickFixResultsForRootProvider provider,
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
  String? get name => r'quickFixResultsForRootProvider';
}

String $awaitContextStillAnalyzingHash() =>
    r'7541a90b087f5838b81bed570b7722127b5f153b';

/// See also [awaitContextStillAnalyzing].
class AwaitContextStillAnalyzingProvider
    extends AutoDisposeFutureProvider<void> {
  AwaitContextStillAnalyzingProvider(
    this.root,
  ) : super(
          (ref) => awaitContextStillAnalyzing(
            ref,
            root,
          ),
          from: awaitContextStillAnalyzingProvider,
          name: r'awaitContextStillAnalyzingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $awaitContextStillAnalyzingHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is AwaitContextStillAnalyzingProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AwaitContextStillAnalyzingRef = AutoDisposeFutureProviderRef<void>;

/// See also [awaitContextStillAnalyzing].
final awaitContextStillAnalyzingProvider = AwaitContextStillAnalyzingFamily();

class AwaitContextStillAnalyzingFamily extends Family<AsyncValue<void>> {
  AwaitContextStillAnalyzingFamily();

  AwaitContextStillAnalyzingProvider call(
    ActiveContextRoot root,
  ) {
    return AwaitContextStillAnalyzingProvider(
      root,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant AwaitContextStillAnalyzingProvider provider,
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
  String? get name => r'awaitContextStillAnalyzingProvider';
}
