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

String $requestQuickFixesHash() => r'c323586a2890249cfe7f4bd4bcfc4ecd1a423db4';

/// See also [requestQuickFixes].
class RequestQuickFixesProvider
    extends AutoDisposeFutureProvider<List<LintResultWithEdits>> {
  RequestQuickFixesProvider(
    this.request,
  ) : super(
          (ref) => requestQuickFixes(
            ref,
            request,
          ),
          from: requestQuickFixesProvider,
          name: r'requestQuickFixesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $requestQuickFixesHash,
        );

  final QuickFixRequest request;

  @override
  bool operator ==(Object other) {
    return other is RequestQuickFixesProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef RequestQuickFixesRef
    = AutoDisposeFutureProviderRef<List<LintResultWithEdits>>;

/// See also [requestQuickFixes].
final requestQuickFixesProvider = RequestQuickFixesFamily();

class RequestQuickFixesFamily
    extends Family<AsyncValue<List<LintResultWithEdits>>> {
  RequestQuickFixesFamily();

  RequestQuickFixesProvider call(
    QuickFixRequest request,
  ) {
    return RequestQuickFixesProvider(
      request,
    );
  }

  @override
  AutoDisposeFutureProvider<List<LintResultWithEdits>> getProviderOverride(
    covariant RequestQuickFixesProvider provider,
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
  String? get name => r'requestQuickFixesProvider';
}
