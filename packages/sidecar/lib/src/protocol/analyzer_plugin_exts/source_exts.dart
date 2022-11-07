import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:source_span/source_span.dart';

import '../protocol.dart';

extension SourceFileEditX on SourceFileEdit {
  plugin.SourceFileEdit toPluginFileEdit() =>
      plugin.SourceFileEdit(file.path, fileStamp.millisecondsSinceEpoch,
          edits: edits.toPluginEdits());
}

extension SourceFileEditsX on List<SourceFileEdit> {
  List<plugin.SourceFileEdit> toPluginFileEdits() =>
      map((e) => e.toPluginFileEdit()).toList();
}

extension PluginSourceFileEditX on plugin.SourceFileEdit {
  SourceFileEdit fromPluginFileEdit() {
    final sourceEdits = edits.map((e) {
      final sourceSpan = SourceEdit.simple(e.offset, e.length,
          replacement: e.replacement, sourceUri: Uri.parse(file));
      return sourceSpan;
    }).toList();
    return SourceFileEdit(
        file: Uri.parse(file),
        edits: sourceEdits,
        fileStamp: DateTime.fromMillisecondsSinceEpoch(fileStamp));
  }
}

extension PluginSourceFileEditsX on List<plugin.SourceFileEdit> {
  List<SourceFileEdit> fromPluginFileEdits() {
    return map((e) => e.fromPluginFileEdit()).toList();
  }
}

extension PluginSourceEditsX on List<plugin.SourceEdit> {
  List<SourceEdit> fromPluginFileEdit() {
    return map((e) => e.fromPluginEdit()).toList();
  }
}

extension SourceEditXX on SourceEdit {
  plugin.SourceEdit toPluginEdit() =>
      plugin.SourceEdit(offset, length, replacement);
}

extension PluginSourceEditX on plugin.SourceEdit {
  SourceEdit fromPluginEdit() {
    return SourceEdit.simple(offset, length, replacement: replacement);
  }
}

extension SourceEditsX on List<SourceEdit> {
  List<plugin.SourceEdit> toPluginEdits() =>
      map((e) => e.toPluginEdit()).toList();
}
