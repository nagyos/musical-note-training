abstract interface class IdGenerator {
  String next(String prefix);
}

/// Deterministic IDs for tests.
final class SequentialIdGenerator implements IdGenerator {
  SequentialIdGenerator(this.prefix, {this.start = 1});

  final String prefix;
  final int start;

  int _counter = 0;

  @override
  String next(String prefix) {
    _counter += 1;
    return '$prefix-${start + _counter - 1}';
  }
}

/// Time-based IDs for production.
final class TimestampIdGenerator implements IdGenerator {
  const TimestampIdGenerator();

  @override
  String next(String prefix) {
    return '$prefix-${DateTime.now().toUtc().microsecondsSinceEpoch}';
  }
}