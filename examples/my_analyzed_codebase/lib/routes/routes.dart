import 'package:auto_route/auto_route.dart';

import 'package:my_analyzed_codebase/my_analyzed_codebase.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(page: SomePage, initial: true),
  ],
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
)
class $AppRouter {}
// my map: null
// node => parents: ListLiteralImpl => NamedExpressionImpl => ArgumentListImpl => AnnotationImpl

