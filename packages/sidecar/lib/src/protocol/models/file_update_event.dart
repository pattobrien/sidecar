import 'package:freezed_annotation/freezed_annotation.dart';

import '../source/source_file_edit.dart';

part 'file_update_event.freezed.dart';
part 'file_update_event.g.dart';

//TODO: Delete FileUpdateEvent class in favor of SourceFileEdit union
// (SourceFileAdd, SourceFileEdit, SourceFileDelete)
@freezed
class FileUpdateEvent with _$FileUpdateEvent {
  const factory FileUpdateEvent.add(
    String filePath,
    String contents,
  ) = AddEvent;

  const factory FileUpdateEvent.modify(
    SourceFileEdit fileEdit,
  ) = ModifyEvent;

  const factory FileUpdateEvent.delete(
    String filePath,
  ) = DeleteEvent;

  const FileUpdateEvent._();

  factory FileUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$FileUpdateEventFromJson(json);

  String get filePath => map(
      add: (add) => add.filePath,
      modify: (modify) => modify.fileEdit.file.path,
      delete: (delete) => delete.filePath);
}
