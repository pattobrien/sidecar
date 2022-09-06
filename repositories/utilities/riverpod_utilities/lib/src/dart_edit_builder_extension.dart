import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

extension RiverpodDartEditBuilderX on DartEditBuilder {
  //
  writeChangeNotifierProvider({
    String changeNotifier = 'null',
    String variableName = 'someTextControllerProvider',
  }) {
    write(
      '''

final $variableName = ChangeNotifierProvider((ref) { 
  return $changeNotifier;
});
''',
    );
  }
}
