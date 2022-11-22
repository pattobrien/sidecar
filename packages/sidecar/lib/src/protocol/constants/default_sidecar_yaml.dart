const defaultSidecarContent = '''

# generated sidecar.yaml configuration

includes:
  - "bin/**"
  - "lib/**"

lints:
  # the first level is the lint package name
  design_system_lints:
    # second level is the lint rule's id
    avoid_icon_literal:
      # each lint rule is enabled by default, but you can explicitly
      # enable it or disable it
      enabled: false
    avoid_sized_box_height_width_literals:
      # each rule defines its own severity, but users can override
      # the severity level 
      severity: warning
    avoid_text_style_literal:
    avoid_border_radius_literal:
    avoid_box_shadow_literal:
    avoid_edge_insets_literal:

''';
