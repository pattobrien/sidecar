import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class ConfigParseUtilities {
  static Future<List<LintConfiguration>> parseLintConfig(
    Uri projectRootUri,
  ) async {
    final configFile =
        io.File(p.join(projectRootUri.path, analysisOptionsFileName));
    if (configFile.existsSync()) {
      final contents = await configFile.readAsString();
      try {
        final config = checkedYamlDecode(
          contents,
          (m) => ProjectConfiguration.fromJson(m!['sidecar']),
          sourceUrl: projectRootUri,
        );

        final rulesConfig = config.lints?.values ?? [];
        for (final rule in rulesConfig) {
          print('registering lint ${rule.id}');
        }
        return rulesConfig.toList();
      } catch (e) {
        print('no plugin configuration found for sidecar.');
        rethrow;
      }
    } else {
      return [];
    }
  }

  static Future<List<EditConfiguration>> parseEditConfig(
    Uri projectRootUri,
  ) async {
    final configFile =
        io.File(p.join(projectRootUri.path, analysisOptionsFileName));
    if (configFile.existsSync()) {
      final contents = await configFile.readAsString();
      try {
        final config = checkedYamlDecode(
          contents,
          (m) => ProjectConfiguration.fromJson(m!['sidecar']),
          sourceUrl: projectRootUri,
        );

        final editConfig = config.edits?.values ?? [];
        for (final edit in editConfig) {
          print('registering code edit ${edit.id}');
        }
        return editConfig.toList();
      } catch (e) {
        print('no plugin configuration found for sidecar.');
        rethrow;
      }
    } else {
      return [];
    }
  }
}

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$id.dart';
  String get className => ReCase(id).pascalCase;

  // Uri get cacheUri =>
  //     Uri(scheme: 'file', path: p.join(userCachePath, filePath));
}

extension EditConfigurationX on EditConfiguration {
  String get filePath => '$id.dart';
  String get className => ReCase(id).pascalCase;
}
