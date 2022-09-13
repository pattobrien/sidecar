import 'package:auto_route/auto_route.dart';

import '../my_analyzed_codebase.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(page: SomePage, initial: true),
  ],
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
)
class $AppRouter {}
