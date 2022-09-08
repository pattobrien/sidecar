import 'package:freezed_annotation/freezed_annotation.dart';

import '../../sidecar.dart';

part 'package_configuration.g.dart';

@JsonSerializable(anyMap: true)
class PackageConfiguration {
  const PackageConfiguration({
    required this.packageName,
    required this.lints,
  });

  final String packageName;
  final List<LintConfiguration> lints;

  factory PackageConfiguration.fromJson(Map<dynamic, dynamic> json) =>
      _$PackageConfigurationFromJson(json);
}
