// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzed_files_provider.dart';

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

String $analyzedFilesForRootHash() =>
    r'99a3db39f96b2779df343959012e0d781546774f';

/// See also [analyzedFilesForRoot].
class AnalyzedFilesForRootProvider extends Provider<List<AnalyzedFile>> {
  AnalyzedFilesForRootProvider(
    this.root,
  ) : super(
          (ref) => analyzedFilesForRoot(
            ref,
            root,
          ),
          from: analyzedFilesForRootProvider,
          name: r'analyzedFilesForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analyzedFilesForRootHash,
        );

  final ActiveContextRoot root;

  @override
  bool operator ==(Object other) {
    return other is AnalyzedFilesForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalyzedFilesForRootRef = ProviderRef<List<AnalyzedFile>>;

/// See also [analyzedFilesForRoot].
final analyzedFilesForRootProvider = AnalyzedFilesForRootFamily();

class AnalyzedFilesForRootFamily extends Family<List<AnalyzedFile>> {
  AnalyzedFilesForRootFamily();

  AnalyzedFilesForRootProvider call(
    ActiveContextRoot root,
  ) {
    return AnalyzedFilesForRootProvider(
      root,
    );
  }

  @override
  Provider<List<AnalyzedFile>> getProviderOverride(
    covariant AnalyzedFilesForRootProvider provider,
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
  String? get name => r'analyzedFilesForRootProvider';
}

String $analyzedFileForPathHash() =>
    r'171951309a2a70e262f3e782a82a195323691f26';

/// See also [analyzedFileForPath].
class AnalyzedFileForPathProvider extends AutoDisposeProvider<AnalyzedFile> {
  AnalyzedFileForPathProvider(
    this.path,
  ) : super(
          (ref) => analyzedFileForPath(
            ref,
            path,
          ),
          from: analyzedFileForPathProvider,
          name: r'analyzedFileForPathProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analyzedFileForPathHash,
        );

  final String path;

  @override
  bool operator ==(Object other) {
    return other is AnalyzedFileForPathProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalyzedFileForPathRef = AutoDisposeProviderRef<AnalyzedFile>;

/// See also [analyzedFileForPath].
final analyzedFileForPathProvider = AnalyzedFileForPathFamily();

class AnalyzedFileForPathFamily extends Family<AnalyzedFile> {
  AnalyzedFileForPathFamily();

  AnalyzedFileForPathProvider call(
    String path,
  ) {
    return AnalyzedFileForPathProvider(
      path,
    );
  }

  @override
  AutoDisposeProvider<AnalyzedFile> getProviderOverride(
    covariant AnalyzedFileForPathProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'analyzedFileForPathProvider';
}
