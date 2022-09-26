import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../ast/ast.dart';
import '../configurations/yaml_parsers/yaml_parsers.dart';
import 'models.dart';

@internal
abstract class SidecarBase {
  String get code;
  LintPackageId get packageName;

  MapDecoder? get jsonDecoder => null;

  Id get id => Id(id: code, packageId: packageName, type: type);

  IdType get type;

  @mustCallSuper
  List<YamlSourceError>? get errors => _errors;

  @mustCallSuper
  Object get configuration => _configuration;

  late Ref ref;
  late Object _configuration;
  final List<YamlSourceError> _errors = [];

  List<Glob>? get includes => null;

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void initialize({
    required YamlMap? configurationContent,
    required Ref ref,
  }) {
    this.ref = ref;
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        // final error = YamlSourceError(sourceSpan: sourceSpan, message: message);
        // _errors.add(value);
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
