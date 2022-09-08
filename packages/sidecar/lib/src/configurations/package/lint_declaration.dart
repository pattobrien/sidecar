import 'package:json_annotation/json_annotation.dart';

part 'lint_declaration.g.dart';

@JsonSerializable()
class LintDeclaration {
  LintDeclaration({
    required this.id,
    required this.package,
    required this.className,
    required this.import,
  });

  final String id;
  final String package;
  final String className;
  final Uri import;

  factory LintDeclaration.fromJson(Map<String, dynamic> json) =>
      _$LintDeclarationFromJson(json);
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
