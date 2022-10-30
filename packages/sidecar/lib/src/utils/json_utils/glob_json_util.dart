import 'package:glob/glob.dart';

String globToString(Glob glob) => glob.pattern;

List<String> globsToString(List<Glob>? globs) =>
    globs?.map(globToString).toList() ?? <String>[];

Glob globFromString(String pattern) => Glob(pattern);

List<Glob> globsFromString(List<String>? patterns) =>
    patterns?.map(globFromString).toList() ?? <Glob>[];
