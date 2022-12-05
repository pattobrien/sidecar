
# Multi-Root Workspace

Even though sidecar is enabled by adding ```sidecar``` to analysis_options.yaml, its typical that we would want multiple Dart packages within our IDE's workspace to be analyzed. The question becomes: what is the easiest, most intuitive way to enable sidecar on many packages without explicitly declaring sidecar on every package?

Typical workspace structure for a mobile app:

    ```
    my_backend_api
    my_flutter_app
    │   lib
    └───packages
    │   └───my_backend_client
    my_org_assets
    ```

In this example, imagine that my_flutter_app depends on my_backend_client (which is underneath the /packages directory) and my_org_assets (which is outside the directory of my_flutter_app). Furthermore, my_backend_client depends on my_backend_api, making my_backend_api a transitive dependency of our app.

- TODO: complete requirements here


The default behavior depends on the mode Sidecar is running in:

### Cli Mode

The likely common use case for CLI mode is to be used in CI/CD pipelines.