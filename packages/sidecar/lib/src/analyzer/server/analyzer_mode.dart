enum SidecarAnalyzerMode { debug, cli, plugin }

extension SidecarAnalyzerModeX on SidecarAnalyzerMode {
  bool get isDebug => this == SidecarAnalyzerMode.debug;
  bool get isCli => this == SidecarAnalyzerMode.cli;
  bool get isPlugin => this == SidecarAnalyzerMode.plugin;
}
