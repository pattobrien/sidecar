flutter test --coverage
lcov --remove coverage/lcov.info '**/*.g.dart' -o coverage/new_lcov.info
genhtml coverage/new_lcov.info --output=coverage