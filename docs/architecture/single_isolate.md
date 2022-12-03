
# Single-Isolate Architecture

Multiple packages, one lint process.

In comparison to ```analyzer_plugin``` package, which spins up an isolate for each plugin, what makes Sidecar resource efficient is that lints from any number of packages are designed to work together within one isolate / process via a generated entrypoint (root/.dart_tool/sidecar/plugin.dart). By running within one isolate, lints can share RAM and CPU resources, ultimately resulting in top-tier performance.

## Process Overview

1. When ```sidecar``` is enabled in ```analysis_options.yaml```, a the Sidecar server plugin is booted up via the Dart analysis server and analyzer_plugin API. 

2. The server plugin checks the target package's dependency graph for all packages that define top-level Sidecar ```Rule``` classes. After obtaining the list of these Sidecar rule packages and their respective rules, the server plugin generates a series of files within ```.dart_tool/sidecar``` at the target root.

These files include a concatenation of all ```Rule``` class constructors:

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
  );
}

```

3. Once the above files are generated, the server plugin spawns an isolate from the above main() executable, which launches the Sidecar Analyzer that in turn handles each analysis server request and aggregates responses from all rules. It's possible that a single workspace has multiple Sidecar-enabled target root, and in this case the intention is for the single server plugin to forward and aggregate messages to/from 1 or more Analyzers.

### Additional Notes

- Both the server plugin and the Sidecar analyzer plugin utilize the same package_config.json as the root project - this guarantees that, as long as ```pub get``` resolves for the target project, so will all of the lints regardless of the dependencies that they're meant to be analyzing
- Since we utilize ```pub```, target packages can depend on any Sidecar rule package from pub.dev, a private repository, git, path, etc.
- NOTE: The architecture for generating an aggregated entrypoint file was inspired by build_runner (how ```.g.dart``` files are designed to work together)
