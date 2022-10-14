import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'active_context_root.dart';

part 'isolate_message.freezed.dart';

@freezed
class IsolateMessage with _$IsolateMessage {
  const IsolateMessage._();

  const factory IsolateMessage.request({
    required Request request,
    required ActiveContextRoot root,
  }) = IsolateRequest;

  const factory IsolateMessage.response({
    required Response response,
    required ActiveContextRoot root,
  }) = IsolateResponse;
}
