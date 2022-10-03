class SidecarInput {
  const SidecarInput({
    required this.packageName,
    this.lintName,
    required this.configuration,
  });

  final String packageName;
  final String? lintName;
  final Map<dynamic, dynamic> configuration;
}
