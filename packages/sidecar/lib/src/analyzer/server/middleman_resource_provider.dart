import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';

final middlemanResourceProvider = Provider<OverlayResourceProvider>(
  (ref) => OverlayResourceProvider(PhysicalResourceProvider.INSTANCE),
  name: 'middlemanResourceProvider',
  dependencies: const [],
);
