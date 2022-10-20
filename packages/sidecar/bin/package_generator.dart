import 'package:sidecar/generator.dart';

void main() async {
  const package = 'riverpod-2.0.0';
  const uri =
      'file:///Users/pattobrien/.pub-cache/hosted/pub.dartlang.org/$package';
  const generatedPackagePath =
      '/Users/pattobrien/Development/sidecar/repositories/riverpod_analyzer';
  // PackageGenerator().generateForPubPackage(uri);
  final pack = await PackageGenerator().getPackage(generatedPackagePath);
  print(pack.root);
}
