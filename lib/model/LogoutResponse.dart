import 'dart:convert';

CommonResponse logoutResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

String logoutResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool status;
  String message;

  CommonResponse({
    required this.status,
    required this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
