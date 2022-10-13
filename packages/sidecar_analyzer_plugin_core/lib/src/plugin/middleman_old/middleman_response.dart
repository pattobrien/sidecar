import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'root_response.dart';

part 'middleman_response.freezed.dart';

@freezed
class MiddlemanResponse with _$MiddlemanResponse {
  const factory MiddlemanResponse({
    required Request request,
    required List<ContextRoot> roots,
    required List<RootResponse> responses,
    required DateTime timestamp,
  }) = _MiddlemanResponse;
  const MiddlemanResponse._();
}
