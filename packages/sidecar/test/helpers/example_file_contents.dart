import 'package:path/path.dart' as p;

const kContentWithoutString = '''
// does not have a string
''';

const kContentWithString = '''
void main() {
  final abc = 'string value';
}
''';

const kContentWithTwoStrings = '''
void main() {
  final abc = 'string value';
  final abcd = 'second string value';
}
''';

final kMainFilePath = p.join('lib', 'main.dart');

const kAnalysisYamlContentWithoutSidecar = '''
analyzer:
  plugins:

''';
const kAnalysisYamlContentWithSidecar = '''
analyzer:
  plugins:
    - sidecar
''';
