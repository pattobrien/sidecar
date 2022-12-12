# Lint Versioning

## Dependency Resolution

Each instance of Sidecar Analyzer is generated and executed using the ```package_config.json``` of the Target Package under analysis, so that we are able to rely on ```pub``` to handle all dependency versioning. This was considered an extremely important UX decision, so that rule packages would follow the same requirements as all ```pub``` packages, rather than having Sidecar packages require their own workflows that developers would have to learn. Instead, as long as ```flutter pub get``` or ```dart pub get``` successfully resolve, then the analyzer will be able to run.


## Analyzing Target Package Dependencies

- TODO: this is a non-ideal example; a better example would be a class that subtly changes between releases

To visualize what this section is referring to, consider that the ```Notifier``` class was introduced for the first time in ```package:riverpod``` v2.0.0, and imagine that we are writing a Lint Rule to ensure that implementations of this class are properly written by developers.

Since the Sidecar architecture involves a communication protocol that decouples the Sidecar Analyzer process from the Target Package under analysis, it's ***technically possible*** for Rules to be written for multiple package versions. However, at this moment this is discouraged, as it's assumed that any benefits of doing so would not outweigh the huge burden of both writing and maintaining such version logic within rules.

For example, we can use conditions to check if an AstNode is 'Notifier':

```dart
class NotifierIsNotFinal extends Rule with Lint {
  ...
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    
    if (node.staticType.toString() == 'Notifier') {
        // handle Notifier linting
    }
  }
}

```


### What about previous Riverpod package versions? Are those users out of luck?

Packages are intended to be forward looking, but its understandable that users of older packages would also gain a lot of benefit from Sidecar. There are two considerations that help make this possible:

- ```pub``` allows package authors to publish a version that is less than the current version. so if Riverpod wanted to add lints for versions ```>= 1.0.0 <2.0.0```, then a new 1.X.X version could be published with Sidecar rules included
- A separate ```rule_utilities``` package could be published for your package, to decouple Ecosystem Package utilties