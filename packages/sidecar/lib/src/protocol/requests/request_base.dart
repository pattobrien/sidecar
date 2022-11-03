// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:uuid/uuid.dart';

// import '../../../sidecar.dart';

// part 'request_base.g.dart';

// @JsonSerializable()
// class RequestWrapper {
//   const RequestWrapper(this.id, this.base);

//   factory RequestWrapper.fromJson(Map<String, dynamic> json) =>
//       _$RequestWrapperFromJson(json);

//   final RequestBase base;
//   final String id;

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'id': id,
//         'method': base.method,
//         'params': base.toJson(),
//       };
// }

// @JsonSerializable()
// class RequestBase {
//   const RequestBase();
//   factory RequestBase.fromJson(Map<String, dynamic> json) {
//     print('method: ${json}');
//     switch (json['method'] as String) {
//       case kSetContextCollectionMethod:
//         return SetContextCollectionRequest.fromJson(json);
//       default:
//         throw UnimplementedError();
//     }
//   }
//   String get method => 'request';
//   Map<String, dynamic> toJson() => <String, dynamic>{};
//   RequestWrapper toSidecarRequest() => RequestWrapper(const Uuid().v4(), this);
// }
