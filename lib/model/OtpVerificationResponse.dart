import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) =>
    OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) =>
    json.encode(data.toJson());

class OtpVerificationResponse {
  final int n;
  final String msg;
  final Map<String, dynamic> data;

  OtpVerificationResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] is Map<String, dynamic>
          ? json['data']
          : <String, dynamic>{},
    );
  }

  Map<String, dynamic> toJson() => {
        "n": n,
        "msg": msg,
        "data": data,
      };
}
