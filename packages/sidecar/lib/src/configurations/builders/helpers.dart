// import 'package:tuple/tuple.dart';
// import 'package:yaml/yaml.dart';

// import 'exceptions.dart';

// Either<SidecarConfigException, Object> computeField<T>(
//   YamlMap sidecarLints,
//   String packageName,
//   String fieldName,
// ) {
//   final package = sidecarLints.nodes[packageName] as YamlMap?;
//   final hasPackageValue = package != null;
//   if (!hasPackageValue) {
//     return throw UnimplementedError();
//   }
//   final hasValue = package.nodes.containsKey(fieldName);
//   final isCorrectType = sidecarLints.nodes[fieldName] is T;

//   if (!hasValue) {
//     return Left(
//       SidecarLintPackageException(
//           sidecarLints.nodes[packageName]! as YamlScalar),
//     );
//   }
//   if (!isCorrectType) {
//     return Left(SidecarFieldException(package[fieldName] as YamlScalar));
//   }
//   return Right(package.nodes[fieldName]!);
// }
