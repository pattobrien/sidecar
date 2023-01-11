import '../../protocol/models/models.dart';

class RuleScope {
  const RuleScope({
    Selector<Iterable<TotalDataResult>>? dataSelector,
  }) : dataSelector = dataSelector ?? _defaultDataSelector;

  final Selector<Iterable<TotalDataResult>> dataSelector;

  // void x() {
  //   final x = ProviderContainer();
  //   final data = x.read(dataProvider.select(dataSelector));
  // }
}

typedef Selector<T> = T Function(T results);

Iterable<TotalDataResult> _defaultDataSelector(Iterable<TotalDataResult> val) =>
    val;

// final dataProvider = Provider<Set<TotalData>>((ref) => {});

// class FakeBaseRule {
//   RuleScope get scope =>
//       RuleScope(dataSelector: (v) => v.where((data) => data.code.id == ''));

//   static const _defaultScope = RuleScope();
// }

