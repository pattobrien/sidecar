import 'dart:async';
import 'dart:io';

import 'package:analysis_server_lib/analysis_server_lib.dart';
import 'package:path/path.dart' as path;

class ServerHelper {
  ServerHelper(this.server)
      : tempDir = Directory.systemTemp.createTempSync('tests');

  static Future<ServerHelper> create() async {
    return ServerHelper(await AnalysisServer.create());
  }

  final AnalysisServer server;
  Directory tempDir;
  Map<String, List<AnalysisError>> errors = {};

  Future init() {
    server.analysis.onErrors.listen((AnalysisErrors e) {
      if (e.errors.isEmpty) {
        errors.remove(e.file);
      } else {
        errors[e.file] = e.errors;
      }
    });

    server.server.setSubscriptions(['STATUS']);
    return server.analysis.setAnalysisRoots([tempDir.path], []);
  }

  Stream get onAnalysisFinished {
    return server.server.onStatus.where((status) {
      return status.analysis != null && status.analysis!.isAnalyzing == false;
    });
  }

  Future<String> createFile(String filePath, String text) {
    final fullPath = path.join(tempDir.path, filePath);
    return server.analysis.updateContent(
      {fullPath: AddContentOverlay(text)},
    ).then((dynamic _) => fullPath);
  }

  void dispose() {
    server.dispose();
    tempDir.deleteSync(recursive: true);
  }
}
