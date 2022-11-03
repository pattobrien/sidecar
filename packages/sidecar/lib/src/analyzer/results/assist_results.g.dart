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
    extends AutoDisposeFutureProvider<List<dynamic>> {
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

typedef AssistResultsForFileRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [assistResultsForFile].
final assistResultsForFileProvider = AssistResultsForFileFamily();

class AssistResultsForFileFamily extends Family<AsyncValue<List<dynamic>>> {
  AssistResultsForFileFamily();

  AssistResultsForFileProvider call(
    AnalyzedFile file,
  ) {
    return AssistResultsForFileProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
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
    r'a354137b1c9ed905a21591742c610d584e96485f';

/// See also [assistResultsWithEdits].
class AssistResultsWithEditsProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
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

typedef AssistResultsWithEditsRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [assistResultsWithEdits].
final assistResultsWithEditsProvider = AssistResultsWithEditsFamily();

class AssistResultsWithEditsFamily extends Family<AsyncValue<List<dynamic>>> {
  AssistResultsWithEditsFamily();

  AssistResultsWithEditsProvider call(
    AnalyzedFile file,
  ) {
    return AssistResultsWithEditsProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
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
    r'e848d11e50f94ef57aba3585db13e9f6f6bd2dbf';

/// See also [requestAssistResults].
class RequestAssistResultsProvider
    extends AutoDisposeFutureProvider<List<dynamic>> {
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

  final dynamic request;

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

typedef RequestAssistResultsRef = AutoDisposeFutureProviderRef<List<dynamic>>;

/// See also [requestAssistResults].
final requestAssistResultsProvider = RequestAssistResultsFamily();

class RequestAssistResultsFamily extends Family<AsyncValue<List<dynamic>>> {
  RequestAssistResultsFamily();

  RequestAssistResultsProvider call(
    dynamic request,
  ) {
    return RequestAssistResultsProvider(
      request,
    );
  }

  @override
  AutoDisposeFutureProvider<List<dynamic>> getProviderOverride(
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
