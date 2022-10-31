import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';
import 'package:auto_route_utilities/auto_route_utilities.dart';

import 'constants.dart';

class CreateNewPageWidget extends AssistRule with AssistVisitor {
  @override
  String get code => 'create_new_page_widget';

  @override
  String get packageName => kPackageId;

  // @override
  // CreateNewPageWidgetConfiguration get configuration =>
  //     super.configuration as CreateNewPageWidgetConfiguration;

  // @override
  // CreateNewPageWidgetConfiguration Function(Map json) get jsonDecoder =>
  //     CreateNewPageWidgetConfiguration.fromJson;

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSource source,
  ) async {
    final unit = await getResolvedUnitResult(source.path);
    final changeBuilder = AutoRouteChangeBuilder(session: session);

    // final node =
    //     source.source.toAstNode(unit)?.thisOrAncestorOfType<ClassDeclaration>();

    // final pageClass = node?.name2.value().toString();

    // if (node == null || pageClass == null) return [];

    // final workspacePath = unit.session.analysisContext.contextRoot.root
    //     .canonicalizePath(configuration.routePath);

    // await changeBuilder.addAutoRouteFileEdit(workspacePath, (builder) {
    //   builder.importLibrary(unit.uri);
    //   builder.addRouteInsertion(null, (builder) {
    //     builder.writeAdaptiveRoute(pageClass);
    //   });
    // });

    await changeBuilder.addDartFileEdit(unit.path, (builder) {
      builder.addInsertion(
        unit.unit.length,
        (editBuilder) => editBuilder.write('test'),
      );
    });

    return [
      EditResult(
        message: 'Add new AdaptiveRoute',
        sourceChanges: changeBuilder.sourceChange.edits,
      )
    ];
  }

  @override
  SidecarAssistVisitor Function() get visitorCreator => _Visitor.new;
}

class _Visitor extends SidecarAssistVisitor {
  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final type = node.declaredElement?.thisType;
    if (widgetType.isAssignableFromType(type)) {
      reportAstNode(node);
    }
  }
}

class CreateNewPageWidgetConfiguration {
  const CreateNewPageWidgetConfiguration({required this.routePath});

  final String routePath;

  factory CreateNewPageWidgetConfiguration.fromJson(Map json) {
    return CreateNewPageWidgetConfiguration(routePath: json['route_path']);
  }
}
