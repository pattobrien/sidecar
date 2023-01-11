# flutter test --coverage
# lcov --remove coverage/lcov.info '**/*.g.dart' '**/*.freezed.dart' -o coverage/new_lcov.info
# genhtml coverage/new_lcov.info --output=coverage

dart test --coverage="coverage"
dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -o ./coverage/lcov.info -i ./coverage
lcov --remove coverage/lcov.info '**/*.g.dart' '**/*.freezed.dart' -o coverage/lcov.info
