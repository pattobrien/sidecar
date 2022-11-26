import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../communication/responses.dart';
import 'result_exts.dart';

extension QuickFixX on QuickFixResponse {
  plugin.EditGetFixesResult toPluginResponse() {
    final edits = results.map((e) => e.toAnalysisErrorFixes()).toList();
    return plugin.EditGetFixesResult(edits);
  }
}

// extension QuickFixesX on List<QuickFixResponse> {
//   plugin.EditGetFixesResult toPluginResponse() {
//     final edits = this.map((e) => e.to)
//   }
// }