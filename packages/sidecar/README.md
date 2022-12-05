

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
- [CLI Installation](#cli-installation)
- [Usage](#usage)
  - [Creating a Rule](#create-a-rule)
  - [Using a rule in your Codebase](#using-a-rule)
- [Example Sidecar Rule Packages](#example-packages)
- [Contributing](#contributing)


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


### Usage <a name="usage"></a>

See the below guides for information on how to create and use Sidecar packages.

- [Creating a Rule](https://github.com/pattobrien/sidecar/blob/master/docs/usage_guides/creating_a_rule.md) <a name="create-a-rule"></a>
- [Using Sidecar rules to analyze a Codebase](https://github.com/pattobrien/sidecar/blob/master/docs/usage_guides/using_rules_in_project.md) <a name="using-a-rule"></a>

## Example Sidecar Rule Packages <a name="example-packages"></a>

To explore how rule packages are created or to use them to work on your codebase, take a look at the following rule packages:

- [design_system_lints](https://pub.dev/packages/design_system_lints)
- [dart_lints](https://pub.dev/packages/dart_lints) - Sidecar port of the official Dart lints, for benchmarking purposes


## Installing the CLI tool <a name="cli-installation"></a>

Some Sidecar tasks are easier with the CLI tool. To install the CLI, simply run:

```sh
dart pub global activate sidecar
```


## Contributing <a name="contributing"></a>

Suggestions or feature requests would be highly appreciated at this point in the development process, so that as many development use cases can be accounted for as possible. It's encouraged to reach out or open a Github issue against the Sidecar repository.
