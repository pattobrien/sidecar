import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

typedef CodeEditId = String;
typedef LintRuleId = String;
typedef LintPackageId = String;

typedef MapDecoder = Object Function(Map json);

typedef LintRuleConstructor = LintRule Function(ProviderContainer ref);
typedef CodeEditConstructor = CodeEdit Function(ProviderContainer ref);
