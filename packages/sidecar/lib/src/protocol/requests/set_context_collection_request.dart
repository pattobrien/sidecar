// import 'package:analyzer_plugin/protocol/protocol_generated.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../protocol.dart';

// part 'set_context_collection_request.g.dart';

// @JsonSerializable()
// class SetContextCollectionRequest extends RequestBase {
//   const SetContextCollectionRequest(
//     this.roots,
//   );

//   factory SetContextCollectionRequest.fromJson(Map<String, dynamic> json) =>
//       _$SetContextCollectionRequestFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$SetContextCollectionRequestToJson(this);

//   @override
//   String get method => kSetContextCollectionMethod;

//   final List<String> roots;
// }

// extension AnalysisSetContextRootsParamsX on AnalysisSetContextRootsParams {
//   SetContextCollectionRequest toSidecarRequest() {
//     return SetContextCollectionRequest(
//       roots.map((e) => e.root).toList(),
//     );
//   }
// }
