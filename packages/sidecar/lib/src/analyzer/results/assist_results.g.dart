// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assist_results.dart';

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

String $assistResultsForFileHash() =>
    r'd477d3945bb980b1ff3cbf9c94fd3afc5482047a';

/// See also [assistResultsForFile].
class AssistResultsForFileProvider
    extends AutoDisposeFutureProvider<List<AssistResult>> {
  AssistResultsForFileProvider(
    this.file,
  ) : super(
          (ref) => assistResultsForFile(
            ref,
            file,
          ),
          from: assistResultsForFileProvider,
          name: r'assistResultsForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $assistResultsForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is AssistResultsForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AssistResultsForFileRef
    = AutoDisposeFutureProviderRef<List<AssistResult>>;

/// See also [assistResultsForFile].
final assistResultsForFileProvider = AssistResultsForFileFamily();

class AssistResultsForFileFamily
    extends Family<AsyncValue<List<AssistResult>>> {
  AssistResultsForFileFamily();

  AssistResultsForFileProvider call(
    AnalyzedFile file,
  ) {
    return AssistResultsForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<AssistResult>> getProviderOverride(
    covariant AssistResultsForFileProvider provider,
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
  String? get name => r'assistResultsForFileProvider';
}

String $assistResultsWithEditsHash() =>
    r'0d63b1d039edb15bb569b09550aa55acc582d46d';

/// See also [assistResultsWithEdits].
class AssistResultsWithEditsProvider
    extends AutoDisposeFutureProvider<List<AssistResult>> {
  AssistResultsWithEditsProvider(
    this.file,
  ) : super(
          (ref) => assistResultsWithEdits(
            ref,
            file,
          ),
          from: assistResultsWithEditsProvider,
          name: r'assistResultsWithEditsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $assistResultsWithEditsHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is AssistResultsWithEditsProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef AssistResultsWithEditsRef
    = AutoDisposeFutureProviderRef<List<AssistResult>>;

/// See also [assistResultsWithEdits].
final assistResultsWithEditsProvider = AssistResultsWithEditsFamily();

class AssistResultsWithEditsFamily
    extends Family<AsyncValue<List<AssistResult>>> {
  AssistResultsWithEditsFamily();

  AssistResultsWithEditsProvider call(
    AnalyzedFile file,
  ) {
    return AssistResultsWithEditsProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<AssistResult>> getProviderOverride(
    covariant AssistResultsWithEditsProvider provider,
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
  String? get name => r'assistResultsWithEditsProvider';
}

String $requestAssistResultsHash() =>
    r'5001a6b8951cd6a66a6dbc854417c1f333f0f1a8';

/// See also [requestAssistResults].
class RequestAssistResultsProvider
    extends AutoDisposeFutureProvider<List<AssistResult>> {
  RequestAssistResultsProvider(
    this.request,
  ) : super(
          (ref) => requestAssistResults(
            ref,
            request,
          ),
          from: requestAssistResultsProvider,
          name: r'requestAssistResultsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $requestAssistResultsHash,
        );

  final AssistRequest request;

  @override
  bool operator ==(Object other) {
    return other is RequestAssistResultsProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef RequestAssistResultsRef
    = AutoDisposeFutureProviderRef<List<AssistResult>>;

/// See also [requestAssistResults].
final requestAssistResultsProvider = RequestAssistResultsFamily();

class RequestAssistResultsFamily
    extends Family<AsyncValue<List<AssistResult>>> {
  RequestAssistResultsFamily();

  RequestAssistResultsProvider call(
    AssistRequest request,
  ) {
    return RequestAssistResultsProvider(
      request,
    );
  }

  @override
  AutoDisposeFutureProvider<List<AssistResult>> getProviderOverride(
    covariant RequestAssistResultsProvider provider,
  ) {
    return call(
      provider.request,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'requestAssistResultsProvider';
}
