## 0.1.0-dev.20

- fix: Test suite path fix for Windows

## 0.1.0-dev.19

- feat: Windows support
- feat: Test utilities for rule integration tests
- feat: LintRule and AssistRule types 
- docs: Work-in-progress documentation and tutorials at sidecaranalyzer.dev

## 0.1.0-dev.18

- feat: TypeChecker API removed
- feat: exporting sidecar_package_utilities


## 0.1.0-dev.17

- feat: TypeChecker API exposed

## 0.1.0-dev.16

- docs: Updated Readme documents and links to how-to guides

## 0.1.0-dev.15

- breaking: RuleCode url changed from Uri to String
- docs: Re-arranged internal API structures
- docs: Starter APIs are public.

## 0.1.0-dev.14

- fix: Local absolute paths replaced by dynamic paths
- feat: Linux environment functionality confirmed

## 0.1.0-dev.13

- fix: Removed local dependency from tools/analyzer_plugin package
- docs: Improved readme tables, fixed image screenshot

## 0.1.0-dev.12

- docs: Added feature overview to readme
- docs: Fixed broken lint image
- docs: Improved examples in Readme

## 0.1.0-dev.11

- fix: Lint performance improvements to reduce latency while editing code


## 0.1.0-dev.10

- fix: Moved Riverpod dependency to 2.0.0.

## 0.1.0-dev.9

- docs: Documentation added to some public APIs
- refactor: Removed static analysis errors to improve pub score.

## 0.1.0-dev.8

- docs: Documentation added to some public APIs
- refactor: Removed static analysis errors to improve pub score.

## 0.1.0-dev.7
- feat: Assists, QuickFix
- feat: sidecar.yaml configuration warnings appear in real-time
- feat: sidecar.yaml changes affect visible lints on file save

## 0.1.0-dev.6
- feat: New API with Visitor-based rules
- tests: 15% test coverage
- fix: Performance improvements, ~10s for ```sidecar analyze```

## 0.1.0-dev.5

- feat: quick fixes
- feat: quick assists
- fix: Memory leak due to duplicated isolates following ```pub get```
- docs: added example.md to show how to enable plugin

## 0.1.0-dev.4

- fix: Verbose log removed from CLI output
- fix: Align error type in CLI output

## 0.1.0-dev.3

- fix: Missing import file, Sidecar CLI could not access hidden PackageGenerator in packages/ folder

## 0.1.0-dev.2

- improved API: LintRule now accepts a LintVisitor mixin
- fix: Issue where files were only being analyzed on save
- fix: Lints are refreshed when ```sidecar.yaml``` is modified and saved

## 0.1.0-dev.1

- Initial prototype version.
