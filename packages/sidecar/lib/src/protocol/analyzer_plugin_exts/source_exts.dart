import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import '../../utils/uri_ext.dart';
import '../source/source.dart';

extension SourceFileEditX on SourceFileEdit {
  plugin.SourceFileEdit toPluginFileEdit() {
    return plugin.SourceFileEdit(
        file.pathNoTrailingSlash, -1, // fileStamp.millisecondsSinceEpoch,
        edits: edits.toPluginEdits());
  }
}

extension SourceFileEditsX on List<SourceFileEdit> {
  List<plugin.SourceFileEdit> toPluginFileEdits() =>
      map((e) => e.toPluginFileEdit()).toList();
}

extension PluginSourceFileEditX on plugin.SourceFileEdit {
  SourceFileEdit fromPluginFileEdit() {
    final sourceEdits = edits.map((e) {
      final sourceSpan = SourceEdit.fromOffset(e.offset, e.length,
          replacement: e.replacement, sourceUri: Uri.file(file));
      return sourceSpan;
    }).toList();
    return SourceFileEdit(filePath: file, edits: sourceEdits);
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
    return SourceEdit.fromOffset(offset, length, replacement: replacement);
  }
}

extension SourceEditsX on List<SourceEdit> {
  List<plugin.SourceEdit> toPluginEdits() =>
      map((e) => e.toPluginEdit()).toList();
}
