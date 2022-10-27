import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:flutter_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';

const _desc =
    r'Prefer an 8-digit hexadecimal integer(0xFFFFFFFF) to instantiate Color.';

class UseFullHexValuesForFlutterColors extends LintRule with LintVisitor {
  @override
  String get code => 'use_full_hex_values_for_flutter_colors';

  @override
  String get packageName => kPackageName;

  @override
  String get url => '$kUrlBase/use_full_hex_values_for_flutter_colors.html';

  @override
  SidecarAstVisitor get visitorCreator => _Visitor();
}

class _Visitor extends SidecarAstVisitor {
  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // final element = node.constructorName.staticElement;
    // if (element != null &&
    //     element.isSameAs(uri: 'dart.ui', className: 'Color')) {
    //   final arguments = node.argumentList.arguments;
    //   if (arguments.isNotEmpty) {
    //     final argument = arguments.first;
    //     if (argument is IntegerLiteral) {
    //       final value = argument.literal.lexeme.toLowerCase();
    //       if (!value.startsWith('0x') || value.length != 10) {
    //         reportAstNode(argument, message: _desc);
    //       }
    //     }
    //   }
    // }
    super.visitInstanceCreationExpression(node);
  }
}
