import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';

extension IntlDartFileEditBuilderX on DartFileEditBuilder {
  ImportLibraryElementResult importFlutterGenAppLocalizations() =>
      importLibraryElement(Uri(
          scheme: 'package',
          path: 'flutter_gen/gen_l10n/app_localizations.dart'));
}
