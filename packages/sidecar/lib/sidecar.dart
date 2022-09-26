library sidecar;

export 'package:analyzer/dart/analysis/results.dart';
export 'package:analyzer/dart/ast/ast.dart';
export 'package:analyzer/dart/ast/visitor.dart';

export 'package:analyzer_plugin/protocol/protocol_generated.dart'
    hide ContextRoot;
export 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

export 'package:source_span/source_span.dart';

export 'src/ast/ast.dart' hide VisitorSubscription;
export 'src/configurations/configurations.dart';
export 'src/models/models.dart';
export 'src/reporter/reporter.dart';
export 'src/utils/utils.dart';
