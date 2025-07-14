class GetCandidateDocuments {
  final int n;
  final String msg;
  final CandidateDocumentsData? data;

  GetCandidateDocuments({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory GetCandidateDocuments.fromJson(Map<String, dynamic> json) {
    return GetCandidateDocuments(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] != null ? CandidateDocumentsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'n': n,
        'msg': msg,
        'data': data,
      };
}
class CandidateDocumentsData {
  final List<EligibilityDocument> eligibilityDocuments;
  final EducationalDocument? educationalDocuments;

  CandidateDocumentsData({
    required this.eligibilityDocuments,
    this.educationalDocuments,
  });

  factory CandidateDocumentsData.fromJson(Map<String, dynamic> json) {
    return CandidateDocumentsData(
      eligibilityDocuments: (json['eligibility_documents'] as List<dynamic>?)
              ?.map((e) => EligibilityDocument.fromJson(e))
              .toList() ??
          [],
      educationalDocuments: json['educational_documents'] != null
          ? EducationalDocument.fromJson(json['educational_documents'])
          : null,
    );
  }
}

class EligibilityDocument {
  final int? id;
  final String? documentName;
  final String? description;
  final bool? isActive;
  final String? uploadedProof;

  EligibilityDocument({
    this.id,
    this.documentName,
    this.description,
    this.isActive,
    this.uploadedProof,
  });

  factory EligibilityDocument.fromJson(Map<String, dynamic> json) {
    return EligibilityDocument(
      id: json['id'],
      documentName: json['document_name'],
      description: json['description'],
      isActive: json['isActive'],
      uploadedProof: json['uploaded_proof'],
    );
  }
}

class EducationalDocument {
  final int? id;
  final String? qualificationName;
  final String? certificateName;
  final String? uploadedCertificate;
  final bool? isActive;

  EducationalDocument({
    this.id,
    this.qualificationName,
    this.certificateName,
    this.uploadedCertificate,
    this.isActive,
  });

  factory EducationalDocument.fromJson(Map<String, dynamic> json) {
    return EducationalDocument(
      id: json['id'],
      qualificationName: json['qualification_name'],
      certificateName: json['certificate_name'],
      uploadedCertificate: json['uploaded_certificate'],
      isActive: json['isActive'],
    );
  }
}
