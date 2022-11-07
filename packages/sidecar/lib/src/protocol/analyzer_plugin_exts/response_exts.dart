import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;

import '../protocol.dart';

extension QuickFixX on QuickFixResponse {
  plugin.EditGetFixesResult toPluginResponse() {
    final edits = results.map((e) => e.toAnalysisErrorFixes()).toList();
    return plugin.EditGetFixesResult(edits);
  }
}
