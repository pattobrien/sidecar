import 'package:analyzer_plugin/protocol/protocol_common.dart';

import '../../sidecar.dart';
import 'example_config.dart';
// import 'example_config.dart';

class SomeCodeEdit extends CodeEdit {
  SomeCodeEdit(super.ref);

  @override
  String get code => 'some_code_edit';

  @override
  String get packageName => 'some_package';

  @override
  String get message => 'Heres some message to display to the user.';

  @override
  ExampleConfig get configuration => super.configuration as ExampleConfig;

  @override
  ExampleConfig Function(Map json) get jsonDecoder => ExampleConfig.fromJson;

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final x = configuration;
    return PrioritizedSourceChange(0, SourceChange(message));
  }
}
