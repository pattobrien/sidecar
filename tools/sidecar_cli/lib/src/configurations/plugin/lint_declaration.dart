import 'package:json_annotation/json_annotation.dart';

part 'lint_declaration.g.dart';

@JsonSerializable()
class LintDeclaration {
  LintDeclaration({
    required this.id,
    this.package,
    this.className,
    this.import,
  });

  final String id;
  final String? package;
  final String? className;
  final Uri? import;

  factory LintDeclaration.fromJson(Map<String, dynamic> json) =>
      _$LintDeclarationFromJson(json);
}
