class SidecarInput {
  const SidecarInput({
    this.packageName,
    this.lintName,
    this.configuration = const <dynamic, dynamic>{},
  });

  final String? packageName;
  final String? lintName;
  final Map<dynamic, dynamic> configuration;
}
