// // ignore_for_file: implementation_imports

// import 'package:riverpod/src/framework.dart';
// import 'package:glob/glob.dart';
// import 'package:analyzer/dart/analysis/session.dart';
// import 'package:analyzer/dart/analysis/analysis_context.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:analyzer/src/lint/linter.dart' as analyzer;
// import 'package:source_span/src/span.dart';

// class LinterRule extends analyzer.LintRule implements LintRule {
//   LinterRule({
//     required String code,
//     required PackageType package,
//     String? url,
//     required LintRuleType severity,
//   })  : _code = code,
//         _package = package,
//         _url = url,
//         _severity = severity,
//         super(
//             details: '',
//             group: analyzer.Group.style,
//             name: '',
//             description: '');

//   final String _code;
//   final PackageType _package;
//   final String? _url;
//   final LintRuleType _severity;

//   @override
//   String get code => _code;

//   @override
//   LintPackageId get packageName => '${_package.name}_lints';

//   @override
//   String? get url => _url;

//   @override
//   LintRuleType get defaultType => _severity;

//   @override
//   Ref<Object?> ref;

//   @override
//   // TODO: implement annotatedNodes
//   List<SidecarAnnotatedNode> get annotatedNodes => throw UnimplementedError();

//   @override
//   Future<List<DartAnalysisResult>> computeDartAnalysisResults(ResolvedUnitResult unit) {
//     // TODO: implement computeDartAnalysisResults
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<AnalysisResult>> computeGenericAnalysisResults(AnalysisContext analysisContext, String path) {
//     // TODO: implement computeGenericAnalysisResults
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<EditResult>> computeSourceChanges(AnalysisSession session, AnalysisResult result) {
//     // TODO: implement computeSourceChanges
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<AnalysisResult>> computeYamlAnalysisResults(YamlMap yamlMap) {
//     // TODO: implement computeYamlAnalysisResults
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement configuration
//   Object get configuration => throw UnimplementedError();

//   @override
//   // TODO: implement errors
//   List<SidecarConfigException>? get errors => throw UnimplementedError();

//   @override
//   // TODO: implement includes
//   List<Glob>? get includes => throw UnimplementedError();

//   @override
//   void initialize({required Ref<Object?> ref, required SourceSpan lintNameSpan, required YamlMap? configurationContent, List<SidecarAnnotatedNode> annotatedNodes = const []}) {
//     // TODO: implement initialize
//   }

//   @override
//   // TODO: implement jsonDecoder
//   MapDecoder? get jsonDecoder => throw UnimplementedError();

//   @override
//   void update({List<SidecarAnnotatedNode> annotatedNodes = const []}) {
//     // TODO: implement update
//   }
// }

// enum PackageType { flutter, dart }

// LintRule convertDartLinterRuleToLintRule(analyzer.LintRule rule) {
//   return LinterRule(
//     code: rule.lintCode.name,
//     package: PackageType.dart,
//     url: rule.lintCode.url,
//     severity: rule.lintCode.errorSeverity.toSidecarSeverity(),
//   );
// }
