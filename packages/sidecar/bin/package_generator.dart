import 'package:sidecar/generator.dart';

void main() {
  const package = 'riverpod-2.0.2';
  const uri = '/Users/pattobrien/.pub-cache/hosted/pub.dartlang.org/$package';
  PackageGenerator().generateForPubPackage(uri);
}
