// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/exception/exception.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/src/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/src/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

class AutoRouteChangeBuilder extends ChangeBuilderImpl {
  AutoRouteChangeBuilder({AnalysisSession? session}) : super(session: session);

  /// A map of absolute normalized path to generic file edit builders.
  final Map<String, AutoRouteFileEditBuilder> _autoRouteFileEditBuilders = {};

  @override
  SourceChange get sourceChange {
    final SourceChange change = super.sourceChange;

    for (var builder in _autoRouteFileEditBuilders.values) {
      if (builder.hasEdits) {
        change.addFileEdit(builder.fileEdit);
        builder.finalize();
      }
    }
    return change;
  }

  Future<void> addAutoRouteFileEdit(
    String path,
    void Function(AutoRouteFileEditBuilder builder) buildFileEdit, {
    ImportPrefixGenerator? importPrefixGenerator,
  }) async {
    var builder = _autoRouteFileEditBuilders[path];
    if (builder == null) {
      builder = await _createAutoRouteFileEditBuilder(path);
      if (builder != null) {
        // It's not currently supported to call this method twice concurrently
        // for the same file as two builder may be produced because of the above
        // `await` so detect this and throw to avoid losing edits.
        if (_autoRouteFileEditBuilders.containsKey(path)) {
          throw StateError(
              "Can't add multiple edits concurrently for the same file");
        }
        _autoRouteFileEditBuilders[path] = builder;
      }
    }
    if (builder != null) {
      builder.importPrefixGenerator = importPrefixGenerator;
      buildFileEdit(builder);
    }
  }

  Future<AutoRouteFileEditBuilder?> _createAutoRouteFileEditBuilder(
    String path,
    // int timeStamp,
  ) async {
    if (!(workspace.containsFile(path) ?? false)) return null;

    final session = workspace.getSession(path);
    final result = await session?.getResolvedUnit(path);

    if (result is! ResolvedUnitResult) {
      throw AnalysisException('Cannot analyze "$path"');
    }

    final timeStamp = result.exists ? 0 : -1;

    final declaredUnit = result.unit.declaredElement;
    final libraryUnit = declaredUnit?.library.definingCompilationUnit;

    AutoRouteFileEditBuilder? libraryEditBuilder;
    if (libraryUnit != null && libraryUnit != declaredUnit) {
      // If the receiver is a part file builder, then proactively cache the
      // library file builder so that imports can be finalized synchronously.
      await addDartFileEdit(libraryUnit.source.fullName, (builder) {
        libraryEditBuilder = builder as AutoRouteFileEditBuilder;
      });
    }

    return AutoRouteFileEditBuilder(
        this, result, timeStamp, libraryEditBuilder);
  }
}

class AutoRouteFileEditBuilder extends DartFileEditBuilderImpl {
  AutoRouteFileEditBuilder(
    super.changeBuilder,
    super.resolvedUnit,
    super.timeStamp,
    super.libraryChangeBuilder,
  );

  @override
  bool get hasEdits => super.hasEdits || librariesToImport.isNotEmpty;

  @override
  AutoRouteEditBuilder createEditBuilder(int offset, int length) {
    return AutoRouteEditBuilder(this, offset, length);
  }

  @override
  void addInsertion(
          int offset, void Function(AutoRouteEditBuilder builder) buildEdit,
          {bool insertBeforeExisting = false}) =>
      super.addInsertion(
          offset, (builder) => buildEdit(builder as AutoRouteEditBuilder),
          insertBeforeExisting: insertBeforeExisting);

  void addRouteInsertion(
    String? parent,
    void Function(AutoRouteEditBuilder builder) buildEdit, {
    bool insertBeforeExisting = false,
  }) {
    //TODO:
    // a) calculate the offset based on the given parent, or if parent = null then offset = last line within
    // the @AdaptiveAutoRouter route array: routes: <AutoRoute>[]
    // b) execute builder() and make the change

    // a) calculate offset
    final someOffset = 0;
    // b) execute change
    // final editBuilder = createAutoRouteEditBuilder(someOffset, 0);
    // buildFileEdit(editBuilder);
    addInsertion(someOffset, (builder) => buildEdit(builder),
        insertBeforeExisting: insertBeforeExisting);
  }

  AutoRouteEditBuilder createAutoRouteEditBuilder(int offset, int length) {
    return AutoRouteEditBuilder(this, offset, length);
  }

  /// Add the edit from the given [edit] to the edits associated with the
  /// current file.
  // void _addEdit(SourceEdit edit, {bool insertBeforeExisting = false}) {
  //   fileEdit.add(edit, insertBeforeExisting: insertBeforeExisting);
  //   var delta = _editDelta(edit);
  //   changeBuilder._updatePositions(edit.offset, delta);
  //   changeBuilder._lockedPositions.clear();
  // }
}

class AutoRouteEditBuilder extends DartEditBuilderImpl {
  AutoRouteEditBuilder(
      AutoRouteFileEditBuilder fileEditBuilder, int offset, int length)
      : super(fileEditBuilder, offset, length);

  /// The buffer in which the content of the edit is being composed.
  // final StringBuffer _buffer = StringBuffer();

  AutoRouteEditBuilder get autoRouteFileEditBuilder =>
      fileEditBuilder as AutoRouteEditBuilder;

  /// Create and return an edit representing the replacement of a region of the
  /// file with the accumulated text.
  // @override
  // SourceEdit get sourceEdit => SourceEdit(offset, length, _buffer.toString());

  // /// If not `null`, [write] will copy everything into this buffer.
  // StringBuffer? _carbonCopyBuffer;

  void writeNewAdaptiveRoute(
    String pageClass, {
    bool initial = false,
  }) {
    writeln('AdaptiveRoute(page: $pageClass, initial: ${initial.toString()}),');
  }

  // @override
  // void write(String string) {
  //   super.write(string);
  //   _carbonCopyBuffer?.write(string);
  // }
}
