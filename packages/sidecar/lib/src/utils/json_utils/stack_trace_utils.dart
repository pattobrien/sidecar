String stackToString(StackTrace stack) => stack.toString();
StackTrace stringToStack(String string) => StackTrace.fromString(string);

String? stackToStringNullable(StackTrace? stack) =>
    stack == null ? null : stackToString(stack);

StackTrace? stringToStackNullable(String? string) =>
    string == null ? null : stringToStack(string);

// String errorToString(StackTrace stack) => stack.toString();
// StackTrace stringToStack(String string) => StackTrace.fromString(string);