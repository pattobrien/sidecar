import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/src/reports/report.dart';
// import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/reports/stdout_report.dart';

@GenerateMocks(
  [
    // StdoutReport,
  ],
  customMocks: [
    // MockSpec()
    MockSpec<StdoutReport>(),
    MockSpec<Report>(),
  ],
)
void registerServices() {
  //
}
