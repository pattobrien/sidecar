import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

typedef MapDecoder = Object Function(Map json);

typedef LintRuleConstructor = LintRule Function(ProviderContainer ref);
typedef CodeEditConstructor = CodeEdit Function(ProviderContainer ref);
