// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_results_provider.dart';

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

String $analysisResultsForFileHash() =>
    r'de9bd03737c90defa504e72ed6a944445e7c0cf9';

/// See also [analysisResultsForFile].
class AnalysisResultsForFileProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  AnalysisResultsForFileProvider(
    this.file,
  ) : super(
          (ref) => analysisResultsForFile(
            ref,
            file,
          ),
          from: analysisResultsForFileProvider,
          name: r'analysisResultsForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analysisResultsForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is AnalysisResultsForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalysisResultsForFileRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [analysisResultsForFile].
final analysisResultsForFileProvider = AnalysisResultsForFileFamily();

class AnalysisResultsForFileFamily extends Family<AsyncValue<List<dynamic>>> {
  AnalysisResultsForFileFamily();

  AnalysisResultsForFileProvider call(
    AnalyzedFile file,
  ) {
    return AnalysisResultsForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
    covariant AnalysisResultsForFileProvider provider,
  ) {
    return call(
      provider.file,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'analysisResultsForFileProvider';
}

String $lintResultsForFileHash() => r'fca6c1b2722a281f7f133682d7134d3e2d12fd36';

/// See also [lintResultsForFile].
class LintResultsForFileProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  LintResultsForFileProvider(
    this.file,
  ) : super(
          (ref) => lintResultsForFile(
            ref,
            file,
          ),
          from: lintResultsForFileProvider,
          name: r'lintResultsForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $lintResultsForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is LintResultsForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef LintResultsForFileRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [lintResultsForFile].
final lintResultsForFileProvider = LintResultsForFileFamily();

class LintResultsForFileFamily extends Family<AsyncValue<List<dynamic>>> {
  LintResultsForFileFamily();

  LintResultsForFileProvider call(
    AnalyzedFile file,
  ) {
    return LintResultsForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
    covariant LintResultsForFileProvider provider,
  ) {
    return call(
      provider.file,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'lintResultsForFileProvider';
}

String $lintResultsForRootHash() => r'9a98983d6d41c335a462b00e87a8b971b247b21b';

/// See also [lintResultsForRoot].
class LintResultsForRootProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
  LintResultsForRootProvider(
    this.root,
  ) : super(
          (ref) => lintResultsForRoot(
            ref,
            root,
          ),
          from: lintResultsForRootProvider,
          name: r'lintResultsForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $lintResultsForRootHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is LintResultsForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef LintResultsForRootRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [lintResultsForRoot].
final lintResultsForRootProvider = LintResultsForRootFamily();

class LintResultsForRootFamily extends Family<AsyncValue<List<dynamic>>> {
  LintResultsForRootFamily();

  LintResultsForRootProvider call(
    ActiveContextRoot root,
  ) {
    return LintResultsForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
    covariant LintResultsForRootProvider provider,
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
  String? get name => r'lintResultsForRootProvider';
}

String $analysisResultsForContextHash() =>
    r'4a60f1fccf53786f89e709afb21f5370010a03e9';

/// See also [analysisResultsForContext].
class AnalysisResultsForContextProvider
    extends AutoDisposeProvider<List<dynamic>> {
  AnalysisResultsForContextProvider(
    this.root,
  ) : super(
          (ref) => analysisResultsForContext(
            ref,
            root,
          ),
          from: analysisResultsForContextProvider,
          name: r'analysisResultsForContextProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analysisResultsForContextHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is AnalysisResultsForContextProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalysisResultsForContextRef = AutoDisposeProviderRef<List<dynamic>>;

/// See also [analysisResultsForContext].
final analysisResultsForContextProvider = AnalysisResultsForContextFamily();

class AnalysisResultsForContextFamily extends Family<List<dynamic>> {
  AnalysisResultsForContextFamily();

  AnalysisResultsForContextProvider call(
    ActiveContextRoot root,
  ) {
    return AnalysisResultsForContextProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<List<dynamic>> getProviderOverride(
    covariant AnalysisResultsForContextProvider provider,
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
  String? get name => r'analysisResultsForContextProvider';
}
