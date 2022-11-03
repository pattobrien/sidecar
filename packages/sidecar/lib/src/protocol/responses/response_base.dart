// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../sidecar.dart';

// part 'response_base.g.dart';

// @JsonSerializable()
// class ResponseWrapper {
//   const ResponseWrapper(this.id, this.base);

//   factory ResponseWrapper.fromJson(Map<String, dynamic> json) =>
//       _$ResponseWrapperFromJson(json);

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'id': id,
//         'method': base.method,
//         'params': base.toJson(),
//       };

//   final ResponseBase base;
//   final String id;
// }

// @JsonSerializable()
// class ResponseBase {
//   const ResponseBase();

//   factory ResponseBase.fromJson(Map<String, dynamic> json) =>
//       _$ResponseBaseFromJson(json);

//   Map<String, dynamic> toJson() => <String, dynamic>{};

//   ResponseWrapper toSidecarResponse(String id) => ResponseWrapper(id, this);

//   String get method => 'sidecar.response_base';
// }

// @JsonSerializable()
// class NotificationBase {
//   const NotificationBase(this.method);

//   factory NotificationBase.fromJson(Map<String, dynamic> json) {
//     switch (json['method']) {
//       case kInitializationCompleteMethod:
//         return InitializationComplete.fromJson(json);
//       default:
//         throw UnimplementedError();
//     }
//   }

//   Map<String, dynamic> toJson() => <String, dynamic>{};

//   final String method;
// }

// @JsonSerializable()
// class NotificationWrapper {
//   const NotificationWrapper(this.base);

//   factory NotificationWrapper.fromJson(Map<String, dynamic> json) {
//     return NotificationWrapper(NotificationBase.fromJson(json));
//   }

//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'method': base.method,
//         'base': base.toJson(),
//       };

//   final NotificationBase base;
// }
