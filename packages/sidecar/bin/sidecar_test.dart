// // ignore_for_file: depend_on_referenced_packages

// import 'package:test/src/runner/browser/platform.dart';
// import 'package:test/src/runner/node/platform.dart';
// import 'package:test_api/src/backend/runtime.dart'; // ignore: implementation_imports
// // ignore: implementation_imports
// import 'package:test_core/src/executable.dart' as executable;
// import 'package:test_core/src/runner/hack_register_platform.dart'; // ignore: implementation_imports
// // import 'package:test/src/runner/wasm/platform.dart';

// void main(List<String> args) async {
//   registerPlatformPlugin([Runtime.nodeJS], () => NodePlatform());
//   registerPlatformPlugin([
//     Runtime.chrome,
//     Runtime.firefox,
//     Runtime.safari,
//     Runtime.internetExplorer
//   ], () => BrowserPlatform.start());
//   // registerPlatformPlugin([
//   //   Runtime.experimentalChromeWasm,
//   // ], () => BrowserWasmPlatform.start());

//   await executable.main(args);
// }
