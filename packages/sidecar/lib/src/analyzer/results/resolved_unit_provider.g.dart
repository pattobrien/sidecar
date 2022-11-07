// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolved_unit_provider.dart';

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

String $getResolvedUnitForFileHash() =>
    r'10ccb63eff2bcf19ffa1dd97a40dc3b1d03b6d74';

/// See also [getResolvedUnitForFile].
class GetResolvedUnitForFileProvider
    extends FutureProvider<ResolvedUnitResult?> {
  GetResolvedUnitForFileProvider(
    this.file,
  ) : super(
          (ref) => getResolvedUnitForFile(
            ref,
            file,
          ),
          from: getResolvedUnitForFileProvider,
          name: r'getResolvedUnitForFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getResolvedUnitForFileHash,
        );

  final AnalyzedFile file;

  @override
  bool operator ==(Object other) {
    return other is GetResolvedUnitForFileProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetResolvedUnitForFileRef = FutureProviderRef<ResolvedUnitResult?>;

/// See also [getResolvedUnitForFile].
final getResolvedUnitForFileProvider = GetResolvedUnitForFileFamily();

class GetResolvedUnitForFileFamily
    extends Family<AsyncValue<ResolvedUnitResult?>> {
  GetResolvedUnitForFileFamily();

  GetResolvedUnitForFileProvider call(
    AnalyzedFile file,
  ) {
    return GetResolvedUnitForFileProvider(
      file,
    );
  }

  @override
  FutureProvider<ResolvedUnitResult?> getProviderOverride(
    covariant GetResolvedUnitForFileProvider provider,
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
  String? get name => r'getResolvedUnitForFileProvider';
}
