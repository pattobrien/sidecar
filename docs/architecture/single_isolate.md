
# Single-Isolate Architecture

Multiple rule packages, one analyzer process.

In comparison to ```analyzer_plugin``` package, which spins up an isolate for each plugin, what makes Sidecar resource efficient is that lints from any number of packages are designed to work together within one isolate / process via a generated entrypoint ({target_root}/.dart_tool/sidecar/plugin.dart). By running within one isolate, all lint rules can share RAM resources and all files only need to be analyzed once, resulting reduced time and space complexity.

## Process Overview

1. When ```sidecar``` is enabled in ```analysis_options.yaml```, a the Sidecar server plugin is booted up via the Dart analysis server and analyzer_plugin API. 

2. The server plugin checks the target's package_config.json for any dependencies that define top-level Sidecar ```Rule``` classes. After obtaining the list of these Sidecar rule packages and their respective Rules, the server plugin generates a series of files within ```.dart_tool/sidecar``` at the target root. 

The generated files include a concatenation of all ```Rule``` class constructors:

```dart
// .dart_tool/sidecar/constructors.dart

import 'package:sidecar/sidecar.dart';

// This particular example utilizes two different rule packages:
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

import 'package:sidecar/starters/starters.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startSidecarPlugin(
    sendPort, 
    args,
    constructors: constructors,  // takes generated lint rule constructors as input
  );
}

```

3. Once the above files are generated, the server plugin spawns an isolate from the above main() function, which launches the Sidecar Analyzer that in turn handles each analysis server request and aggregates responses from all rules. 

### Additional Notes

- Both the server plugin and the Sidecar analyzer plugin utilize the same package_config.json as the root project - this guarantees that, as long as ```pub get``` resolves for the target project, so will all of the lints regardless of the dependencies that they're meant to be analyzing
- Since we utilize ```pub```, target packages can depend on any Sidecar rule package from pub.dev, a private repository, git, path, etc.
- NOTE: The architecture for generating an aggregated entrypoint file was inspired by build_runner (specifically, how ```.g.dart``` generators from multiple packages are designed to work together)
- It's possible that a single workspace has multiple Sidecar-enabled target roots with different package_config's; in this case, a single server plugin will forward and aggregate messages to/from 1 or more Analyzers