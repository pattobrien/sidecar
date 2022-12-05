
# Multi-Target Workspace (WIP)

Even though sidecar is enabled by adding ```sidecar``` to analysis_options.yaml, its typical that we would want multiple Dart packages within our IDE's workspace to be analyzed. 

- TODO: use cases

- You make a refactoring rename to a class in ```counter_protocol``` and you want the change to be reflected in all packages in your open workspace


The question becomes: what is the easiest, most intuitive way to enable sidecar on many packages without explicitly declaring sidecar on every package?

Typical workspace structure for a mobile app:


<!-- <img src="https://raw.githubusercontent.com/pattobrien/sidecar/master/docs/architecture/multi_root_diagram.png" alt="Multi root workspace diagram"/> -->
<img src="multi_root_diagram.png" alt="Multi root workspace diagram"/>


## Default behavior

The default behavior depends on the mode Sidecar is running in:

### Cli Mode

The likely common use case for CLI mode is to be used in CI/CD pipelines.