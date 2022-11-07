// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules.dart';

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

String $lintRulesForFileHash() => r'5d42997df966b5cbed40511361676aab4c32ba7f';

/// See also [lintRulesForFile].
class LintRulesForFileProvider extends AutoDisposeProvider<List<LintRule>> {
  LintRulesForFileProvider(
    this.file,
  ) : super(
          (ref) => lintRulesForFile(
            ref,
            file,
          ),
          from: lintRulesForFileProvider,
          name: r'lintRulesForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $lintRulesForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is LintRulesForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef LintRulesForFileRef = AutoDisposeProviderRef<List<LintRule>>;

/// See also [lintRulesForFile].
final lintRulesForFileProvider = LintRulesForFileFamily();

class LintRulesForFileFamily extends Family<List<LintRule>> {
  LintRulesForFileFamily();

  LintRulesForFileProvider call(
    AnalyzedFile file,
  ) {
    return LintRulesForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeProvider<List<LintRule>> getProviderOverride(
    covariant LintRulesForFileProvider provider,
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
  String? get name => r'lintRulesForFileProvider';
}

String $lintRulesForRootHash() => r'65532a1f5206f3ee1297d8c544f8b67edcc04aa8';

/// See also [lintRulesForRoot].
class LintRulesForRootProvider extends AutoDisposeProvider<List<LintRule>> {
  LintRulesForRootProvider(
    this.root,
  ) : super(
          (ref) => lintRulesForRoot(
            ref,
            root,
          ),
          from: lintRulesForRootProvider,
          name: r'lintRulesForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $lintRulesForRootHash,
        );

  final Context root;

  @override
  bool operator ==(Object other) {
    return other is LintRulesForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef LintRulesForRootRef = AutoDisposeProviderRef<List<LintRule>>;

/// See also [lintRulesForRoot].
final lintRulesForRootProvider = LintRulesForRootFamily();

class LintRulesForRootFamily extends Family<List<LintRule>> {
  LintRulesForRootFamily();

  LintRulesForRootProvider call(
    Context root,
  ) {
    return LintRulesForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<List<LintRule>> getProviderOverride(
    covariant LintRulesForRootProvider provider,
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
  String? get name => r'lintRulesForRootProvider';
}

String $assistRulesForRootHash() => r'b66add49583a6f147428206b56810d5e7250dfa9';

/// See also [assistRulesForRoot].
class AssistRulesForRootProvider extends AutoDisposeProvider<List<AssistRule>> {
  AssistRulesForRootProvider(
    this.root,
  ) : super(
          (ref) => assistRulesForRoot(
            ref,
            root,
          ),
          from: assistRulesForRootProvider,
          name: r'assistRulesForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $assistRulesForRootHash,
        );

  final Context root;

  @override
  bool operator ==(Object other) {
    return other is AssistRulesForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AssistRulesForRootRef = AutoDisposeProviderRef<List<AssistRule>>;

/// See also [assistRulesForRoot].
final assistRulesForRootProvider = AssistRulesForRootFamily();

class AssistRulesForRootFamily extends Family<List<AssistRule>> {
  AssistRulesForRootFamily();

  AssistRulesForRootProvider call(
    Context root,
  ) {
    return AssistRulesForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<List<AssistRule>> getProviderOverride(
    covariant AssistRulesForRootProvider provider,
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
  String? get name => r'assistRulesForRootProvider';
}

String $assistRulesForFileHash() => r'a3eed53d780fa2eceeab93ac56cbf6fbdc5e6f1a';

/// See also [assistRulesForFile].
class AssistRulesForFileProvider extends AutoDisposeProvider<List<AssistRule>> {
  AssistRulesForFileProvider(
    this.file,
  ) : super(
          (ref) => assistRulesForFile(
            ref,
            file,
          ),
          from: assistRulesForFileProvider,
          name: r'assistRulesForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $assistRulesForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is AssistRulesForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AssistRulesForFileRef = AutoDisposeProviderRef<List<AssistRule>>;

/// See also [assistRulesForFile].
final assistRulesForFileProvider = AssistRulesForFileFamily();

class AssistRulesForFileFamily extends Family<List<AssistRule>> {
  AssistRulesForFileFamily();

  AssistRulesForFileProvider call(
    AnalyzedFile file,
  ) {
    return AssistRulesForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeProvider<List<AssistRule>> getProviderOverride(
    covariant AssistRulesForFileProvider provider,
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
  String? get name => r'assistRulesForFileProvider';
}

String $activatedRulesForRootHash() =>
    r'f130a2e1d8b551a1b9037a2deb2312f3d9906704';

/// See also [activatedRulesForRoot].
class ActivatedRulesForRootProvider
    extends AutoDisposeProvider<List<BaseRule>> {
  ActivatedRulesForRootProvider(
    this.root,
  ) : super(
          (ref) => activatedRulesForRoot(
            ref,
            root,
          ),
          from: activatedRulesForRootProvider,
          name: r'activatedRulesForRootProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $activatedRulesForRootHash,
        );

  final Context root;

  @override
  bool operator ==(Object other) {
    return other is ActivatedRulesForRootProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ActivatedRulesForRootRef = AutoDisposeProviderRef<List<BaseRule>>;

/// See also [activatedRulesForRoot].
final activatedRulesForRootProvider = ActivatedRulesForRootFamily();

class ActivatedRulesForRootFamily extends Family<List<BaseRule>> {
  ActivatedRulesForRootFamily();

  ActivatedRulesForRootProvider call(
    Context root,
  ) {
    return ActivatedRulesForRootProvider(
      root,
    );
  }

  @override
  AutoDisposeProvider<List<BaseRule>> getProviderOverride(
    covariant ActivatedRulesForRootProvider provider,
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
  String? get name => r'activatedRulesForRootProvider';
}

String $filteredRulesForFileHash() =>
    r'a083630f6958324a70dd2dc7d4ae77ff841cf7b3';

/// See also [filteredRulesForFile].
class FilteredRulesForFileProvider extends AutoDisposeProvider<List<BaseRule>> {
  FilteredRulesForFileProvider(
    this.file,
  ) : super(
          (ref) => filteredRulesForFile(
            ref,
            file,
          ),
          from: filteredRulesForFileProvider,
          name: r'filteredRulesForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $filteredRulesForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is FilteredRulesForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FilteredRulesForFileRef = AutoDisposeProviderRef<List<BaseRule>>;

/// See also [filteredRulesForFile].
final filteredRulesForFileProvider = FilteredRulesForFileFamily();

class FilteredRulesForFileFamily extends Family<List<BaseRule>> {
  FilteredRulesForFileFamily();

  FilteredRulesForFileProvider call(
    AnalyzedFile file,
  ) {
    return FilteredRulesForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeProvider<List<BaseRule>> getProviderOverride(
    covariant FilteredRulesForFileProvider provider,
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
  String? get name => r'filteredRulesForFileProvider';
}
