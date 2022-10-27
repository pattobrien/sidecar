# Sidecar Analyzer
*Enable a more personalized experience within your IDE.*


<img src="/docs/ide_screenshot.png" alt="ide lint" width="600"/>

## Table of Contents

- Motivations
- Getting Started
- Architecture
- Next steps

# Motivations and Objective

- TODO

# Getting Started


## Using Sidecar within a Dart or Flutter Project

There are 3 modes which Sidecar can be run in: server, cli, or debug (WIP).
### Server Mode

The Dart team maintains analysis servers that run in IDEs like VSCode. In Server mode, Sidecar boots up using the ```analyzer_plugin``` APIs created by the Dart team. 

To enable Sidecar to display lints and code actions within your IDE, perform the following the setup steps:

1. Depend on any ```sidecar``` lint packages such as ```design_system_lints```.

```yaml
dev_dependencies:
  design_system_lints: ^0.1.0-dev.1
```

2. Create a ```sidecar.yaml``` file at the project's root directory and declare any or all lints from the lint package.

```yaml
# sidecar.yaml
includes:
  - "bin/**"
  - "lib/**"
lints:
  design_system_lints:
    avoid_sized_box_height_width_literals:
    avoid_text_style_literal:
    avoid_border_radius_literal:
    avoid_box_shadow_literal:
    avoid_edge_insets_literal:
```

3. Enable the ```sidecar``` plugin to run, by adding it to the list of plugins in ```analysis_options.yaml```.


```yaml
analyzer:
  plugins:
    - sidecar
```

After several seconds of start-up (and potentially a restart of your IDE), the lints should begin appearing in your editor.
### CLI Mode

CLI Mode is useful for running lint rules from a CI/CD pipeline. To use Sidecar in CLI mode, run the following command in your terminal:

```sh
sidecar analyze
```

### Debug Mode

Debug Mode comes equipped with IDE debugger integration and hot reload, which is helpful for when you're developing your own lints. Currently, this functionality is a work-in-progress.

To enable debug mode, run:

```sh
sidecar analyze --debug
```

## Architecture

In comparison to the ```analyzer_plugin``` package, what makes Sidecar extremely powerful is that lints from any number of packages are designed to work together within one isolate / process. This means that they share RAM and CPU resources, which means each directory should only be analyzed once, resulting in Dart-tier performance. Therefore, Sidecar enables developers to utilize diverse collections of IDE tools, with the performance that is expected of the entire Dart toolchain.

The notable ways that Sidecar accomplishes this architecture is by doing the following:

1. When ```sidecar``` is enabled in ```analysis_options.yaml```, a "middleman" plugin is booted up from the transitive ```sidecar``` package dependency, which checks the root package's dependency graph for all packages that both a) depend on ```sidecar``` and b) define ```LintRules``` (more on what this means later).

2. The middleman plugin generates a series of files within ```.dart_tool/sidecar``` at the root directory. This includes a concatenation of all of the ```LintRules``` found from process 1.

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

3. Once the files are generated, the middleman plugin then launches an isolate from this executable, which launches the Sidecar analyzer plugin together with the array of ```LintRules```. This step is required, because in order to run all lint packages within one isolate, we need to dynamically aggregate the multiple packages into one single ```main()``` function.

4. The middleman plugin passes all requests (lint, quick assist, etc.) to/from the IDE & analysis server to the Sidecar analyzer plugin where the requests are then processed.

Additional notes:

- Both the middleman plugin and the Sidecar analyzer plugin utilize the same package_config.json as the root project - this gaurantees that, as long as ```pub get``` resolves for the root project, so will all of the lints regardless of the dependencies that they're analyzing


## Proposal: Analyzer Ecosystem

While the current Analyzer "ecosystem" comprises of not much more than a few projects (```dart_custom_metrics``` and ```custom_lints```, to name a few), the trends of the Dart ecosystem - in terms of popularity, and hyperfocus on toolchains (re: metaprogramming) - will lower the barrier of entry for developers to be "more in control" of their IDE and developer experience. This is where Sidecar thinks it can help as well.

In order for the community to really flourish, the APIs behind defining LintRules and code edits need be as intutive as possible. Therefore, the biggest recommendation is: for package maintainers to offer a number of lint-based utilities for the community to used. 

- TODO: explain role of utility packages, like ```flutter_analyzer_utils```
- 


## Next Steps

- TODO: Roadmap
- TODO: Contributions / ways others can help by giving feedback on their use cases


## Feature Overview

### creating lint rules

- define a default severity for a lint
- documentation URLs in lint IDE window
- SidecarAstVisitor for simpler lint reporting (AstNodes and Tokens)

### creating code edits

- TODO: quick fixes for lints
- TODO: code assists
- TODO: code completion

### ```sidecar.yaml``` configuration

- define package or lint-specific includes paths
- explicitly enable or disable a lint
- override a rule's default severity
- TODO: rule configurations and configuration errors


### cli

- output report of entire codebase
- TODO: output different formats

### benchmarks and testing

- TODO: Register visitors for better analysis performance
- TODO: lint unit test tools
- TODO: how can we benchmark against Dart official analysis server?
### extras
- TODO: ignore statements
- TODO: Import inheritance
- TODO: Multi-Import inheritence