# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2022-09-12

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sidecar` - `v0.1.8`](#sidecar---v018)
 - [`sidecar_analyzer_plugin` - `v0.1.8`](#sidecar_analyzer_plugin---v018)
 - [`sidecar_analyzer_plugin_core` - `v0.1.8`](#sidecar_analyzer_plugin_core---v018)

---

#### `sidecar` - `v0.1.8`

 - **REFACTOR**: Cleaning up files.
 - **REFACTOR**: Separated cli executable into init and rebuild commands.
 - **REFACTOR**: Move configuration models into sidecar core package.
 - **REFACTOR**: Cleaned up PackageConfiguration parsing.
 - **REFACTOR**: Renaming core classes.
 - **REFACTOR**: Move lint hosting from localhost to digital ocean app.
 - **REFACTOR**: Clean up imports in sidecar package.
 - **REFACTOR**: Slight lint refactors, utilities refactor.
 - **REFACTOR**: Separate analyzer plugin starter package.
 - **REFACTOR**: ReportedLintError provides an AstNode.
 - **REFACTOR**: Source code utilities pubspec overrides.
 - **FIX**: Lint configuration yaml.
 - **FIX**: CodeEdit optional configuration in yaml file.
 - **FIX**: Remove id parameter from CodeEdit.
 - **FIX**: Plugin errors due to re-initializing pluginBootstrap.
 - **FIX**: LintServerity defined by LintError classes.
 - **FEAT**: Lint/Edit plugin package yaml declarations.
 - **FEAT**: Root utilities.
 - **FEAT**: Create edit configuration for project config.
 - **FEAT**: Separated utilities packages.
 - **FEAT**: Lints operate via namespaces and packages.
 - **FEAT**: Sidecar analyzer plugin core.
 - **FEAT**: Use version number as base for .sidecar copied plugin source code.
 - **FEAT**: LintError yaml configurations.
 - **FEAT**: Flutter lints, optional lint/edit configurations.
 - **FEAT**: cli inserts lints/fixes as explicit dependencies of project plugin.
 - **FEAT**: v0.1.0-dev.3.
 - **FEAT**: Lint/Edit configuration awareness.
 - **FEAT**: v0.1.0-dev.2.
 - **FEAT**: Sidecar v0.1.0-dev.1 released to cloudsmith.
 - **FEAT**: v0.1.0-dev.5.
 - **FEAT**: Code Edit bootstrapper.
 - **FEAT**: Code edit class.
 - **FEAT**: SidecarOptions via analysis context.
 - **FEAT**: Separated highlighted AstNode from reported AstNode.
 - **FEAT**: Create route QuickAssist via Class Declaration.
 - **FEAT**: JsonDecode based configurations.

#### `sidecar_analyzer_plugin` - `v0.1.8`

 - **REFACTOR**: Cleaning up files.
 - **REFACTOR**: Renaming core classes.
 - **REFACTOR**: Separate analyzer plugin starter package.
 - **REFACTOR**: Move lint hosting from localhost to digital ocean app.
 - **REFACTOR**: Git ignore lock files.
 - **REFACTOR**: ReportedLintError provides an AstNode.
 - **REFACTOR**: Source code utilities pubspec overrides.
 - **FIX**: Lint configuration yaml.
 - **FIX**: Code edit configuration change adds code edit to plugin pubspec.
 - **FIX**: Code edits not reported for certain AstNodes.
 - **FIX**: Updated project to support sidecar v0.1.7.
 - **FIX**: LintServerity defined by LintError classes.
 - **FIX**: Plugin errors due to re-initializing pluginBootstrap.
 - **FIX**: Plugin moved to .sidecar folder in root directory.
 - **FIX**: Support for Flutter projects via flutter pub get.
 - **FIX**: Sidecar only analyzes files in root directory that match the includes globs in options file.
 - **FEAT**: Code Edit bootstrapper.
 - **FEAT**: v0.1.0-dev.5.
 - **FEAT**: cli inserts lints/fixes as explicit dependencies of project plugin.
 - **FEAT**: v0.1.0-dev.3.
 - **FEAT**: Lint/Edit configuration awareness.
 - **FEAT**: Sidecar analyzer plugin core.
 - **FEAT**: Flutter lints, optional lint/edit configurations.
 - **FEAT**: v0.1.0-dev.2.
 - **FEAT**: JsonDecode based configurations.
 - **FEAT**: Sidecar v0.1.0-dev.1 released to cloudsmith.
 - **FEAT**: Separated highlighted AstNode from reported AstNode.
 - **FEAT**: Create route QuickAssist via Class Declaration.
 - **FEAT**: Code edit class.
 - **FEAT**: Separated utilities packages.
 - **FEAT**: SidecarOptions via analysis context.
 - **FEAT**: Use version number as base for .sidecar copied plugin source code.
 - **FEAT**: LintError yaml configurations.
 - **FEAT**: (Preliminary) Create project-specific lint repository.

#### `sidecar_analyzer_plugin_core` - `v0.1.8`

 - **REFACTOR**: Renaming core classes.
 - **FIX**: Lint configuration yaml.
 - **FEAT**: Flutter lints, optional lint/edit configurations.
 - **FEAT**: Sidecar analyzer plugin core.

