import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final int n;
  final String msg;
  final String token;
  final Map<String, dynamic> data;

  LoginResponse({
    required this.n,
    required this.msg,
    required this.token,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      token: json['token'] ?? '',
      data: json['data'] is Map ? json['data'] as Map<String, dynamic> : {},
    );
  }

  Map<String, dynamic> toJson() => {
    'n': n,
    'msg': msg,
    'token': token,
    'data': data,
  };
}

class Datum {
  String token;
  String name;
  int customerId;

  Datum({
    required this.token,
    required this.name,
    required this.customerId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    token: json["token"] ?? '',
    name: json["name"] ?? '',
    customerId: json["customer_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "customer_id": customerId,
  };
}

class PlanInfo {
  String planName;
  String planExpireDate;
  int status;

  PlanInfo({
    required this.planName,
    required this.planExpireDate,
    required this.status,
  });

  factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
    planName: json["plan_Name"] ?? '',
    planExpireDate: json["plan_expire_date"] ?? '',
    status: json["status"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "plan_Name": planName,
    "plan_expire_date": planExpireDate,
    "status": status,
  };
}
