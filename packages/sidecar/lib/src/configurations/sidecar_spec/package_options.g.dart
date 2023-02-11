// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$$LintPackageOptionsToJson(
    _$LintPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ruleOptions',
      instance.ruleOptions?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  val['runtimeType'] = instance.$type;
  return val;
}

Map<String, dynamic> _$$AssistPackageOptionsToJson(
    _$AssistPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ruleOptions',
      instance.ruleOptions?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  val['runtimeType'] = instance.$type;
  return val;
}
