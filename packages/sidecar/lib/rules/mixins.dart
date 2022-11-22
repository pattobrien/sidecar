import 'package:meta/meta.dart';

import '../src/configurations/sidecar_spec/package_options.dart';
import '../src/configurations/sidecar_spec/rule_options.dart';
import '../src/rules/rules.dart';

mixin Configuration on BaseRule {
  late final Map<dynamic, dynamic>? ruleConfiguration;

  @override
  @mustCallSuper
  void refresh({
    required RuleOptions? config,
    required PackageOptions? packageConfig,
  }) {
    ruleConfiguration = config?.configuration;
    super.refresh(packageConfig: packageConfig, config: config);
  }
}
