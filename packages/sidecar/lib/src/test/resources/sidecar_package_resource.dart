// import 'dart:io';

// import 'package:file/src/interface/file_system.dart';
// import 'package:analyzer/file_system/file_system.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:sidecar/src/test/resources/resource_mixin.dart';

// import 'package:path/path.dart' as p;

// class SidecarPackageResource with ResourceMixin {
//   SidecarPackageResource({
//     required this.constructors,
//     required this.parentDirectoryPath,
//     required this.resourceProvider,
//     required this.fileSystem,
//   });
//   @override
//   final ResourceProvider resourceProvider;

//   @override
//   final FileSystem fileSystem;

//   @override
//   String get rootPath => p.join(parentDirectoryPath, projectName);

//   final String parentDirectoryPath;
//   final List<SidecarBaseConstructor> constructors;

//   void init() {
//     final rules = constructors.map((e) => e()).toList();
//   }

//   void _createPubspec() {
//     //
//   }
// }

// String baseConfig(List<BaseRule> rules) {
//   if (rules.isEmpty) throw StateError('at least 1 rule is required');
//   final packageName = rules.first.code.package;

//   //TODO make this dynamic:
//   final pluginPath = Directory.current.path;
//   return '''
// name: $packageName

// environment:
//   sdk: ">=2.17.0 <3.0.0"

// dependencies:
//   analyzer: ^4.2.0
//   sidecar:
//     path: $pluginPath
//   source_span: ^1.9.1
// ''';
// }
