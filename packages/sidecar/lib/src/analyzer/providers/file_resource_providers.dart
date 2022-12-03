import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:riverpod/riverpod.dart';

final analyzerResourceProvider = Provider<OverlayResourceProvider>(
  (ref) => OverlayResourceProvider(PhysicalResourceProvider.INSTANCE),
  name: 'analyzerResourceProvider',
  dependencies: const [],
);

final fileSystemProvider =
    Provider<FileSystem>((ref) => const LocalFileSystem());
