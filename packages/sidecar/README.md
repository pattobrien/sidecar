

# Sidecar Analyzer

Enable a more personalized developer experience within the IDE.


<img src="https://raw.githubusercontent.com/pattobrien/sidecar/master/docs/example_lint.png" alt="A screenshot of a Sidecar lint popup in an IDE" width="600"/>

<a href="https://github.com/pattobrien/sidecar/actions"><img src="https://github.com/pattobrien/sidecar/workflows/Build/badge.svg" alt="Build Status"></a>
<a href="https://codecov.io/gh/pattobrien/sidecar"><img src="https://codecov.io/gh/pattobrien/sidecar/branch/master/graph/badge.svg" alt="codecov"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
[![pub package](https://img.shields.io/pub/v/sidecar.svg)](https://pub.dev/packages/sidecar)


> This is an experimental package which is expected to change slightly until an official 0.1.0 release. However, the core architecture of Sidecar has been designed around the Dart-official ```package:analyzer``` APIs, and therefore any rule packages you may want to experiment with will be easy to port over to any future APIs.

> Functionality is currently only confirmed to be working on MacOS and Linux environments.

## Overview

- [Motivation](#motivation)
- [Features](#features)
- [Sidecar CLI Installation](#rule-cli-installation-usage)
- [Development Usage](#development-usage)
  - [IDE Server Mode](#server-usage)
  - [CLI Mode](#cli-usage)
  - [Debug Mode](#debug-usage)
- [Example Sidecar Rule Packages](#example-packages)
- [Creating your own Lint and QuickAssist rules](#rule-package-usage)


## Motivation <a name="motivation"></a>

Dart lints are incredibly useful for keeping a codebase clean and tidy, but code analysis use cases don't need to end at official rules. What if we could use these same tools to enforce highly-opinionated rules for a particular package ecosystem (BloC vs Riverpod) or for a particular app?

The goal of Sidecar is to enable a more personalized developer experience by allowing quick and easy access to the core lint and code assist tools of modern IDEs.


## Features <a name="features"></a>

| Lint Rules  | IDE | CLI | Debug |
| ----------  | --- | --- | ----- |
| Lint reason and correction messages | ✅ | ✅ | ✅ | 
| Define a default severity | ✅ | ✅ | ✅ |
| Apply Quick Fix suggestions | ✅ | 🚧 | 🚧 |
| (IDE) URL links to rule documentation | ✅ | 🚫 | 🚫 |
| (CLI) Alternate output formats | 🚫 | 🚧 |  |
| Ignore statements |    |    |    |


| CodeEdit Rules    | IDE | CLI | Debug |
| ----------------- | --- | --- | ----- |
| QuickAssist rules | 🚧  |
| Refactorings (rename, extract, etc.) |  |
| Code Completion |  |  |  |


| Rule Configuration (sidecar.yaml) | IDE | CLI | Debug |
| -------------  | ------ | ------ | ------ |
| Explicitly Enable/Disable rules | ✅ |
| (Lints) Override default severity | ✅ |
| Rule-level include/exclude globs | 🚧 |
| Package-level include/exclude globs | 🚧 |
| Project-level include/exclude globs | 🚧 |
| Customizable rule configurations | |
| Multi-import inheritance | |


|             | MacOS | Linux | Windows |
| ----------  | ----- | ----- | ------- |
| Environment Support  | ✅ | ✅ | 🚧 |


## Example Sidecar Rule Packages <a name="example-packages"></a>

To explore how rule packages are created, take a look at the following rule packages:

- [design_system_lints](https://pub.dev/packages/design_system_lints)
- [dart_lints](https://pub.dev/packages/dart_lints) - Sidecar port of the official Dart lints, for benchmarking purposes

## Using Sidecar within a Dart or Flutter Project  <a name="development-usage"></a>

There are 3 modes which Sidecar can be run in: server, cli, or debug (WIP).
### IDE Server Mode <a name="server-usage"></a>

In Server mode, Sidecar boots up using the ```analyzer_plugin``` APIs created by the Dart team. To enable Sidecar to display lints and assist recommendations within your IDE, perform the following setup steps:

1. Depend on any ```sidecar``` lint packages (e.g. [design_system_lints](https://pub.dev/packages/design_system_lints))

2. Create a ```sidecar.yaml``` file at the project's root directory and declare any rules from the package

```yaml
# sidecar.yaml
includes:
  - "bin/**.dart"
  - "lib/**.dart"
lints:
  design_system_lints:
    rules: 
      avoid_sized_box_height_width_literals:
      avoid_text_style_literal:
      avoid_border_radius_literal:
      avoid_box_shadow_literal:
      avoid_edge_insets_literal:
```

3. Enable the plugin to run by adding ```sidecar``` to the list of plugins in ```analysis_options.yaml```


```yaml
# analysis_options.yaml

analyzer:
  plugins:
    - sidecar
```

After several seconds of start-up (and potentially a restart of your IDE), the lints should begin appearing in your editor.
### CLI Mode <a name="cli-usage"></a>

CLI Mode is useful for running lint rules from a CI/CD pipeline. To use Sidecar in CLI mode, run the following command in your terminal:

```sh
# activate sidecar
dart pub global activate sidecar

# run sidecar analyzer in CLI mode
sidecar analyze
```

> NOTE: If you have a particular CLI use case in mind and would like to give feedback, feel free to reach out on Github.

### Debug Mode (Work in Progress) <a name="debug-usage"></a>

Debug Mode comes equipped with IDE debugger integration and hot reload, which is helpful for when you're developing your own rules. Currently, this functionality is a work-in-progress.


## Creating a Lint or QuickAssist Rule <a name="rule-package-usage"></a>

Below is an example of a Lint rule which highlights any string or string variable referenced from a Text widget.

```dart
//  hardcoded_text_string.dart

const packageId = 'intl_lints';
final kUri = Uri.parse('https://github.com/pattobrien/lints/');

class HardcodedTextString extends Rule with Lint {
  static const _id = 'hardcoded_text_string';
  static const _message = 'Avoid any hardcoded Strings in Text widgets';
  static const _correction = 'Prefer to use a translated Intl message instead.';

  @override
  LintCode get code => LintCode(_id, package: packageId, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (textType.isAssignableFromType(node.staticType)) {
      final textBody = node.argumentList.arguments
          .firstWhere((arg) => arg is! NamedExpression);
      if (textBody is SimpleStringLiteral || textBody is SimpleIdentifier) {
        reportAstNode(textBody, message: _message, correction: _correction);
      }
    }
  }
}

```

Note the following features and requirements:


### Rule Base Class
- All Sidecar rules must extend ```Rule``` as well as mixin either ```Lint``` or ```QuickAssist```
- All overridden visit methods should be added to the NodeRegistry via the ```initializeVisitor``` method (see above example)
- Lint rules expose methods ```reportAstNode``` and ```reportToken```, which take a lint message and an optional correction message to display to a user
- A QuickFix mixin can also be added to a Lint mixin, which exposes an extra parameter ```editsComputer``` on the functions ```reportAstNode``` and ```reportToken```
- The ```Rule``` base class also exposes other fields, for example ```unit``` ( ResolvedUnitResult that is currently being analyzed), ```sidecarSpec```, etc.


### RuleCode
- A RuleCode is the ID of every unique Sidecar Rule
- The ID of a RuleCode (e.g. ```hardcoded_text_string```) should be in snake_case format and should match the class name (in PascalCase)
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
    - hardcoded_text_string # should match the Lint's RuleCode ID
```

> NOTE: some of the above API details, like the initializeVisitor method that must be overridden for each Rule, are complicated or redundant; our intention over time is to reduce as much redundancy as possible in order to make rule creation as straightforward as possible. If you have any feedback for how you'd like the APIs to look, we encourage you to open an issue against Sidecar on github.

## Installing the CLI tool <a name="cli-installation"></a>

Some Sidecar tasks are easier with the CLI tool. To install the CLI, simply run:

```sh
dart pub global activate sidecar
```


## Contributing

Suggestions or feature requests would be highly appreciated at this point in the development process, so that as many development use cases can be accounted for as possible. It's encouraged to reach out or open a Github issue against the Sidecar repository.
