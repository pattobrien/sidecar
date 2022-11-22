import 'package:glob/glob.dart';

/// Convert a single glob to a pattern.
///
/// Useful for converting a Glob to JSON.
String globToString(Glob glob) => glob.pattern;

/// Convert a list of globs to a list of patterns (strings).
///
/// Useful for converting a Glob to JSON.
List<String>? globsToStrings(List<Glob>? globs) =>
    globs?.map(globToString).toList();

/// Convert a pattern (string) to a glob.
///
/// Useful for converting a Glob to JSON.
Glob globFromString(String pattern) => Glob(pattern);

/// Convert a list of glob-pattern strings to a list of globs.
///
/// Useful for converting a Glob to JSON.
List<Glob>? globsFromStrings(List<String>? patterns) =>
    patterns?.map(globFromString).toList();
