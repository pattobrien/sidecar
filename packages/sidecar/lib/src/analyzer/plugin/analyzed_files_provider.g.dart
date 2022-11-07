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
    r'e56fee0f04cbc615efb5b9c31fec4a7a6eb81890';

/// See also [analyzedFilesForRoot].
class AnalyzedFilesForRootProvider
    extends AutoDisposeProvider<List<AnalyzedFile>> {
  AnalyzedFilesForRootProvider(
    this.context,
  ) : super(
          (ref) => analyzedFilesForRoot(
            ref,
            context,
          ),
          from: analyzedFilesForRootProvider,
          name: r'analyzedFilesForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $analyzedFilesForRootHash,
        );

  final Context context;

  @override
  bool operator ==(Object other) {
    return other is AnalyzedFilesForRootProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AnalyzedFilesForRootRef = AutoDisposeProviderRef<List<AnalyzedFile>>;

/// See also [analyzedFilesForRoot].
final analyzedFilesForRootProvider = AnalyzedFilesForRootFamily();

class AnalyzedFilesForRootFamily extends Family<List<AnalyzedFile>> {
  AnalyzedFilesForRootFamily();

  AnalyzedFilesForRootProvider call(
    Context context,
  ) {
    return AnalyzedFilesForRootProvider(
      context,
    );
  }

  @override
  AutoDisposeProvider<List<AnalyzedFile>> getProviderOverride(
    covariant AnalyzedFilesForRootProvider provider,
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
  String? get name => r'analyzedFilesForRootProvider';
}

String $analyzedFileForPathHash() =>
    r'db39ff7004acd423b715319f8607576430277e66';

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
