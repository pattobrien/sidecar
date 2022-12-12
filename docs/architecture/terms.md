# Terms
 
- [Rule](#rule)
- [Rule Package](#rule-package)
- [Active Target](#active-target)
- [Ecosystem Utility Packages](#ecosystem-utility-packages)
- [SidecarOptions (sidecar.yaml)](#sidecar-options)
- [Target Dependencies]
- [Sidecar Analyzer] 


## Rule <a name="rule"></a>

The base class of all Sidecar definitions.

### Lint Rule

- TODO

### QuickAssist Rule

- TODO

## Rule Package<a name="rule-package"></a>

- TODO

## Ecosystem Package <a name="ecosystem-package"></a>

A Dart or Flutter package that is used as a dependency in a codebase. 

For example:
- ```riverpod```
- ```flutter_riverpod```
- ```flutter``` (from sdk)
## Ecosystem Package Utilities <a name="ecosystem-utility-packages"></a>
TODO: rewrite to include the fact that these utilities could be declared within the Ecosystem Package?

A package that includes analyzer utilities like TypeCheckers for ecosystem packages such as Flutter, Riverpod, etc. An example of an Ecosystem Utility Package is ```package:flutter_analyzer_utils```, which exposes typeCheckers for all Types declared in the ```flutter``` sdk.

- TODO: example

## Active Target <a name="active-target"></a>

A Dart package that is under analysis by Sidecar.

- TODO: how to enable a package for Sidecar



## Sidecar Options <a name="sidecar-options"></a>

```sidecar.yaml```