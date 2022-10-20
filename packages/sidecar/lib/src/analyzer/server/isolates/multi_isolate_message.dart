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
    @Default(<IsolateResponse>[]) List<IsolateResponse> responses,
  }) = _MultiIsolateReponse;
  const MultiIsolateMessage._();

  bool get isResponseReady => requests.length == responses.length;
}
