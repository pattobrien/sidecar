import 'package:mockito/annotations.dart';
import 'package:sidecar/src/reports/reporter.dart';
// import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/reports/stdout_reporter.dart';

@GenerateMocks(
  [
    // StdoutReport,
  ],
  customMocks: [
    // MockSpec()
    MockSpec<StdoutReporter>(),
    MockSpec<Reporter>(),
  ],
)
void registerServices() {
  //
}
