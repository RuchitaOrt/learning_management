import 'package:flutter/cupertino.dart';

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

class Qualification {
  final int id;
  final String qualificationName;
  final bool isActive;

  Qualification({
    required this.id,
    required this.qualificationName,
    required this.isActive,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    try {
      return Qualification(
        id: json['id'] as int? ?? -1,
        qualificationName: json['qualification_name'] as String? ?? 'Unknown',
        isActive: json['isActive'] as bool? ?? false,
      );
    } catch (e) {
      print('Error creating Qualification: $e');
      return Qualification(
        id: -1,
        qualificationName: 'Invalid',
        isActive: false,
      );
    }
  }
}

class QualificationListResponse {
  final int n;
  final String msg;
  final List<Qualification> data;

  QualificationListResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory QualificationListResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Safely handle null or missing data
      final dataList = json['data'] as List? ?? [];

      List<Qualification> qualifications = dataList.map((item) {
        try {
          return Qualification.fromJson(item as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing qualification item: $e');
          return Qualification(
            id: -1,
            qualificationName: 'Invalid',
            isActive: false,
          );
        }
      }).where((q) => q.id != -1).toList(); // Filter out invalid entries

      return QualificationListResponse(
        n: json['n'] ?? 0,
        msg: json['msg'] ?? '',
        data: qualifications,
      );
    } catch (e) {
      print('Error parsing QualificationListResponse: $e');
      return QualificationListResponse(
        n: 0,
        msg: 'Parse error',
        data: [],
      );
    }
  }
}

class Document {
  final int id;
  final String documentName;
  final String? description;
  final bool isActive;
  final String? uploadedProof;

  Document({
    required this.id,
    required this.documentName,
    this.description,
    required this.isActive,
    this.uploadedProof,
  });

  /*factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      documentName: json['document_name'],
      description: json['description'],
      isActive: json['isActive'] ?? false,
      uploadedProof: json['uploaded_proof'],
    );
  }*/
  factory Document.fromJson(Map<String, dynamic> json) {
    try {
      return Document(
        id: json['id'] as int? ?? 0,
        documentName: (json['document_name'] as String?)?.trim() ?? 'Unnamed Document',
        description: json['description'] as String?,
        isActive: json['isActive'] as bool? ?? false,
        uploadedProof: json['uploaded_proof'] as String?,
      );
    } catch (e) {
      debugPrint('Document parsing error for JSON: $json');
      rethrow;
    }
  }
}

class DocumentListResponse {
  final int n;
  final String msg;
  final List<Document> data;

  DocumentListResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory DocumentListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Document> documents = list.map((i) => Document.fromJson(i)).toList();

    return DocumentListResponse(
      n: json['n'],
      msg: json['msg'],
      data: documents,
    );
  }
}
