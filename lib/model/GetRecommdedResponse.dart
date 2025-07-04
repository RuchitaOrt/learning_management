import 'dart:convert';

class GetRecommdedResponse {
  final int n;
  final String msg;
  final List<CourseModel> data;

  GetRecommdedResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory GetRecommdedResponse.fromJson(Map<String, dynamic> json) {
    return GetRecommdedResponse(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: (json['data'] as List?)?.map((e) => CourseModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n': n,
      'msg': msg,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CourseModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String createdBy;
  final String? updatedBy;
  final bool isActive;
  final String courseName;
  final String courseCode;
  final String trainingMode;
  final String duration;
  final String expiry;
  final int followedBy;
  final List<TopicCovered> topicsCovered;
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
  final String enrollStatus;
  final String courseType;

  CourseModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.createdBy,
    this.updatedBy,
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
    this.ogApprovedBy,
    required this.ptcApproved,
    this.ptcApprovedBy,
    required this.enrollStatus,
    required this.courseType,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'] ?? '',
      updatedBy: json['updatedBy'],
      isActive: json['isActive'] ?? false,
      courseName: json['course_name'] ?? '',
      courseCode: json['course_code'] ?? '',
      trainingMode: json['training_mode'] ?? '',
      duration: json['duration'] ?? '',
      expiry: json['expiry'] ?? '',
      followedBy: json['followed_by'] ?? 0,
      topicsCovered: (json['topics_covered'] != null && json['topics_covered'] != '')
          ? (jsonDecode(json['topics_covered']) as List)
              .map((e) => TopicCovered.fromJson(e))
              .toList()
          : [],
      pricing: json['pricing'] ?? '',
      description: json['description'] ?? '',
      courseStatus: json['course_status'] ?? '',
      infoStatus: json['info_status'] ?? '',
      languages: (json['languages'] as List?)?.map((e) => e.toString()).toList() ?? [],
      ogCode: json['og_code'] ?? '',
      ogApproved: json['og_approved'] ?? false,
      ogApprovedBy: json['og_approvedby'],
      ptcApproved: json['ptc_approved'] ?? false,
      ptcApprovedBy: json['ptc_approvedby'],
      enrollStatus: json['enroll_status'] ?? '',
      courseType: json['coursetype'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'isActive': isActive,
      'course_name': courseName,
      'course_code': courseCode,
      'training_mode': trainingMode,
      'duration': duration,
      'expiry': expiry,
      'followed_by': followedBy,
      'topics_covered': jsonEncode(topicsCovered.map((e) => e.toJson()).toList()),
      'pricing': pricing,
      'description': description,
      'course_status': courseStatus,
      'info_status': infoStatus,
      'languages': languages,
      'og_code': ogCode,
      'og_approved': ogApproved,
      'og_approvedby': ogApprovedBy,
      'ptc_approved': ptcApproved,
      'ptc_approvedby': ptcApprovedBy,
      'enroll_status': enrollStatus,
      'coursetype': courseType,
    };
  }
}

class TopicCovered {
  final String value;

  TopicCovered({required this.value});

  factory TopicCovered.fromJson(Map<String, dynamic> json) {
    return TopicCovered(
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
