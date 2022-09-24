import 'package:glob/glob.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

import 'errors.dart';

class EditConfiguration {
  const EditConfiguration({
    required this.packageName,
    required this.id,
    this.configuration,
    this.enabled,
    this.includes,
    this.sourceErrors = const <YamlSourceError>[],
  });

  final String packageName;
  final String id;

  final bool? enabled;
  final YamlMap? configuration;
  final List<Glob>? includes;

  final List<YamlSourceError> sourceErrors;
}

extension EditConfigurationX on EditConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;
}
