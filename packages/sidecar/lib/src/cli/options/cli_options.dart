import 'package:freezed_annotation/freezed_annotation.dart';

import '../../analyzer/server/server.dart';

part 'cli_options.freezed.dart';

@freezed
class CliOptions with _$CliOptions {
  const factory CliOptions({
    required bool isVerboseEnabled,
    required SidecarAnalyzerMode mode,
  }) = _CliOptions;
  const CliOptions._();

  factory CliOptions.fromArgs(List<String> args) {
    return CliOptions(
      isVerboseEnabled: args.contains('verbose'),
      mode: args.contains('cli')
          ? SidecarAnalyzerMode.cli
          : args.contains('debug')
              ? SidecarAnalyzerMode.debug
              : SidecarAnalyzerMode.plugin,
    );
  }
}
