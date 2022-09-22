import 'package:glob/glob.dart';

import 'edit_configuration.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.edits,
    this.includes,
  });

  factory EditPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return EditPackageConfiguration(
      packageName: packageName,
      edits: json.map<String, EditConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          final hasConfiguration = value.containsKey('configuration');
          return MapEntry(
            key as String,
            EditConfiguration(
              packageName: packageName,
              editId: key,
              configuration: hasConfiguration
                  ? value['configuration'] as Map
                  : <dynamic, dynamic>{},
            ),
          );
        } else if (value == null) {
          return MapEntry(
            key as String,
            EditConfiguration(
              packageName: packageName,
              editId: key,
              configuration: <dynamic, dynamic>{},
            ),
          );
        } else {
          throw UnimplementedError(
              'could not parse package edits; expected Map was of type ${value.runtimeType}');
        }
      }),
    );
  }
  final String packageName;
  final Map<String, EditConfiguration> edits;
  final List<Glob>? includes;
}
