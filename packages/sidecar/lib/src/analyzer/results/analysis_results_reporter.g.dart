// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_results_reporter.dart';

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

String $createAnalysisReportHash() =>
    r'5dd098723e3c1e69a42a50e627f56e1f6bf481a3';

/// See also [createAnalysisReport].
class CreateAnalysisReportProvider
    extends AutoDisposeFutureProvider<List<LintResult>> {
  CreateAnalysisReportProvider(
    this.file,
  ) : super(
          (ref) => createAnalysisReport(
            ref,
            file,
          ),
          from: createAnalysisReportProvider,
          name: r'createAnalysisReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $createAnalysisReportHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is CreateAnalysisReportProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef CreateAnalysisReportRef
    = AutoDisposeFutureProviderRef<List<LintResult>>;

/// See also [createAnalysisReport].
final createAnalysisReportProvider = CreateAnalysisReportFamily();

class CreateAnalysisReportFamily extends Family<AsyncValue<List<LintResult>>> {
  CreateAnalysisReportFamily();

  CreateAnalysisReportProvider call(
    AnalyzedFile file,
  ) {
    return CreateAnalysisReportProvider(
      file,
    );
  }

  @override
  AutoDisposeFutureProvider<List<LintResult>> getProviderOverride(
    covariant CreateAnalysisReportProvider provider,
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
  String? get name => r'createAnalysisReportProvider';
}
