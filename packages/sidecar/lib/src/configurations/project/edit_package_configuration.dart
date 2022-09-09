import 'edit_configuration.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.edits,
  });

  factory EditPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return EditPackageConfiguration(
      packageName: packageName,
      edits: json.map<String, EditConfiguration>((dynamic key, dynamic value) {
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
  final String packageName;
  final Map<String, EditConfiguration> edits;
}
