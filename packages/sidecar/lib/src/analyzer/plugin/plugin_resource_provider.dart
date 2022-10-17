import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';

final pluginResourceProvider = Provider<OverlayResourceProvider>(
  (ref) => OverlayResourceProvider(PhysicalResourceProvider.INSTANCE),
  name: 'pluginResourceProvider',
  dependencies: const [],
);
