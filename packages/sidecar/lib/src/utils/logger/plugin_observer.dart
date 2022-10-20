import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';
import '../../cli/options/cli_options.dart';
import 'logger.dart';

class PluginObserver extends ProviderObserver {
  PluginObserver(this.options, this.channel);

  final CliOptions options;
  final PluginCommunicationChannel channel;
  LogDelegateBase get logger => PluginChannelDelegate(options, channel);

  String get header => '[HEADER]'; // _isMiddleman ? 'MIDDLEMAN:' : 'ISOLATE:';

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger.sidecarVerboseMessage(
        '$header didAddProvider     ${provider.name} ${value.toString()}');
  }

  /// A provider emitted an error, be it by throwing during initialization
  /// or by having a [Future]/[Stream] emit an error
  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.sidecarVerboseMessage(
        '$header providerDidFail    ${provider.name} ${error.toString()} ${stackTrace.toString()}');
  }

  /// Called my providers when they emit a notification.
  ///
  /// - [newValue] will be `null` if the provider threw during initialization.
  /// - [previousValue] will be `null` if the previous build threw during initialization.
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.sidecarVerboseMessage(
        '$header didUpdateProvider ${provider.name} ${previousValue.toString()} || ${newValue.toString()}');
  }

  /// A provider was disposed
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    logger.sidecarVerboseMessage('$header didDisposeProvider ${provider.name}');
  }
}
