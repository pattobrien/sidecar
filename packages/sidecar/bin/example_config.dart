import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_config.g.dart';

@JsonSerializable(anyMap: true)
class ExampleConfig {
  const ExampleConfig({
    required this.property,
  });

  factory ExampleConfig.fromJson(Map json) {
    return ExampleConfig(
      property: json['property'] as String,
    );
  }

  final String property;
}
