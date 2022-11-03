import 'package:freezed_annotation/freezed_annotation.dart';

import '../source/source_file_edit.dart';

part 'file_update_event.freezed.dart';
part 'file_update_event.g.dart';

@freezed
class FileUpdateEvent with _$FileUpdateEvent {
  const factory FileUpdateEvent.add(
    SourceFileEdit fileEdit,
  ) = AddEvent;

  const factory FileUpdateEvent.modify(
    SourceFileEdit fileEdit,
  ) = ModifyEvent;

  const factory FileUpdateEvent.delete(
    // does this work?
    SourceFileEdit fileEdit,
  ) = ModifyEvent;

  const FileUpdateEvent._();

  factory FileUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$FileUpdateEventFromJson(json);
}
