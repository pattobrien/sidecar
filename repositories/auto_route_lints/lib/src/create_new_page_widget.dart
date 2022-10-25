import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';
import 'package:auto_route_utilities/auto_route_utilities.dart';

import 'constants.dart';

class CreateNewPageWidget extends AssistRule {
  @override
  String get code => 'create_new_page_widget';

  @override
  String get packageName => kPackageId;

  @override
  CreateNewPageWidgetConfiguration get configuration =>
      super.configuration as CreateNewPageWidgetConfiguration;

  @override
  CreateNewPageWidgetConfiguration Function(Map json) get jsonDecoder =>
      CreateNewPageWidgetConfiguration.fromJson;

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) async {
    // prepare change builder
    result as DartAnalysisResult;
    final unit =
        await session.getResolvedUnit(result.path) as ResolvedUnitResult;
    final changeBuilder = AutoRouteChangeBuilder(session: session);

    final node = result.sourceSpan
        .toAstNode(unit)
        ?.thisOrAncestorOfType<ClassDeclaration>();

    final pageClass = node?.name2.value().toString();

    if (node == null || pageClass == null) return [];

    final workspacePath = unit.session.analysisContext.contextRoot.root
        .canonicalizePath(configuration.routePath);

    await changeBuilder.addAutoRouteFileEdit(workspacePath, (builder) {
      builder.importLibrary(unit.uri);
      builder.addRouteInsertion(null, (builder) {
        builder.writeAdaptiveRoute(pageClass);
      });
    });

    return [
      EditResult(
        analysisResult: result,
        message: 'Add new AdaptiveRoute',
        sourceChanges: changeBuilder.sourceChange.edits,
      )
    ];
  }
}

class CreateNewPageWidgetConfiguration {
  const CreateNewPageWidgetConfiguration({required this.routePath});

  final String routePath;

  factory CreateNewPageWidgetConfiguration.fromJson(Map json) {
    return CreateNewPageWidgetConfiguration(routePath: json['route_path']);
  }
}
