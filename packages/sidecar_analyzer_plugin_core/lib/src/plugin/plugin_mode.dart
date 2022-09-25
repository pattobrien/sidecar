import 'package:riverpod/riverpod.dart';

enum SidecarAnalyzerPluginMode { debug, cli, plugin }

extension SidecarAnalyzerPluginModeX on SidecarAnalyzerPluginMode {
  bool get isDebug => this == SidecarAnalyzerPluginMode.debug;
  bool get isCli => this == SidecarAnalyzerPluginMode.cli;
  bool get isPlugin => this == SidecarAnalyzerPluginMode.plugin;
}

final pluginMode =
    Provider<SidecarAnalyzerPluginMode>((ref) => throw UnimplementedError());
