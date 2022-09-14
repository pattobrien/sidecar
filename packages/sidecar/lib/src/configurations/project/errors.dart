/// Thrown when sidecar isnt declared under analyzer.plugins in ```analysis_options.yaml``` file.
class MissingAnalyzerPluginException implements Exception {}

/// Thrown when sidecar declaration can't be found.
///
/// Sidecar configuration can be declared as a top-level function or in a separate ```sidecar.yaml``` file at root.
/// A well-formed configuration file would take a similar form as:
///
/// ```yaml
///
/// sidecar:
///   includes:
///     - "bin/**"
///     - "lib/**"
///
///   rules:
///     flutter_lints:
///       use_full_hex_values_for_flutter_colors:
///
///   edits:
///
/// ```
class MissingSidecarConfiguration implements Exception {
  const MissingSidecarConfiguration();

  @override
  String toString() {
    const message = 'No sidecar configuration found.';
    return 'MissingSidecarConfiguration: $message';
  }
}

/// Thrown when sidecar declaration is not properly formatted.
///
/// Sidecar configuration can be declared as a top-level function or in a separate ```sidecar.yaml``` file at root.
/// A well-formed configuration file would take a similar form as:
///
/// ```yaml
///
/// sidecar:
///   includes:
///     - "bin/**"
///     - "lib/**"
///
///   rules:
///     flutter_lints:
///       use_full_hex_values_for_flutter_colors:
///
///   edits:
///
/// ```
class InvalidSidecarConfiguration implements Exception {}
