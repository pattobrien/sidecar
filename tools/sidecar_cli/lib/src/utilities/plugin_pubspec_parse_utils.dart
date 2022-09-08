import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/src/configurations/plugin/lint_declaration.dart';
import 'package:sidecar_cli/src/configurations/plugin/plugin_configuration.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class PluginPubspecParseUtils {
  static Future<List<LintDeclaration>> getLintDeclarations(
    Uri projectRootUri,
  ) async {
    final pubspecFile = io.File(p.join(projectRootUri.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final contents = await pubspecFile.readAsString();
      try {
        final config = PluginConfiguration.fromYaml(contents);

        final lintDeclarations = config.lints?.values ?? [];
        for (final declaration in lintDeclarations) {
          print('registering lint ${declaration.id}');
        }
        return lintDeclarations.toList();
      } catch (e) {
        print('no plugin configuration found for sidecar.');
        rethrow;
      }
    } else {
      return [];
    }
  }

  // static Future<List<EditConfiguration>> parseEditConfig(
  //   Uri projectRootUri,
  // ) async {
  //   final configFile =
  //       io.File(p.join(projectRootUri.path, analysisOptionsFileName));
  //   if (configFile.existsSync()) {
  //     final contents = await configFile.readAsString();
  //     try {
  //       final config = checkedYamlDecode(
  //         contents,
  //         (m) => ProjectConfiguration.fromJson(m!['sidecar']),
  //         sourceUrl: projectRootUri,
  //       );

  //       final editConfig = config.edits?.values ?? [];
  //       for (final edit in editConfig) {
  //         print('registering code edit ${edit.id}');
  //       }
  //       return editConfig.toList();
  //     } catch (e) {
  //       print('no plugin configuration found for sidecar.');
  //       rethrow;
  //     }
  //   } else {
  //     return [];
  //   }
  // }
}

extension LintDeclarationX on LintDeclaration {
  // Uri get import =>
  //     this.import ?? Uri(scheme: 'package', path: '$package/$package.dart');
  // String get className => this.className ?? ReCase(id).pascalCase;

  // Uri get cacheUri =>
  //     Uri(scheme: 'file', path: p.join(userCachePath, filePath));
}

// extension EditConfigurationX on EditConfiguration {
//   String get filePath => '$id.dart';
//   String get className => ReCase(id).pascalCase;
// }
