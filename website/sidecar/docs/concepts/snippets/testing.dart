/* SNIP Imports */
import 'package:design_system_lints/design_system_lints.dart';
import 'package:sidecar/test.dart';
import 'package:test/test.dart';

/* SNIP Imports END */
/* SNIP Content1 */
const contentDesignSystem = '''
import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';
@designSystem
class DesignSystemX {
  static const value = 3.1;
}
final edgeInsets = EdgeInsets.all(DesignSystemX.value);
''';
/* SNIP Content1 END */
/* SNIP Content2 */
const contentEdgeInsetsAll = '''
import 'package:flutter/material.dart';
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
    );
  }
}
''';
/* SNIP Content2 END */
/* SNIP Content3 */
const contentEdgeInsetsOnly = '''
import 'package:flutter/material.dart';
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 1.1, right: 1.2, top: 1.3, bottom: 1.4),
    );
  }
}
''';
/* SNIP Content3 END */
/* SNIP StartTest */
void main() {
  group('avoid_edge_insets_literal:', () {
    setUpRules([AvoidEdgeInsetsLiteral()]);
/* SNIP StartTest END */
/* SNIP RuleTest1 */
    ruleTest('EdgeInsets using Design System', contentDesignSystem, []);
/* SNIP RuleTest1 END */
/* SNIP RuleTest2 */
    ruleTest('EdgeInsets.all', contentEdgeInsetsAll, [ExpectedText('2.0')]);
/* SNIP RuleTest2 END */
/* SNIP RuleTest3 */
    ruleTest('EdgeInsets.only', contentEdgeInsetsOnly, [
      ExpectedText('1.1'),
      ExpectedText('1.2'),
      ExpectedText('1.3'),
      ExpectedText('1.4'),
    ]);
/* SNIP RuleTest3 END */
    /* SNIP TestEnd */
  });
}
/* SNIP TestEnd END */
