import 'package:json_annotation/json_annotation.dart';

part 'edit_declaration.g.dart';

@JsonSerializable()
class EditDeclaration {
  EditDeclaration({
    required this.id,
    required this.package,
    required this.className,
    required this.import,
  });

  final String id;
  final String package;
  final String className;
  final Uri import;

  factory EditDeclaration.fromJson(Map<String, dynamic> json) =>
      _$EditDeclarationFromJson(json);
}
