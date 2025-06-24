import 'dart:convert';

CommonResponse logoutResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

String logoutResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  final int n;
  final String msg;
  final List<dynamic> data;

  CommonResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] is List ? json['data'] : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'n': n,
    'msg': msg,
    'data': data,
  };
}
