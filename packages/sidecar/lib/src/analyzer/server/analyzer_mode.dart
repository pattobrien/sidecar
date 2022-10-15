import 'package:riverpod/riverpod.dart';

enum SidecarAnalyzerMode { debug, cli, plugin }

extension SidecarAnalyzerModeX on SidecarAnalyzerMode {
  bool get isDebug => this == SidecarAnalyzerMode.debug;
  bool get isCli => this == SidecarAnalyzerMode.cli;
  bool get isPlugin => this == SidecarAnalyzerMode.plugin;
}

final sidecarAnalyzerMode = Provider<SidecarAnalyzerMode>(
  (ref) => throw UnimplementedError(),
  name: 'sidecarAnalyzerMode',
  dependencies: const [],
);
