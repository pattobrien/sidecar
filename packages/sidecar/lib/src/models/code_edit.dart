import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import 'id.dart';
import 'requested_code_edit.dart';
import 'sidecar_base.dart';

abstract class CodeEdit extends SidecarBase {
  @override
  IdType get type => IdType.codeEdit;
  //TODO: can we use SourceChange instead of PrioritizedSourceChange?
  Future<plugin.PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  );
}
