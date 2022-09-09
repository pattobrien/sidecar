// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:sidecar/sidecar.dart';
import 'package:auto_route_utilities/auto_route_utilities.dart';
import 'package:path/path.dart' as p;

class CreateNewPageWidget extends CodeEdit {
  CreateNewPageWidget(super.ref);

  @override
  String get code => 'create_new_page_widget';

  @override
  String get message => 'TODO: insert a message here';

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    // prepare change builder
    final unit = requestedCodeEdit.sourceUnit;
    final changeBuilder = AutoRouteChangeBuilder(session: unit.session);

    final configuration = unit.session.analysisContext.sidecarOptions
        .editPackages?['auto_route_lints']?.edits[code]?.configuration;

    final path = configuration?['route_path'];

    if (path != null) {
      final node =
          requestedCodeEdit.sourceNode.thisOrAncestorOfType<ClassDeclaration>();

      final pageClass = node?.name2.value().toString();

      if (node != null && pageClass != null) {
        final workspacePath = unit.session.analysisContext.contextRoot.root
            .canonicalizePath(path);
        // compute changes
        await changeBuilder.addAutoRouteFileEdit(workspacePath, (builder) {
          builder.importLibrary(unit.uri);
          builder.addRouteInsertion(null, (builder) {
            builder.writeAdaptiveRoute(pageClass);
          });
        });
      }
    }
    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = 'Add new AdaptiveRoute',
    );
  }
}
