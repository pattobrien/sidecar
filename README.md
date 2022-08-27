

### Getting Started

#### Install ```sidecar_cli``` as a global dart executable

```dart pub global activate --source path <path/to/sidecar_cli/root/>```

#### Use in a project:

1. Create a new dart project or open the example project
2. Run ```sidecar``` to install sidecar_analyzer_plugin to the project directory
3. Add lints to project's config yaml file



```yaml
# Example analysis_config.yaml file

include: package:lints/recommended.yaml

analyzer:
  plugins:
    - sidecar_analyzer_plugin

sidecar_analyzer_plugin:
  rules:
    - id: avoid_string_literals
    # Uncommenting out the following line dynamically enables the lint
    # - id: avoid_stateless_widget
```