Table of Contents


- Motivations
- Getting Started
- Architecture
- Next steps


# Getting Started


## Installing Sidecar CLI 

Install ```sidecar``` as a global dart executable:

```sh
dart pub global activate --source path <path/to/sidecar_cli/root/>
```

## Using Sidecar on a Dart Project

There are 3 modes which Sidecar can be run in.

### Plugin Mode

1. Open the example project, create a new Dart project, or open a Dart project of your own that you'd like to be analyzed.
2. In the root project directory, run ```sidecar init``` to install sidecar_analyzer_plugin to the project directory.
3. Add lints to the project's ```analysis_config.yaml``` file and save the file. The command ```sidecar rebuild``` should be run automatically on save.


```yaml
# Example analysis_config.yaml file

analyzer:
  plugins:
    - sidecar_analyzer_plugin

sidecar:
  lints:
    l10n_lints:
      avoid_string_literals:
```
### CLI Mode

CLI Mode is useful for running lint rules from a CI/CD pipeline. To use the CLI mode, run:

```sidecar analyze```

### Debug Mode

Debug Mode comes equipped with IDE debugger integration and hot reload, which is helpful for when you're developing your own lints.

To enable debug mode, run:

```sidecar analyze --debug```

