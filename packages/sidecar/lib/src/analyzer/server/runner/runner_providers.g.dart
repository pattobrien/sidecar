// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runner_providers.dart';

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

String $getRunnersHash() => r'da9105c284e2d964d6901f029d3d6ecf2308062a';

/// See also [getRunners].
final getRunnersProvider = FutureProvider<List<SidecarRunner>>(
  getRunners,
  name: r'getRunnersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $getRunnersHash,
);
typedef GetRunnersRef = FutureProviderRef<List<SidecarRunner>>;
String $runnerForContextHash() => r'98ad46c4083d85f77c8c75cab8f934d82a1b5ef1';

/// See also [runnerForContext].
class RunnerForContextProvider
    extends AutoDisposeFutureProvider<SidecarRunner> {
  RunnerForContextProvider(
    this.context,
  ) : super(
          (ref) => runnerForContext(
            ref,
            context,
          ),
          from: runnerForContextProvider,
          name: r'runnerForContextProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $runnerForContextHash,
        );

  final ActiveContext context;

  @override
  bool operator ==(Object other) {
    return other is RunnerForContextProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef RunnerForContextRef = AutoDisposeFutureProviderRef<SidecarRunner>;

/// See also [runnerForContext].
final runnerForContextProvider = RunnerForContextFamily();

class RunnerForContextFamily extends Family<AsyncValue<SidecarRunner>> {
  RunnerForContextFamily();

  RunnerForContextProvider call(
    ActiveContext context,
  ) {
    return RunnerForContextProvider(
      context,
    );
  }

  @override
  AutoDisposeFutureProvider<SidecarRunner> getProviderOverride(
    covariant RunnerForContextProvider provider,
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
  String? get name => r'runnerForContextProvider';
}
