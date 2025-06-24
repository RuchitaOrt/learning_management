class DepartmentListResponse {
  final int n;
  final String msg;
  final List<Department> data;

  DepartmentListResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory DepartmentListResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentListResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List).map((item) => Department.fromJson(item)).toList(),
    );
  }
}

class Department {
  final int id;
  final String departmentName;
  final bool status;

  Department({
    required this.id,
    required this.departmentName,
    required this.status,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      departmentName: json['department_name'],
      status: json['status'],
    );
  }

  @override
  String toString() => departmentName;
}


class CountryListResponse {
  final int n;
  final String msg;
  final List<Country> data;

  CountryListResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List).map((item) => Country.fromJson(item)).toList(),
    );
  }
}

class Country {
  final int id;
  final String name;
  final bool isActive;

  Country({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      isActive: json['isActive'],
    );
  }

  @override
  String toString() => name;
}


class RankListResponse {
  final int n;
  final String msg;
  final List<Rank> data;

  RankListResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory RankListResponse.fromJson(Map<String, dynamic> json) {
    return RankListResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List).map((item) => Rank.fromJson(item)).toList(),
    );
  }
}

class Rank {
  final int id;
  final String rank;
  final String tags;  // Add this field
  final bool isActive;

  Rank({
    required this.id,
    required this.rank,
    required this.tags,  // Add this
    required this.isActive,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      id: json['id'],
      rank: json['rank'],
      tags: json['tags'] ?? '',  // Handle null tags
      isActive: json['isActive'],
    );
  }

  // Helper method to get tags as a list
  List<String> get tagsList {
    return tags.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();
  }

  @override
  String toString() => tags;
}

class CommonResponse {
  final int n;
  final String msg;
  final dynamic data;

  CommonResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'],
    );
  }

  bool get status => n == 1; // Assuming n=1 means success
  String get message => msg;
}

class Candidate {
  final String id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? mobileNumber;

  Candidate({
    required this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.countryCode,
    this.mobileNumber,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'] ?? '',
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      email: json['email'],
      countryCode: json['country_code'],
      mobileNumber: json['mobilenumber']?.toString(),
    );
  }
}
/*
class CommonResponse {
  final int n; // <-- Changed from bool to int
  final String message;
  final String? otp;

  CommonResponse({
    required this.n,
    required this.message,
    this.otp,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      n: json['n'] ?? 0,
      message: json['msg'] ?? '',
      otp: json['otp'],
    );
  }

  // Optional helper
  bool get isSuccess => n == 1;
}*/
