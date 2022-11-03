// ignore_for_file: implementation_imports, unnecessary_lambdas

import 'dart:async';
import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';

import '../../../protocol/responses/responses.dart';
import '../../../services/services.dart';
import 'sidecar_runner.dart';

final activeRunnerDirectory = Provider<Directory>(
  (ref) => Directory.current,
  name: 'activeRunnerDirectory',
);

final allContextsForRunnerProvider = Provider((ref) {
  final directory = ref.watch(activeRunnerDirectory);
  final service = ref.watch(activeProjectServiceProvider);
  return service.getAllContextsFromPath([directory.path]);
});

final activePrimaryContextsForRunnerProvider = Provider((ref) {
  final directory = ref.watch(activeRunnerDirectory);
  final service = ref.watch(activeProjectServiceProvider);
  return service.getActiveContextsFromPath([directory.path]);
});

final runnerResourceProvider = Provider(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);
