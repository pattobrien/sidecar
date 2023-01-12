import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'analyzed_file.dart';

@immutable
class AnalyzedFiles extends UnmodifiableSetView<AnalyzedFile> {
  AnalyzedFiles(this._source) : super(_source);

  final Set<AnalyzedFile> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnalyzedFiles &&
            const SetEquality<AnalyzedFile>().equals(other._source, _source));
  }

  @override
  int get hashCode => const SetEquality<AnalyzedFile>().hash(_source);
}
