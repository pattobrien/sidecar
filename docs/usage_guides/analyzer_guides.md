# Official Analyzer Guides

For good information on the analyzer ecosystem and APIs, see the following docs:

- Background on ASTNode / Element / Type / Tokens: https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/doc/tutorial/tutorial.md

For good information on the background of ```analyzer_plugin``` and rough guidelines on creating lints, quick assists, etc, see the analyzer_plugin docs:

- https://github.com/dart-lang/sdk/blob/main/pkg/analyzer_plugin/doc/tutorial/tutorial.md

> NOTE: ```package:sidecar``` doesnt use the same APIs as ```analyzer_plugin```, so you should not use these guides to understand the sidecar-specific APIs; rather, use these docs as a good overview on the general direction sidecar is going in.