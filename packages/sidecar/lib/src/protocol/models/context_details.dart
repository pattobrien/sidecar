import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'context_details.freezed.dart';
part 'context_details.g.dart';

@freezed
class ContextDetails with _$ContextDetails {
  const factory ContextDetails({
    required List<Uri> includesPaths,
    List<Uri>? excludesPaths,
    Uri? optionsFile,
    Uri? packagesFile,
  }) = _ContextPath;
  const ContextDetails._();

  factory ContextDetails.fromJson(Map<String, dynamic> json) =>
      _$ContextDetailsFromJson(json);
}

extension ContextPathFromRoot on ContextDetails {
  ContextRoot toContextRoot(ResourceProvider resourceProvider) {
    final contextLocator = ContextLocator(resourceProvider: resourceProvider);
    final context = contextLocator.locateRoots(
      includedPaths: includesPaths.map((e) => e.path).toList(),
      excludedPaths: excludesPaths?.map((e) => e.path).toList(),
      optionsFile: optionsFile?.path,
      packagesFile: packagesFile?.path,
    );
    return context.single;
  }
}
