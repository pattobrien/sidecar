import 'package:checked_yaml/checked_yaml.dart';
import 'package:recase/recase.dart';

import 'edit_declaration.dart';
import 'lint_declaration.dart';

class PackageConfiguration {
  const PackageConfiguration({
    this.lints,
    this.edits,
    required this.packageName,
  });

  factory PackageConfiguration.parse(
    String contents, {
    required String packageName,
    required Uri sourceUrl,
  }) {
    return checkedYamlDecode(
      contents,
      (m) {
        final contentMap = m!['sidecar'] as Map;
        return PackageConfiguration(
          lints: lintConfigFromJson(contentMap['lints'] as Map?, packageName),
          edits: editConfigFromJson(contentMap['edits'] as Map?, packageName),
          packageName: packageName,
        );
      },
      sourceUrl: sourceUrl,
    );
  }

  final Map<LintName, LintDeclaration>? lints;
  final Map<EditName, EditDeclaration>? edits;
  final String packageName;
}

typedef LintName = dynamic;
typedef EditName = dynamic;

Map<LintName, LintDeclaration>? lintConfigFromJson(
  Map? json,
  String packageName,
) {
  final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
    if (key is String) {
      return MapEntry<String, dynamic>(key, value);
    } else {
      throw UnimplementedError('lintConfigFromJson: expected String');
    }
  });
  return map?.map<LintName, LintDeclaration>((key, dynamic value) {
    final defaultImportUri =
        Uri(scheme: 'package', path: '$packageName/$packageName.dart');
    final defaultClassName = ReCase(key).pascalCase;
    if (value == null) {
      return MapEntry<LintName, LintDeclaration>(
        key,
        LintDeclaration(
          id: key,
          package: packageName,
          import: defaultImportUri,
          className: defaultClassName,
        ),
      );
    }
    if (value is Map<dynamic, dynamic>) {
      return MapEntry<LintName, LintDeclaration>(
        key,
        LintDeclaration(
          id: key,
          import: value.containsKey('import')
              ? Uri(scheme: 'package', path: value['import'] as String)
              : defaultImportUri,
          className: value.containsKey('class')
              ? value['class'] as String
              : defaultClassName,
          package: packageName,
        ),
      );
    }
    throw UnimplementedError(
        'lint declaration is not correct: type is ${value.toString()}');
  });
}

Map<EditName, EditDeclaration>? editConfigFromJson(
  Map? json,
  String packageName,
) {
  final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
    if (key is String) {
      return MapEntry<String, dynamic>(key, value);
    } else {
      throw UnimplementedError('editConfigFromJson: expected String');
    }
  });
  return map?.map<EditName, EditDeclaration>((key, dynamic value) {
    final defaultImportUri =
        Uri(scheme: 'package', path: '$packageName/$packageName.dart');
    final defaultClassName = ReCase(key).pascalCase;
    if (value == null) {
      return MapEntry<EditName, EditDeclaration>(
        key,
        EditDeclaration(
          id: key,
          package: packageName,
          import: defaultImportUri,
          className: defaultClassName,
        ),
      );
    }
    if (value is Map<dynamic, dynamic>) {
      return MapEntry<EditName, EditDeclaration>(
        key,
        EditDeclaration(
          id: key,
          import: value.containsKey('import')
              ? Uri(scheme: 'package', path: value['import'] as String)
              : defaultImportUri,
          className: value.containsKey('class')
              ? value['class'] as String
              : defaultClassName,
          package: packageName,
        ),
      );
    }
    throw UnimplementedError(
        'edit declaration is not correct: type is ${value.toString()}');
  });
}
