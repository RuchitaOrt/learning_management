import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool status;
  String message;
  List<Datum> data;
  List<PlanInfo> planInfo;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.planInfo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : [],
    planInfo: json["planInfo"] != null ? List<PlanInfo>.from(json["planInfo"].map((x) => PlanInfo.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "planInfo": List<dynamic>.from(planInfo.map((x) => x.toJson())),
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
