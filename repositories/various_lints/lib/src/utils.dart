import 'package:path/path.dart' as p;

bool isPathApplicationLayer(String rootPath, String filePath) {
  final relativePath = p.relative(filePath, from: rootPath);
  final relativeUri = Uri(scheme: 'file', path: relativePath);
  return relativeUri.pathSegments.any((element) => element == 'application');
}
