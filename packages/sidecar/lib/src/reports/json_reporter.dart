// import 'dart:convert';

// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:cli_util/cli_logging.dart';
// import 'package:path/path.dart';
// import 'package:riverpod/riverpod.dart';

// import '../protocol/communication/notifications.dart';
// import '../protocol/models/log_record.dart';
// import '../rules/lint_severity.dart';
// import '../utils/utils.dart';
// import 'reporter.dart';

// class JsonReporter implements Reporter {
//   late Uri uri;
//   late Progress progress;

//   @override
//   void init(Uri? uri) {
//     this.uri = uri!;
//     progress = Logger.standard().progress('Analyzing');
//   }

//   @override
//   void handleError(Object object, StackTrace stackTrace) {
//     // TODO: implement handleError
//   }

//   @override
//   void handleLintNotification(LintNotification notification) {
//     _notifications.add(notification);
//   }

//   final List<LintNotification> _notifications = [];

//   @override
//   void handleLog(LogRecord log) {
//     // TODO: implement handleLog
//   }

//   @override
//   bool hasErrors({bool isStrictMode = false}) {
//     if (isStrictMode) {
//       return _notifications.isNotEmpty;
//     } else {
//       final warningsAndErrors = _notifications
//           .expand((element) => element.lints)
//           .where((element) => element.severity != LintSeverity.info);
//       return warningsAndErrors.isNotEmpty;
//     }
//   }

//   @override
//   void print({bool toDisk = true}) {
//     final diagnostics = _notifications.map((e) => e.toJson()).toList();
//     final json = {'diagnostics': diagnostics};
//     final stringifiedJson = jsonEncode(json);
//     final resourceProvider = PhysicalResourceProvider.INSTANCE;
//     final sidecarFolder = resourceProvider
//         .getFolder(join(uri.toFilePath(), kDartTool, 'sidecar_gen'));
//     if (!sidecarFolder.exists) sidecarFolder.create();
//     final genFile = sidecarFolder.getChildAssumingFile('report.json');
//     genFile.writeAsStringSync(stringifiedJson);

//     _notifications.clear();
//   }
//   //
// }

// final jsonReporterProvider = Provider<Reporter>((_) => JsonReporter());
