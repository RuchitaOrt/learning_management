

class GetCertificateResponse {
  final int n;
  final String msg;
  final List<CourseData> data;

  GetCertificateResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory GetCertificateResponse.fromJson(Map<String, dynamic> json) {
    return GetCertificateResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CourseData.fromJson(e))
              .toList() ??
          [],
    );
  }
}
class CourseData {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool isActive;
  final String courseName;
  final String courseCode;
  final String trainingMode;
  final String duration;
  final String expiry;
  final String? followedBy;
  final String topicsCovered;
  final String pricing;
  final String description;
  final String courseStatus;
  final String infoStatus;
  final List<String> languages;
  final String ogCode;
  final bool ogApproved;
  final String? ogApprovedBy;
  final bool ptcApproved;
  final String? ptcApprovedBy;
  final int getDays;
  final String mode;
  final String instName;
  final String certificateLink;

  CourseData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.courseName,
    required this.courseCode,
    required this.trainingMode,
    required this.duration,
    required this.expiry,
    required this.followedBy,
    required this.topicsCovered,
    required this.pricing,
    required this.description,
    required this.courseStatus,
    required this.infoStatus,
    required this.languages,
    required this.ogCode,
    required this.ogApproved,
    required this.ogApprovedBy,
    required this.ptcApproved,
    required this.ptcApprovedBy,
    required this.getDays,
    required this.mode,
    required this.instName,
    required this.certificateLink,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] ?? 0,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      isActive: json['isActive'] ?? false,
      courseName: json['course_name'] ?? '',
      courseCode: json['course_code'] ?? '',
      trainingMode: json['training_mode'] ?? '',
      duration: json['duration'] ?? '',
      expiry: json['expiry'] ?? '',
      followedBy: json['followed_by'],
      topicsCovered: json['topics_covered'] ?? '',
      pricing: json['pricing'] ?? '',
      description: json['description'] ?? '',
      courseStatus: json['course_status'] ?? '',
      infoStatus: json['info_status'] ?? '',
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      ogCode: json['og_code'] ?? '',
      ogApproved: json['og_approved'] ?? false,
      ogApprovedBy: json['og_approvedby'],
      ptcApproved: json['ptc_approved'] ?? false,
      ptcApprovedBy: json['ptc_approvedby'],
      getDays: json['getdays'] ?? 0,
      mode: json['mode'] ?? '',
      instName: json['inst_name'] ?? '',
      certificateLink: json['certificate_link'] ?? '',
    );
  }
}
