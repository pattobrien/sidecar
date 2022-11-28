import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:riverpod/riverpod.dart';

abstract class Benchmark extends BenchmarkBase {
  const Benchmark(String name) : super(name);

  @override
  void exercise() {
    for (var i = 0; i < 100000; i++) {
      run();
    }
  }
}

class SingleLintBenchmark extends Benchmark {
  SingleLintBenchmark(this.length) : super('growable[$length]');

  final int length;
  final container = ProviderContainer();

  @override
  void run() {
    //
  }

  @override
  void setup() {
    //
  }
}
