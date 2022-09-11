import 'package:auto_route/auto_route.dart';

import '../my_analyzed_codebase.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(page: SomePage, initial: true),
    AdaptiveRoute(page: SomePage, initial: false),
  ],
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
)
class $AppRouter {}
// my map: null
// node => parents: ListLiteralImpl => NamedExpressionImpl => ArgumentListImpl => AnnotationImpl

