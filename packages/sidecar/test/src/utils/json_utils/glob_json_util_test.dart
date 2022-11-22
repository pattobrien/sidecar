import 'package:glob/glob.dart';
import 'package:sidecar/src/utils/json_utils/glob_json_util.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('globToString utilities:', () {
    test('convert globs to list of strings', () {
      final globs = [Glob('**/.dart'), Glob('lib/**')];
      final strings = globsToStrings(globs);
      expect(strings, ['**/.dart', 'lib/**']);
    });
    test('convert globs to list of strings (null)', () {
      const List<Glob>? globs = null;
      final strings = globsToStrings(globs);
      expect(strings, null);
    });

    test('convert single glob to string', () {
      final glob = Glob('**/.dart');
      final string = globToString(glob);
      expect(string, '**/.dart');
    });
  });

  group('globFromString utilities:', () {
    test('convert list of strings to globs', () {
      final strings = ['**/.dart', 'lib/**'];
      final globs = globsFromStrings(strings);
      expect(globs?.map((e) => e.pattern),
          [Glob('**/.dart').pattern, Glob('lib/**').pattern]);
    });

    test('convert list of strings to globs (null)', () {
      const List<String>? strings = null;
      final globs = globsFromStrings(strings);
      expect(globs, null);
    });

    test('convert single string to glob', () {
      const string = '**/.dart';
      final glob = globFromString(string);
      expect(glob.pattern, Glob('**/.dart').pattern);
    });
  });
}
