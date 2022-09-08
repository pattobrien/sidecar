import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

import 'lint_declaration.dart';

part 'package_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
)
class PackageConfiguration {
  const PackageConfiguration({
    this.lints,
    required this.packageName,
    // this.edits,
  });

  final Map<LintName, LintDeclaration>? lints;

  // final Map<EditName, EditDeclaration>? edits;

  final String packageName;

  // @JsonKey(fromJson: editConfigFromJson)
  // final Map<EditName, EditConfiguration>? edits;

  factory PackageConfiguration.parse(
    String contents, {
    required String packageName,
  }) {
    return checkedYamlDecode(
      contents,
      (m) {
        final contentMap = m!['sidecar'] as Map;
        return PackageConfiguration(
          lints: lintConfigFromJson(contentMap['lints'] as Map?, packageName),
          packageName: packageName,
        );
      },
    );
  }
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
              ? Uri(scheme: 'package', path: value['import'])
              : defaultImportUri,
          className:
              value.containsKey('class') ? value['class'] : defaultClassName,
          package: packageName,
        ),
      );
    }
    throw UnimplementedError(
        'lint declaration is not correct: type is ${value.toString()}');
  });
}
