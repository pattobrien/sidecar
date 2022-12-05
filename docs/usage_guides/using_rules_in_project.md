
# Using Sidecar within a Dart or Flutter Project  <a name="development-usage"></a>

There are 3 modes which Sidecar can be run in: server, cli, or debug (WIP).
## IDE Server Mode <a name="server-usage"></a>

In Server mode, Sidecar boots up using the ```analyzer_plugin``` APIs created by the Dart team. To enable Sidecar to display lints and assist recommendations within your IDE, perform the following setup steps:

1. Depend on any ```sidecar``` lint packages (e.g. [design_system_lints](https://pub.dev/packages/design_system_lints))

2. Create a ```sidecar.yaml``` file at the project's root directory and declare any rules from the package

```yaml
# sidecar.yaml
includes:
  - "bin/**.dart"
  - "lib/**.dart"
lints:
  design_system_lints:
    rules: 
      avoid_sized_box_height_width_literals:
      avoid_text_style_literal:
      avoid_border_radius_literal:
      avoid_box_shadow_literal:
      avoid_edge_insets_literal:
```

3. Enable the plugin to run by adding ```sidecar``` to the list of plugins in ```analysis_options.yaml```


```yaml
# analysis_options.yaml

analyzer:
  plugins:
    - sidecar
```

After several seconds of start-up (and potentially a restart of your IDE), the lints should begin appearing in your editor.
## CLI Mode <a name="cli-usage"></a>

CLI Mode is useful for running lint rules from a CI/CD pipeline. To use Sidecar in CLI mode, run the following command in your terminal:

```sh
# activate sidecar
dart pub global activate sidecar

# run sidecar analyzer in CLI mode
sidecar analyze
```

> NOTE: If you have a particular CLI use case in mind and would like to give feedback, feel free to reach out on Github.

## Debug Mode (Work in Progress) <a name="debug-usage"></a>

Debug Mode comes equipped with IDE debugger integration and hot reload, which is helpful for when you're developing your own rules. Currently, this functionality is a work-in-progress.