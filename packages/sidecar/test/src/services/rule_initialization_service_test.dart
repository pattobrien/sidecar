import 'package:intl_lints/intl_lints.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/services/rule_initialization_service.dart';
import 'package:test/test.dart';

void main() {
  group('rule initialization service:', () {
    const initializerService = RuleInitializationService();
    final constructors = [StringLiterals.new];
    test('1 rule initialized', () {
      final config = ProjectConfiguration.fromCodes([kStringLiteralsCode]);
      final result = initializerService.constructRules(config, constructors);
      expect(result.length, 1);
    });

    test('0 rules initialized', () {
      final config = ProjectConfiguration.fromCodes([]);
      final result = initializerService.constructRules(config, constructors);
      expect(result.length, 0);
    });
  });
}
