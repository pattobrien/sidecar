


## Sidecar Analyzer

*Enable a more personalized developer experience within the IDE.*


<img src="../../docs/ide_screenshot.png" alt="sidecar lint in IDE" width="600"/>

<a href="https://github.com/pattobrien/sidecar/actions"><img src="https://github.com/pattobrien/sidecar/workflows/Build/badge.svg" alt="Build Status"></a>
<a href="https://codecov.io/gh/pattobrien/sidecar"><img src="https://codecov.io/gh/pattobrien/sidecar/branch/master/graph/badge.svg" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
[![pub package](https://img.shields.io/pub/v/sidecar.svg)](https://pub.dev/packages/sidecar)


> This is an experimental package which is expected to change slightly (but frequently) until an official 0.1.0 release. However, the core architecture of Sidecar has been designed around the official ```package:analyzer```, and therefore any rule packages you may want to experiment with will be easy to port over to any updated APIs.



## Motivation

Dart lints are incredibly useful for keeping a codebase clean and tidy, but code analysis use cases don't need to end at official rules. What if we could use these same tools to enforce highly-opinionated rules for a particular package ecosystem (BloC vs Riverpod) or for a particular app?

The goal of Sidecar is to enable a more personalized developer experience by allowing quick and easy access to the core lint and code assist tools of modern IDEs.

### Example Sidecar Rule Packages

To explore how rule packages are created, take a look at the following rule packages:

- [design_system_lints](https://pub.dev/packages/design_system_lints)
- [dart_lints](https://pub.dev/packages/dart_lints) - Sidecar port of the official Dart lints, for benchmarking purposes

## Creating a Rule

Below is an example of a Lint rule which highlights any strings within a Dart app.

```dart
// avoid_string_literals.dart

class AvoidStringLiterals extends Rule with Lint {
  @override
  LintCode get code => 
    LintCode('avoid_string_literals', package: 'intl_lints', url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitStringLiteral(StringLiteral node) {
    reportAstNode(node,
        message: 'Avoid any hardcoded Strings.',
        correction: 'Use an intl message instead.');
  }
}

```

Note the following features and requirements:


### SidecarAstVisitor
- Every Sidecar Rule should extend ```Rule``` and mixin either ```Lint``` or ```Assist```
- All overridden visit methods should be added to the NodeRegistry via the ```initializeVisitor``` method
- Lint rules expose methods ```reportAstNode``` and ```reportToken```, which take a lint message and an optional correction message to display to a user
- A QuickFix mixin can also be added to a Lint mixin, which exposes a parameter ```editsComputer``` on the function ```reportAstNode```
- SidecarAstVisitor base class also exposes other fields, such as ```unit``` ( ResolvedUnitResult that is currently being analyzed)


### RuleCode
- A RuleCode is the ID of every unique Sidecar Rule
- The ID of a RuleCode (e.g. ```avoid_string_literals```) should be in snake_case format and should match the class name (in PascalCase)
- The Package ID of a RuleCode should be identical to the package name
- A URL can be added to the LintCode, which would then appear as a hyperlink in an IDE's lint window


### Rule Packages

- Sidecar rule packages can contain 1 or more rules
- For a given package 'intl_lints', all rules must be accessible from the file ```lib/intl_lints.dart``` (either directly or via exports)
- pubspec.yaml should also declare any rules

```yaml
package: intl_lints
...

sidecar:
  lints:
    - avoid_string_literals # should match the Lint's RuleCode ID
```

> NOTE: some of the above API details, like the initializeVisitor method that must be overridden for each Rule, are complicated or redundant; our intention over time is to reduce as much redundancy as possible in order to make rule creation as straightforward as possible. If you have any feedback for how you'd like the APIs to look, we encourage you to open an issue against Sidecar on github.

## Installing the CLI tool

Some Sidecar tasks are easier with the CLI tool. To install, simply run:

```sh
dart pub global activate sidecar
```

## Using Sidecar within a Dart or Flutter Project

There are 3 modes which Sidecar can be run in: server, cli, or debug (WIP).
### Dart Server + Analyzer Plugin Mode

The Dart team maintains analysis servers that run in IDEs like VSCode. In Server mode, Sidecar boots up using the ```analyzer_plugin``` APIs created by the Dart team. 

To enable Sidecar to display lints and assist recommendations within your IDE, perform the following setup steps:

1. Depend on any ```sidecar``` lint packages such as ```design_system_lints```

2. Create a ```sidecar.yaml``` file at the project's root directory and declare any or all lints from the lint package

```yaml
# sidecar.yaml
includes:
  - "bin/**"
  - "lib/**"
lints:
  design_system_lints:
    rules: 
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
# activate sidecar
dart pub global activate sidecar

# run sidecar analyzer in CLI mode
sidecar analyze
```

> NOTE: If you have a particular CLI use case in mind and would like to give feedback, feel free to reach out on Github.

### Debug Mode (Work in Progress)

Debug Mode comes equipped with IDE debugger integration and hot reload, which is helpful for when you're developing your own rules. Currently, this functionality is a work-in-progress.

- TODO


## Next Steps

- TODO: Roadmap
- TODO: Contributions / ways others can help by giving feedback on their use cases


## Feature Overview

### creating lint rules

- define a default severity for a lint
- documentation URLs in lint IDE window
- SidecarAstVisitor for simpler lint reporting (AstNodes and Tokens)
- TODO: ignore statements

### rules with code changes

- quick fixes for lints
- code assists
- TODO: code completion

### ```sidecar.yaml``` configuration

- define package or lint-specific includes paths
- explicitly enable or disable a lint
- override a rule's default severity
- lints update on ```sidecar.yaml``` changes, without plugin needing to restart

### cli

- output report of entire codebase
- TODO: output to different formats (e.g. csv)
- TODO: capture project metrics

### rule configurations
- TODO: allow rules to declare configurations
- TODO: display rule configuration errors in ```sidecar.yaml``` file
- TODO: rule annotations


### benchmarks and testing

- DONE: fix memory leaks
- TODO: Register visitors for better analysis performance
- TODO: lint unit test toolchain
- TODO: how can we benchmark against Dart official analysis server?
- TODO: cli takes ~12 seconds to complete

### extra features
- TODO: import inheritance
- TODO: multi-import inheritence
