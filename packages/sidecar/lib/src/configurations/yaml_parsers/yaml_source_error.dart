import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:source_span/source_span.dart';

import '../../utils/source_span_utilities.dart';

class YamlSourceError {
  const YamlSourceError({
    required this.sourceSpan,
    required this.message,
  });

  final String message;
  final SourceSpan sourceSpan;

  AnalysisError toAnalysisError() {
    return AnalysisError(
      AnalysisErrorSeverity.ERROR, AnalysisErrorType.HINT,
      sourceSpan.location, message, 'sidecar_configuration_error',
      // url: rule.url,
      // correction: correction,
      //TODO: hasFix
    );
  }
}
