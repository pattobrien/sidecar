---
sidebar_position: 4
description: What to do when lints no longer update, RAM usage, etc.
---

# Troubleshooting

In IDE-Server mode, Sidecar boots up using the ```analyzer_plugin``` APIs created by the Dart team. 
Due to the experimental nature of both Sidecar and analyzer_plugin, there are some limitations that users should be aware of.

## Lints stop updating

When using a lint package, its possible that you experience unexpected problems, such as:

- A particular file does not show lints
- Lints stop updating or are seen appearing over the wrong code

While the remaining bugs are being ironed out, the recommended fix is to restart the analyzer server and/or restart your IDE
(can be done via Dart official extensions).
## Increased RAM resources

Since the official Dart lints do not themselves use the analyzer_plugin architecture,
they are run on a separate isolate than Sidecar rules. Because both Dart programs must analyze the entire
Dart package and dependencies, enabling Sidecar is expected to have some increase in RAM resources
(expect around 25% increase, but no more than a 50% increase).

