import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';

final middlemanResourceProvider =
    Provider<ResourceProvider>((ref) => PhysicalResourceProvider.INSTANCE);
