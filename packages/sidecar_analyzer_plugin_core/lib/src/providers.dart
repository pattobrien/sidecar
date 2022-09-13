import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

final lintRuleProvider = Provider<List<LintRule>>((ref) => []);
final codeEditProvider = Provider<List<LintRule>>((ref) => []);
