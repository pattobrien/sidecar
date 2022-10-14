import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'isolate_message.dart';

part 'multi_isolate_message.freezed.dart';

@freezed
class MultiIsolateMessage with _$MultiIsolateMessage {
  const factory MultiIsolateMessage({
    required Request originalRequest,
    required DateTime initialTimestamp,
    required List<IsolateRequest> requests,
    @Default([]) List<IsolateResponse> responses,
  }) = _MultiIsolateReponse;
  const MultiIsolateMessage._();

  int get id => int.parse(originalRequest.id);

  bool get isResponseReady => requests.length == responses.length;
}
