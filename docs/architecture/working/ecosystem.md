
# Ecosystem Packages (WIP)

## Opportunity 1: Dependency UX

The easiest way to interact with dependencies is to import them directly into your rule code and use types or elements of that package directly.

## Problem: Resolving Flutter dependencies

TODO

One of the remaining architecture questions is that the analyzer is intended to run via ```dart``` executables (i.e. no Flutter dependence), making it rather difficult to write rules that directly import Flutter-based packages. In the current state of Sidecar, if you were to import ```flutter/material.dart``` into your Rule Package, the analyzer would be unable to resolve dependencies due to the absence of the ```dart:ui``` package from the dart-sdk.

There are two possible solutions that can solve this, each with their own pros and cons. 

### Proposal 1: Flutter Meta-Packages

The current implementation of the [```design_system_lints```](https://pub.dev/packages/design_system_lints) package relies on a dependency named [flutter_analyzer_utils](https://pub.dev/packages/flutter_analyzer_utils) to check for Flutter-specific types.

```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

class AvoidBoxShadowLiteral extends Rule with Lint {
  ...
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
     // see: boxShadowType utility
    if (boxShadowType.isAssignableFromType(element?.returnType)) {
      reportAstNode(node, message: message);
    }
  }
}

```

In the above example, ```boxShadowType``` is a utility for matching the type of an ```AstNode``` to the BoxShadow type declared in the ```flutter``` sdk. This utility is required, because importing the ```flutter``` sdk directly will cause a runtime-time error when initializing the Analyzer Isolate, as ```dart:ui``` package can't be located by the analyzer:

```sh
# sidecar analyze

Unhandled exception:
IsolateSpawnException: Unable to spawn isolate: ../../../../fvm/versions/3.0.5/packages/flutter/lib/src/foundation/basic_types.dart:9:1: Error: Not found: 'dart:ui'
export 'dart:ui' show VoidCallback;
^
../../../../fvm/versions/3.0.5/packages/flutter/lib/src/foundation/binding.dart:8:8: Error: Not found: 'dart:ui'
import 'dart:ui' as ui show SingletonFlutterWindow, Brightness, PlatformDispatcher, window;
       ^
../../../../fvm/versions/3.0.5/packages/flutter/lib/src/foundation/debug.dart:5:8: Error: Not found: 'dart:ui'
import 'dart:ui' as ui show Brightness;
       ^
../../../../fvm/versions/3.0.5/packages/flutter/lib/src/foundation/binding.dart:196:3: Error: Type 'ui.SingletonFlutterWindow' not found.
  ui.SingletonFlutterWindow get window => ui.window;
  ^^^^^^^^^^^^^^^^^^^^^^^^^
...
```

- [QUESTION] - is it possible to somehow avoid this issue? Can we somehow manipulate how the URIs of the libraries that are resolved? Or would pointing the Isolate to the DART_SDK within the Flutter SDK solve the issue?

Though the Analyzer breaks when importing a flutter file, ```flutter_analyzer_utils``` package is still able to depend on a particular version of Flutter; therefore, this utility package can be tightly coupled to the package it's meant to reflect. It's also likely possible that these utility classes can be generated dynamically from within the package (e.g. ```flutter/material.dart``` exports annotated with ```@reflected``` will generate a ```flutter.reflected.material.dart``` file that we can then import into our Sidecar Rule definitions)


### Proposal 2: Runtime-Package (WIP)

It may be possible to handle the above logic during runtime, but it would require the following:

- Reflecting the package in question (via ```package:reflectable``` or something similar)
- Access to the Flutter-SDK in order to resolve packages like ```dart:ui```


TODO: what would this look like

## Concerns

- it would be most ideal if rule developers could depend on / import the same libraries that they normally depend on (e.g. import ```package:flutter/material.dart``` to analyze the Material types via some sort of reflection) instead of depending on separate ```flutter_analyzer_utils```  or ```riverpod_analyzer_utils``` packages
- maintenance of analyzer utilities for package creators (e.g. ```flutter``` and```riverpod``` authors) should be as straightforward as possible; ideally, runtime reflection would be possible and there would be no additional packages to depend on or code to maintain
- in the case that runtime-reflection is not possible, using build generators (and eventually static metaprogramming, should it be released) would make this meta-functionality a lot easier for package authors to maintain

## Summary

Maintaining a separate package or even meta-logic is not ideal; however, 
