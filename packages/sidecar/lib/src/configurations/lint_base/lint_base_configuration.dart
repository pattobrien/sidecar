abstract class LintBaseConfiguration {
  const LintBaseConfiguration({
    required this.pluginImports,
    required this.imports,
  });
  final List<String> pluginImports;
  final List<String> imports;
}
