import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../configurations/configurations.dart';
import 'errors.dart';
import 'typedefs.dart';

abstract class SidecarBase {
  String get code;
  LintPackageId get packageName;

  MapDecoder? get jsonDecoder => null;

  @mustCallSuper
  List<YamlSourceError>? get errors => _errors;

  @mustCallSuper
  Object get configuration => _configuration;

  @internal
  late ProviderContainer ref;
  late Object _configuration;
  final List<YamlSourceError> _errors = [];

  List<Glob>? get includes => null;

  void initialize({
    required YamlMap? configurationContent,
    required ProviderContainer ref,
  }) {
    this.ref = ref;
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        throw EmptyConfiguration('$code error: empty configuration');
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          throw IncorrectConfiguration(
              '$code error: $e', stackTrace, '$packageName $code');
        }
      }
    }
  }
}
