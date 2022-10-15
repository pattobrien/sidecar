import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../../../sidecar.dart';
import '../../../configurations/project/errors.dart';
import '../../../services/active_project_service.dart';
import '../exit_codes.dart';

class AnalyzeCommand extends Command<int> {
  AnalyzeCommand();

  @override
  String get description => 'analyze';

  @override
  String get name => 'analyze';

  @override
  FutureOr<int> run() async {
    try {
      // stdout.encoding = AsciiCodec(allowInvalid: false);
      stdout.writeln('ansi support: ${stdout.supportsAnsiEscapes}');
      // print('project directory: ${Directory.current}');
      final root = Directory.current.uri;
      final container = ProviderContainer();
      final activeProjectService = container.read(activeProjectServiceProvider);
      final pluginPackage =
          activeProjectService.getSidecarPluginUriForPackage(root);
      if (pluginPackage == null) {
        throw UnimplementedError(
            'Invalid dart directory, no package_config.json file found.');
      }
      stdout.writeln(
          '\u001b[35m sidecar package: ${pluginPackage.root.toFilePath()} \u001b[0m');
      final sidecarPackageEntrypointPath = p.join(pluginPackage.root.path,
          'tools', 'analyzer_plugin', 'bin', 'debug.dart');
      final process = await Process.start(
        'dart',
        ['run', sidecarPackageEntrypointPath],
        workingDirectory: Directory.current.path,
      );
      final receivePort = ReceivePort();
      final stream = receivePort.asBroadcastStream();
      stream.listen(stdout.writeln);
      await startSidecarPlugin(receivePort.sendPort, [],
          constructors: [], isMiddleman: true, isPlugin: false);

      // process.stdout
      //     .listen((e) => stdout.writeln('\u001b[36m${utf8.decode(e)}'));
      process.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
      process.stderr.listen((e) => stderr.writeln(utf8.decode(e)));
      stdout.writeln((await process.exitCode).toString());
      return ExitCode.success;
    } on MissingSidecarYamlConfiguration catch (e) {
      // print(e.toString());
      rethrow;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
