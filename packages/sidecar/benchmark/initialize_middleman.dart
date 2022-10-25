import 'dart:isolate';

import 'package:benchmark_harness/benchmark_harness.dart';

abstract class Benchmark extends BenchmarkBase {
  const Benchmark(String name) : super(name);

  @override
  void exercise() {
    for (int i = 0; i < 100000; i++) {
      run();
    }
  }
}

class GrowableListBenchmark extends Benchmark {
  const GrowableListBenchmark(this.length) : super('growable[$length]');

  final int length;

  @override
  void run() {
    //
  }
}

class FixedLengthListBenchmark extends Benchmark {
  const FixedLengthListBenchmark(this.length) : super('fixed-length[$length]');

  final int length;

  @override
  void run() {
    //
  }
}

void main() {
  const GrowableListBenchmark(32).report();
  const FixedLengthListBenchmark(32).report();
}
