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

  factory CliOptions.fromArgs(
    List<String> args, {
    required bool isPlugin,
  }) {
    return CliOptions(
      isVerboseEnabled: args.contains('verbose') || args.contains('--verbose'),
      mode: args.contains('cli') || args.contains('--cli')
          ? SidecarAnalyzerMode.cli
          : args.contains('debug') || args.contains('--debug')
              ? SidecarAnalyzerMode.debug
              : isPlugin
                  ? SidecarAnalyzerMode.plugin
                  : args.contains('--test')
                      ?
                      // TODO: need to make a test specific case here
                      SidecarAnalyzerMode.debug
                      : throw UnimplementedError('could not parse a mode'),
    );
  }
}
