// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../protocol/protocol.dart';

part 'isolate_details.freezed.dart';

@freezed
class IsolateDetails with _$IsolateDetails {
  const factory IsolateDetails({
    required ServerIsolateChannel channel,
    required ContextRoot contextRoot,
    required Uri pluginSourceUri,
    required List<SidecarPackage> enabledPackages,
  }) = _IsolateDetails;
  const IsolateDetails._();
}
