import 'package:freezed_annotation/freezed_annotation.dart';

import '../../analyzer/context/analyzed_file.dart';
import '../source/source_file_edit.dart';

part 'file_update_event.freezed.dart';
part 'file_update_event.g.dart';

//TODO: Delete FileUpdateEvent class in favor of SourceFileEdit union
// (SourceFileAdd, SourceFileEdit, SourceFileDelete)
@freezed
class FileUpdateEvent with _$FileUpdateEvent {
  const factory FileUpdateEvent.add(
    AnalyzedFile file,
    String contents,
  ) = AddEvent;

  const factory FileUpdateEvent.modify(
    AnalyzedFile file,
    SourceFileEdit fileEdit,
  ) = ModifyEvent;

  const factory FileUpdateEvent.delete(
    AnalyzedFile file,
  ) = DeleteEvent;

  const FileUpdateEvent._();

  factory FileUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$FileUpdateEventFromJson(json);

  String get filePath => map(
      add: (add) => add.file.path,
      modify: (modify) => modify.file.path,
      delete: (delete) => delete.file.path);
}
