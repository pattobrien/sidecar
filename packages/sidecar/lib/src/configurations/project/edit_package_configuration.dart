import 'edit_configuration.dart';
import 'lint_configuration.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.lints,
  });
  final String packageName;
  final Map<String, EditConfiguration> lints;

  factory EditPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return EditPackageConfiguration(
      packageName: packageName,
      lints: json.map<String, EditConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          return MapEntry(
              key as String,
              EditConfiguration(
                packageName: packageName,
                editId: key,
                configuration: value['configuration'] as Map,
              ));
        } else {
          throw UnimplementedError(
              'could not parse package edits; expected Map was of type ${value.runtimeType}');
        }
      }),
    );
  }
}

// typedef EditName = String;
