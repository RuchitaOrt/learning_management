import 'dart:convert';

/// Top-level function to decode JSON into LoginResponse
LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

/// Top-level function to encode LoginResponse to JSON string
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

/// Main Login Response Model
class LoginResponse {
  final int n;
  final String msg;
  final String token;
  final Datum? userData;
  final PlanInfo? planInfo;

  LoginResponse({
    required this.n,
    required this.msg,
    required this.token,
    this.userData,
    this.planInfo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final dataMap = json['data'];
    return LoginResponse(
      n: json['n'] is int ? json['n'] : 0,
      msg: json['msg']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      userData: dataMap is Map<String, dynamic>
          ? Datum.fromJson(dataMap)
          : null,
      planInfo: dataMap is Map<String, dynamic> && dataMap['plan'] != null
          ? PlanInfo.fromJson(dataMap['plan'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "n": n,
        "msg": msg,
        "token": token,
        "data": userData?.toJson(),
      };
}

/// User details data
class Datum {
  final String id;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool isActive;
  final String? profilePic;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String password;
  final String countryCode;
  final int mobilenumber;
  // Add all other fields as needed...

  Datum({
    required this.id,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.isActive,
    this.profilePic,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.mobilenumber,
    // Initialize all other fields...
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]?.toString() ?? '',
    lastLogin: json["last_login"]?.toString(),
    createdAt: json["createdAt"]?.toString(),
    updatedAt: json["updatedAt"]?.toString(),
    createdBy: json["createdBy"]?.toString(),
    updatedBy: json["updatedBy"]?.toString(),
    isActive: json["isActive"] ?? true,
    profilePic: json["profile_pic"]?.toString(),
    firstName: json["first_name"]?.toString() ?? '',
    middleName: json["middle_name"]?.toString() ?? '',
    lastName: json["last_name"]?.toString() ?? '',
    email: json["email"]?.toString() ?? '',
    password: json["password"]?.toString() ?? '',
    countryCode: json["country_code"]?.toString() ?? '+91',
    mobilenumber: json["mobilenumber"] is int
        ? json["mobilenumber"]
        : int.tryParse(json["mobilenumber"]?.toString() ?? '0') ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "isActive": isActive,
    "profile_pic": profilePic,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "country_code": countryCode,
    "mobilenumber": mobilenumber,
  };
}

/*class Datum {
  final String token;
  final String name;
  final int customerId;

  Datum({
    required this.token,
    required this.name,
    required this.customerId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        token: json["token"]?.toString() ?? '',
        name: json["name"]?.toString() ?? '',
        customerId: json["customer_id"] is int
            ? json["customer_id"]
            : int.tryParse(json["customer_id"]?.toString() ?? '') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "customer_id": customerId,
      };
}*/

/// Plan information data
class PlanInfo {
  final String planName;
  final String planExpireDate;
  final int status;

  PlanInfo({
    required this.planName,
    required this.planExpireDate,
    required this.status,
  });

  factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
        planName: json["plan_Name"]?.toString() ?? '',
        planExpireDate: json["plan_expire_date"]?.toString() ?? '',
        status: json["status"] is int
            ? json["status"]
            : int.tryParse(json["status"]?.toString() ?? '') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "plan_Name": planName,
        "plan_expire_date": planExpireDate,
        "status": status,
      };
}
