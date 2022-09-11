import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

extension RiverpodDartFileEditBuilderX on DartFileEditBuilder {
  ImportLibraryElementResult importRiverpod() => importLibraryElement(
      Uri(scheme: 'package', path: 'riverpod/riverpod.dart'));

  ImportLibraryElementResult importFlutterRiverpod() => importLibraryElement(
      Uri(scheme: 'package', path: 'flutter_riverpod/flutter_riverpod.dart'));

  ImportLibraryElementResult importHooksRiverpod() => importLibraryElement(
      Uri(scheme: 'package', path: 'hooks_riverpod/hooks_riverpod.dart'));
}
