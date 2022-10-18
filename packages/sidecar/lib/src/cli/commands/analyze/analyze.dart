import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
// ignore: implementation_imports
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';

import '../../../analyzer/starter.dart';
import '../../../configurations/project/errors.dart';
import '../../../services/active_project_service.dart';
import '../exit_codes.dart';

class AnalyzeCommand extends Command<int> {
  AnalyzeCommand() {
    argParser.addFlag('verbose', abbr: 'v');
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

      final root = Directory.current.uri;
      final container = ProviderContainer();
      final activeProjectService = container.read(activeProjectServiceProvider);
      final pluginPackage =
          activeProjectService.getSidecarPluginUriForPackage(root);
      if (pluginPackage == null) {
        throw UnimplementedError(
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

      // final channel = ServerIsolateChannel.discovered(
      //   executableUri,
      //   packagesUri,
      //   NoopInstrumentationService(),
      // );
      final process = await Process.start(
        'dart',
        ['run', executableRelativeUri.path, ...?argResults?.arguments],
        workingDirectory: Directory.current.path,
      );

      // await channel.listen(
      //   (response) => stdout.writeln(response),
      //   (notification) => stdout.writeln(notification),
      //   onError: (dynamic error) => stdout.writeln(error),
      // );
      // process.stdout
      //     .listen((e) => stdout.writeln('\u001b[36m${utf8.decode(e)}'));
      //
      process.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
      process.stderr.listen((e) => stderr.writeln(utf8.decode(e)));
      stdout.writeln('exit: ${(await process.exitCode).toString()}');
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
