import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'example_edit.dart';

void main(List<String> args) {
  final ref = ProviderContainer();
  final example = SomeCodeEdit();
  final config = <dynamic, dynamic>{'property': 'some_property'};
  final stringConfig = jsonEncode(config);
  final converted = example.jsonDecoder(config);
  print('property: ${converted.property}');
  // example.initialize(configurationContent: stringConfig);
  final configu = example.configuration;

  print('property: ${configu.property}');
}
