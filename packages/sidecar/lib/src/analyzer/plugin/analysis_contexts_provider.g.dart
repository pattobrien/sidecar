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
    r'd971f09ffef5ae5e9e0264d217022489c46a05eb';

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
    r'e3cb16a770bf985de573e8b872c20c096ed62119';

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
