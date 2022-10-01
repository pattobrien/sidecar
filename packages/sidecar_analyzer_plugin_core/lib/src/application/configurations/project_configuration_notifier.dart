// import 'package:analyzer/dart/analysis/context_root.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar_analyzer_plugin_core/src/application/configurations/project_configuration_state.dart';

// class ProjectConfigurationNotifier
//     extends StateNotifier<AsyncValue<ProjectConfigurationState>> {
//   ProjectConfigurationNotifier(this.root) : super(AsyncValue.loading());

//   final ContextRoot root;

//   Future<void> getProjectConfiguration() async {
//     //
//   }
// }

// final projectConfigurationNotiferProvider = StateNotifierProvider.family<
//     ProjectConfigurationNotifier,
//     AsyncValue<ProjectConfigurationState>,
//     ContextRoot>((ref, root) {
//   return ProjectConfigurationNotifier(root);
// });
