
# Single-Isolate Architecture

*Multiple packages, one lint process.*

In comparison to the bare ```analyzer_plugin``` package, what makes Sidecar extremely powerful is that lints from any number of packages are designed to work together within one isolate / process. By running within one isolate, lints can share RAM and CPU resources, ultimately resulting in top-tier performance.

## Process Overview

1. When ```sidecar``` is enabled in ```analysis_options.yaml```, a "middleman" plugin is booted up from any direct or transitive ```sidecar``` dependency. 

2. The middleman plugin checks the root package's dependency graph for all packages that both a) depend on ```sidecar``` and b) define ```LintRules``` (TODO: more info on what this entails). After obtaining the list of sidecar lint packages, the middleman plugin generates a series of files within ```.dart_tool/sidecar``` at the active-project root.

These files include a concatenation of all of the ```LintRules``` found in all lint packages:

```dart
// .dart_tool/sidecar/constructors.dart
// generated array of lint rules

import 'package:sidecar/sidecar.dart';

import 'package:design_system_lints/design_system_lints.dart' as design_system_lints;
import 'package:l10n_lints/l10n_lints.dart' as l10n_lints;

List<SidecarBaseConstructor> constructors = [
  design_system_lints.AvoidEdgeInsetsLiteral.new,
  design_system_lints.AvoidIconLiteral.new,
  design_system_lints.AvoidBoxShadowLiteral.new,
  design_system_lints.AvoidTextStyleLiteral.new,
  design_system_lints.AvoidBorderRadiusLiteral.new,
  design_system_lints.AvoidSizedBoxHeightWidthLiterals.new,
  l10n_lints.AvoidStringLiterals.new,
];
```

...as well as some generic entrypoints for sidecar to execute from:

```dart
// .dart_tool/sidecar/sidecar.dart
// generated executable file

import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startSidecarPlugin(
    sendPort, 
    args,
    constructors: constructors,  // takes lint rule constructors as input
    isMiddleman: false,
  );
}

```

3. Once the above files are generated, the middleman plugin then launches an isolate using this executable, which launches the Sidecar analyzer plugin together with the array of ```LintRules``` from ```constructors.dart```. The reason this step is required is because in order to run all lint packages within one isolate, we need to dynamically aggregate the multiple packages into one single ```main()``` function.

4. Once everything is up and running, the middleman plugin passes all analysis requests (lint, quick assist, etc.) to the Sidecar analyzer plugin where the requests are then processed.

### Additional Notes

- Both the middleman plugin and the Sidecar analyzer plugin utilize the same package_config.json as the root project - this gaurantees that, as long as ```pub get``` resolves for the root project, so will all of the lints regardless of the dependencies that they're analyzing
- You can depend on any kind of lint dependency: hosted from pub.dev, hosted from a private repository, git, path, etc.
- The architecture for the generated files was inspired from how build_runner works behind the scenes, which also generates such entrypoint files. 
