import 'package:riverpod/riverpod.dart';

final isolateMessageAggregatorProvider =
    Provider.autoDispose.family<void, int>((ref, messageId) {
  //
});
