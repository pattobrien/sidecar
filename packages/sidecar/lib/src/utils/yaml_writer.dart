class YamlWriter {
  /// Initialize the writer with the amount of [spaces] per level.
  const YamlWriter({
    this.spaces = 2,
  });

  /// The amount of spaces for each level.
  final int spaces;

  /// Write a dart structure to a YAML string. [yaml] should be a [Map] or [List].
  String write(dynamic yaml) {
    return _writeInternal(yaml).trim();
  }

  /// Write a dart structure to a YAML string. [yaml] should be a [Map] or [List].
  String _writeInternal(dynamic yaml, {int indent = 0}) {
    var str = '';

    if (yaml is List) {
      str += _writeList(yaml, indent: indent);
    } else if (yaml is Map) {
      str += _writeMap(yaml, indent: indent);
    } else if (yaml is String) {
      str += '"${yaml.replaceAll('"', '\\\"')}"';
    } else {
      str += yaml.toString();
    }

    return str;
  }

  /// Write a list to a YAML string.
  /// Pass the list in as [yaml] and indent it to the [indent] level.
  String _writeList(List yaml, {int indent = 0}) {
    final buffer = StringBuffer()..write('\n');

    for (final item in yaml) {
      buffer.write(
          '${_indent(indent)}- ${_writeInternal(item, indent: indent + 1)}\n');
    }

    return buffer.toString();
  }

  /// Write a map to a YAML string.
  /// Pass the map in as [yaml] and indent it to the [indent] level.
  String _writeMap(Map yaml, {int indent = 0}) {
    final buffer = StringBuffer()..write('\n');

    for (final key in yaml.keys) {
      final dynamic value = yaml[key];
      buffer.write(
          '${_indent(indent)}${key.toString()}: ${_writeInternal(value, indent: indent + 1)}\n');
    }

    return buffer.toString();
  }

  /// Create an indented string for the level with the spaces config.
  /// [indent] is the level of indent whereas [spaces] is the
  /// amount of spaces that the string should be indented by.
  String _indent(int indent) {
    return ''.padLeft(indent * spaces);
  }
}
