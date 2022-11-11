import 'package:glob/glob.dart';

import '../configurations/configurations.dart';

class GlobService {
  GlobService();
  void calculateForConfig(ProjectConfiguration config) {
    config.includeGlobs;
  }
}
