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

String $runnersHash() => r'97fe633824390a1cf52ef18164a86ffa089e75db';

/// See also [runners].
final runnersProvider = Provider<List<SidecarRunner>>(
  runners,
  name: r'runnersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $runnersHash,
);
typedef RunnersRef = ProviderRef<List<SidecarRunner>>;
String $runnerForContextHash() => r'660aed90532fe84608815498b153d42d5379031e';

/// See also [runnerForContext].
class RunnerForContextProvider extends AutoDisposeProvider<SidecarRunner> {
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

typedef RunnerForContextRef = AutoDisposeProviderRef<SidecarRunner>;

/// See also [runnerForContext].
final runnerForContextProvider = RunnerForContextFamily();

class RunnerForContextFamily extends Family<SidecarRunner> {
  RunnerForContextFamily();

  RunnerForContextProvider call(
    ActiveContext context,
  ) {
    return RunnerForContextProvider(
      context,
    );
  }

  @override
  AutoDisposeProvider<SidecarRunner> getProviderOverride(
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
