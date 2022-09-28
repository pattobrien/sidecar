import 'package:sidecar/builder.dart';
import 'example_config.dart';

class SomeCodeEdit extends CodeEdit {
  SomeCodeEdit();

  @override
  String get code => 'some_code_edit';

  @override
  String get packageName => 'some_package';

  @override
  ExampleConfig get configuration => super.configuration as ExampleConfig;

  @override
  ExampleConfig Function(Map json) get jsonDecoder => ExampleConfig.fromJson;

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) async {
    return const [
      EditResult(
        message: 'Heres some message to display to the user.',
        sourceChanges: [],
      )
    ];
  }
}
