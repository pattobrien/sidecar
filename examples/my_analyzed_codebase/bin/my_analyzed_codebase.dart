import 'package:my_analyzed_codebase/my_analyzed_codebase.dart'
    as my_analyzed_codebase;

void main(List<String> arguments) {
  print('Hello world: ${my_analyzed_codebase.calculate()}!');
}

final someString = 'this is a string that should produce a lint error';

// class SomeWidget extends StatelessWidget {
//   //
// }
