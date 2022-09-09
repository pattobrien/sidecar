// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:sidecar/sidecar.dart';
import 'package:auto_route_utilities/auto_route_utilities.dart';
import 'package:analyzer_plugin/src/utilities/change_builder/change_builder_core.dart';

class CreateNewPageWidget extends CodeEdit {
  CreateNewPageWidget(super.ref);

  @override
  String get message => 'TODO: insert a message here';

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    // inputs
    final file = File(
        '/Users/pattobrien/Development/sidecar/examples/my_analyzed_codebase/lib/routes/routes.dart');
    final exists = await file.exists();
    final pageClass = 'MyNewPage';

    // prepare change builder
    final session = requestedCodeEdit.sourceUnit.session;
    final changeBuilder = AutoRouteChangeBuilder(session: session);
    // final changeBuilder = ChangeBuilder(session: session);
    // compute changes
    // await changeBuilder.addDartFileEdit(file.path, (builder) {
    //   builder.addInsertion(0, (builder) {
    //     builder.writeln('// do something else');
    //   });
    // });
    await changeBuilder.addAutoRouteFileEdit(file.path, (builder) {
      builder.addInsertion(0, (builder) {
        builder.writeln('// auto route: do something else');
      });
      builder.addRouteInsertion(null, (builder) {
        builder.writeln('// auto route: do something else else');
        builder.writeNewAdaptiveRoute(pageClass);
      });
    });

    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = 'Add new route',
    );
  }
}
