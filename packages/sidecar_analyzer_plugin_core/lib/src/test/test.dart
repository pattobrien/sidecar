// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:sidecar/builder.dart';

String src = """
  Dynamism d = new Dynamism(expert:true);
main(){
  var o = new Object();
  d.on(o).hi = 'bye';
}
""";

void testSidecarVisitor(
  SidecarAstVisitor visitor,
  String content,
  List<AnalysisResult> expectedResults,
) {
  final ast = parseString(content: content);
  ast.unit.accept(visitor);
  var verifiedResults = <AnalysisResult>[];
  for (var result in visitor.nodes) {
    verifiedResults.add(
      expectedResults.firstWhere((expectedResult) => expectedResult == result),
    );
  }
}
