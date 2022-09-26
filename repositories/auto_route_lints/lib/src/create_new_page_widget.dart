import 'package:sidecar/builder.dart';
import 'package:auto_route_utilities/auto_route_utilities.dart';

class CreateNewPageWidget extends CodeEdit {
  @override
  String get code => 'create_new_page_widget';

  @override
  String get packageName => 'auto_route_lints';

  @override
  CreateNewPageWidgetConfiguration get configuration =>
      super.configuration as CreateNewPageWidgetConfiguration;

  @override
  CreateNewPageWidgetConfiguration Function(Map json) get jsonDecoder =>
      CreateNewPageWidgetConfiguration.fromJson;

  @override
  Future<PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    // prepare change builder
    final unit = requestedCodeEdit.unit;
    final changeBuilder = AutoRouteChangeBuilder(session: unit.session);

    final node =
        requestedCodeEdit.node.thisOrAncestorOfType<ClassDeclaration>();

    final pageClass = node?.name2.value().toString();

    if (node == null || pageClass == null) return null;

    final workspacePath = unit.session.analysisContext.contextRoot.root
        .canonicalizePath(configuration.routePath);

    await changeBuilder.addAutoRouteFileEdit(workspacePath, (builder) {
      builder.importLibrary(unit.uri);
      builder.addRouteInsertion(null, (builder) {
        builder.writeAdaptiveRoute(pageClass);
      });
    });

    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = 'Add new AdaptiveRoute',
    );
  }
}

class CreateNewPageWidgetConfiguration {
  const CreateNewPageWidgetConfiguration({required this.routePath});

  final String routePath;

  factory CreateNewPageWidgetConfiguration.fromJson(Map json) {
    return CreateNewPageWidgetConfiguration(routePath: json['route_path']);
  }
}
