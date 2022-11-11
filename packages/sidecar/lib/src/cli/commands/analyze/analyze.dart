// ignore_for_file: prefer_const_declarations

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../../../sidecar.dart';
import '../../../services/active_project_service.dart';
import '../../../services/isolate_builder_service.dart';
import '../../../utils/duration_ext.dart';
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
    final ansi = Ansi(true);
    final xLogger = Logger.standard(ansi: ansi);
    // final progress = xLogger.progress('sidecar - Analyzing project');
    final watch = Stopwatch()..start();
    xLogger.write('sidecar - Analyzing project...');
    try {
      if (!stdout.supportsAnsiEscapes) {
        stdout.writeln('ansi is not supported!');
      }

      final root = Directory.current.absolute.uri;
      final container = ProviderContainer();
      final activeProjectService = container.read(activeProjectServiceProvider);
      final activeProject = activeProjectService.initActiveContextFromUri(root);

      if (activeProject == null) {
        throw StateError(
            'Invalid dart directory, no package_config.json file found.');
      }
      final pluginPackage = activeProject.pluginSourceUri;
      stdout.writeln();
      stdout.writeln('project:\u001b[35m ${root.toFilePath()} \u001b[0m');
      stdout.writeln('plugin:  ${pluginPackage.toFilePath()}');
      stdout.writeln();
      final isolateBuilder = container.read(isolateBuilderServiceProvider);
      isolateBuilder.setupPluginSourceFiles(activeProject);
      isolateBuilder.setupBootstrapper(activeProject);
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
      final exeUri =
          Uri.parse(p.join(root.path, '.dart_tool', 'sidecar', 'debug.exe'));
      final executableRelativeUri =
          Uri.parse(p.join('.dart_tool', 'sidecar', 'debug.dart'));
      final packagesUri = Uri.file(
          p.join(root.path, '.dart_tool', 'package_config.json'),
          windows: Platform.isWindows);
      // dart compile exe --packages=.dart_tool/package_config.json .dart_tool/sidecar/debug.dart
      // ./.dart_tool/sidecar/debug.exe --cli
      final shouldCompile = false;
      // ignore: dead_code
      if (shouldCompile) {
        final compilerProcess = await Process.start(
          'dart',
          [
            'compile',
            'exe',
            executableRelativeUri.path,
            '--packages=${packagesUri.toFilePath()}',
            // exeUri.toFilePath(),
            // '--cli'
          ],
          workingDirectory: Directory.current.path,
        );
        compilerProcess.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
        compilerProcess.stderr.listen((e) => stderr.writeln(utf8.decode(e)));
        final compilerExitCode = await compilerProcess.exitCode;
        stdout.writeln('exit: ${compilerExitCode.toString()}');
      }
      final newArgs = [...?argResults?.arguments];
      final isDebug =
          newArgs.any((flag) => flag == '--debug' || flag == 'debug');

      if (!isDebug) {
        newArgs.add('--cli');
      }
      if (isDebug) {
        newArgs.add('--enable-vm-service');
      }
      // ignore: dead_code
      if (shouldCompile) {
        final receivePort = ReceivePort();
        receivePort.listen((dynamic message) {
          stdout.write(message);
        });
        await startSidecarCli(receivePort.sendPort, ['--cli']);
        stdout.writeln('completed in: ${watch.elapsed.prettified()}');
        await stdout.flush();
        return 0;
        // ignore: dead_code
      } else {
        final receivePort = ReceivePort();
        receivePort.listen((dynamic message) {
          stdout.write(message);
        }, onDone: () async {
          // TODO: elapsed time
          // stdout.writeln('completed in: ${watch.elapsed.prettified()}');
          // await stdout.flush();
        });
        await startSidecarCli(receivePort.sendPort, ['--cli']);
      }

      // final process = await Process.start(
      //   'dart',
      //   [
      //     'run',
      //     executableRelativeUri.path,
      //     ...newArgs,
      //   ],
      //   workingDirectory: Directory.current.path,
      // );

      // process.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
      // process.stderr.listen((e) => stderr.writeln(utf8.decode(e)));
      // final exitCode = await process.exitCode;
      // progress.finish(showTiming: true);
      // stdout.writeln('finished in: ${progress.elapsed.inSeconds} seconds.');
      // stdout.writeln('exit: ${exitCode.toString()}');

      return ExitCode.success;
    } catch (e) {
      stdout.writeln('CLI ERROR: $e');
      rethrow;
    }
  }
}
