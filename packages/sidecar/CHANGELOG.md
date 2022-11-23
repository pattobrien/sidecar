
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
