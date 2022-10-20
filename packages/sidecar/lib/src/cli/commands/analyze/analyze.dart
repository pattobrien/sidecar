import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../../services/active_project_service.dart';
import '../exit_codes.dart';

class AnalyzeCommand extends Command<int> {
  AnalyzeCommand() {
    argParser.addFlag('verbose', abbr: 'v');
    argParser.addFlag('debug', abbr: 'd');
  }

  @override
  String get description => 'analyze';

  @override
  String get name => 'analyze';

  @override
  FutureOr<int> run() async {
    try {
      if (!stdout.supportsAnsiEscapes) {
        stdout.writeln('ansi is not supported!');
      }

      final root = Directory.current.absolute.uri;
      final container = ProviderContainer();
      final activeProjectService = container.read(activeProjectServiceProvider);
      final pluginPackage =
          activeProjectService.getSidecarPluginUriForPackage(root);

      if (pluginPackage == null) {
        throw StateError(
            'Invalid dart directory, no package_config.json file found.');
      }
      stdout.writeln();
      stdout.writeln('project:\u001b[35m ${root.toFilePath()} \u001b[0m');
      stdout.writeln('plugin:  ${pluginPackage.root.toFilePath()}');
      stdout.writeln();
      // final sidecarPackageEntrypointPath = p.join(pluginPackage.root.path,
      //     'tools', 'analyzer_plugin', 'bin', 'debug.dart');
      // final process = await Process.start(
      //   'dart',
      //   ['run', sidecarPackageEntrypointPath],
      //   workingDirectory: Directory.current.path,
      // );
      // final receivePort = ReceivePort();
      // final stream = receivePort.asBroadcastStream();
      // stream.listen((dynamic e) => stdout.writeln(e.toString()),
      //     onError: (dynamic e) => stderr.addError(e.toString()),
      //     onDone: () => stdout.close());
      // await startSidecarPlugin(
      //     receivePort.sendPort, argResults?.arguments ?? [],
      //     constructors: [], isMiddleman: true, isPlugin: false);
      final executableUri =
          Uri.parse(p.join(root.path, '.dart_tool', 'sidecar', 'debug.dart'));
      final executableRelativeUri =
          Uri.parse(p.join('.dart_tool', 'sidecar', 'debug.dart'));
      final packagesUri = Uri.file(
          p.join(root.path, '.dart_tool', 'package_config.json'),
          windows: Platform.isWindows);

      final newArgs = [...?argResults?.arguments];
      final isDebug =
          newArgs.any((flag) => flag == '--debug' || flag == 'debug');

      if (!isDebug) {
        newArgs.add('--cli');
      }
      if (isDebug) {
        newArgs.add('--enable-vm-service');
      }

      final ansi = Ansi(true);
      // logger.sidecarVerboseMessage(
      //     '${ansi.cyan}sidecar - ${cliOptions.mode.name} initialization started...${ansi.none}');
      final xLogger = Logger.standard(ansi: ansi);
      final progress = xLogger.progress('sidecar - Analyzing project');
      final process = await Process.start(
        'dart',
        [
          'run',
          executableRelativeUri.path,
          ...newArgs,
        ],
        workingDirectory: Directory.current.path,
      );
      // await stdout.addStream(process.stdout);
      process.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
      process.stderr.listen((e) => stderr.writeln(utf8.decode(e)));
      final exitCode = await process.exitCode;
      progress.finish(showTiming: true);
      stdout.writeln('exit: ${exitCode.toString()}');

      return ExitCode.success;
    } catch (e) {
      stdout.writeln('CLI ERROR: $e');
      rethrow;
    }
  }
}
