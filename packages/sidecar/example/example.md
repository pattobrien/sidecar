# Getting Started

## Sidecar CLI
Some tasks are easier with the CLI tool. To install, simply run:

```sh
dart pub global activate sidecar
```

## Using Sidecar in Server mode

To enable Sidecar to display lints and code actions within your IDE, perform the following the setup steps:

1. Depend on any ```sidecar``` lint packages such as ```design_system_lints```.

```yaml
dev_dependencies:
  design_system_lints: ^0.1.0-dev.1
```

2. Create a ```sidecar.yaml``` file at the project's root directory and declare any or all lints from the lint package.

```yaml
# sidecar.yaml
# this file can also be created via the cli: 'sidecar init'
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

3. Enable the ```sidecar``` plugin to run, by adding it to the list of plugins in ```analysis_options.yaml```.


```yaml
analyzer:
  plugins:
    - sidecar
```

After several seconds of start-up (and potentially a restart of your IDE), the lints should begin appearing in your editor.