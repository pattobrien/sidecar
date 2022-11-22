class SidecarAnalyzerException implements Exception {}

class SidecarPluginNotActivated implements SidecarAnalyzerException {
  SidecarPluginNotActivated(this.root);
  final Uri root;
}

class PackageConfigNotAvailable implements SidecarAnalyzerException {
  PackageConfigNotAvailable(this.root);
  final Uri root;
}
