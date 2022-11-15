import 'package:file/memory.dart';
import 'package:riverpod/riverpod.dart';

import '../../analyzer/plugin/files_provider.dart';
import '../../analyzer/plugin/plugin.dart';
import '../../rules/rules.dart';
import 'mock_communication_channel.dart';

// ProviderContainer createTestEnvironment(
//   List<SidecarBaseConstructor> constructors,
// ) {
//   final fileSystem = MemoryFileSystem();
//   final mockChannel = MockCommunicationChannel();
//   return ProviderContainer(overrides: [
//     communicationChannelProvider.overrideWithValue(mockChannel),
//     ruleConstructorProvider.overrideWithValue(constructors),
//     // activePackageProvider.overrideWithProvider(packageProvider),
//     fileSystemProvider.overrideWithValue(fileSystem),
//   ]);
// }
