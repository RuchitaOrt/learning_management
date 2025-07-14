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

class StateModel {
  final int id;
  final String name;
  final String? countryCode;
  final String? stateCode;
  final String? iso2;
  final String? latitude;
  final String? longitude;
  final String? createdAt;
  final int? country;

  StateModel({
    required this.id,
    required this.name,
    this.countryCode,
    this.stateCode,
    this.iso2,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.country,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
      countryCode: json['country_code'],
      stateCode: json['state_code'],
      iso2: json['iso2'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
      country: json['country'],
    );
  }
}

class StateResponse {
  final int n;
  final String msg;
  final List<StateModel> data;

  StateResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List)
          .map((item) => StateModel.fromJson(item))
          .toList(),
    );
  }
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

class CommonResponse2 {
  final int n;
  final String msg;
  final dynamic data;

  CommonResponse2({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory CommonResponse2.fromJson(Map<String, dynamic> json) {
    return CommonResponse2(
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
  final bool isEducationDocument;

  Document({
    required this.id,
    required this.documentName,
    this.description,
    required this.isActive,
    this.uploadedProof,
    this.isEducationDocument = false,
  });

  factory Document.fromJson(Map<String, dynamic> json, {bool isEducation = false}) {
    return Document(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      documentName: isEducation
          ? (json['qualification_name'] ?? 'Education Certificate')
          : (json['document_name'] ?? 'Document'),
      description: isEducation
          ? 'Education Certificate'
          : (json['description'] ?? ''),
      isActive: json['isActive'] ?? true,
      uploadedProof: isEducation
          ? json['uploaded_certificate']
          : json['uploaded_proof'],
      isEducationDocument: isEducation,
    );
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
    List<Document> documents = [];

    // proof_data (List)
    if (json['data']?['proof_data'] is List) {
      documents.addAll(
        (json['data']['proof_data'] as List)
            .map((docJson) => Document.fromJson(docJson))
            .toList(),
      );
    }

    // education_document_data (Map)
    if (json['data']?['education_document_data'] is Map) {
      final eduDoc = json['data']['education_document_data'];
      documents.add(Document.fromJson(eduDoc, isEducation: true));
    }

    return DocumentListResponse(
      n: json['n'] ?? 1,
      msg: json['msg'] ?? '',
      data: documents,
    );
  }

/*factory DocumentListResponse.fromJson(Map<String, dynamic> json) {
    List<Document> documents = [];

    // Process proof_data
    if (json['data']?['proof_data'] is List) {
      documents.addAll(
          (json['data']['proof_data'] as List)
              .map((docJson) => Document.fromJson(docJson))
              .toList()
      );
    }

    // Process education_document_data
    if (json['data']?['education_document_data'] is Map) {
      final eduDoc = json['data']['education_document_data'];
      documents.add(Document.fromJson(eduDoc, isEducation: true));
    }

    return DocumentListResponse(
      n: json['n'] ?? 1,
      msg: json['msg'] ?? '',
      data: documents,
    );
  }*/
}
