class CourseListResponse {
  int? n;
  String? msg;
  List<CourseData>? data;

  CourseListResponse({this.n, this.msg, this.data});

  factory CourseListResponse.fromJson(Map<String, dynamic> json) {
    return CourseListResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List?)?.map((e) => CourseData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n': n,
      'msg': msg,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CourseData {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  bool? isActive;
  String? courseName;
  String? courseCode;
  String? trainingMode;
  String? duration;
  String? expiry;
  dynamic followedBy;
  String? topicsCovered;
  String? pricing;
  String? description;
  String? courseStatus;
  String? infoStatus;
  List<String>? languages;
  String? ogCode;
  bool? ogApproved;
  String? ogApprovedBy;
  bool? ptcApproved;
  String? ptcApprovedBy;
  String? centerName;

  CourseData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.courseName,
    this.courseCode,
    this.trainingMode,
    this.duration,
    this.expiry,
    this.followedBy,
    this.topicsCovered,
    this.pricing,
    this.description,
    this.courseStatus,
    this.infoStatus,
    this.languages,
    this.ogCode,
    this.ogApproved,
    this.ogApprovedBy,
    this.ptcApproved,
    this.ptcApprovedBy,
    this.centerName,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      isActive: json['isActive'],
      courseName: json['course_name'],
      courseCode: json['course_code'],
      trainingMode: json['training_mode'],
      duration: json['duration'],
      expiry: json['expiry'],
      followedBy: json['followed_by'],
      topicsCovered: json['topics_covered'],
      pricing: json['pricing'],
      description: json['description'],
      courseStatus: json['course_status'],
      infoStatus: json['info_status'],
      languages: (json['languages'] as List?)?.map((e) => e.toString()).toList(),
      ogCode: json['og_code'],
      ogApproved: json['og_approved'],
      ogApprovedBy: json['og_approvedby'],
      ptcApproved: json['ptc_approved'],
      ptcApprovedBy: json['ptc_approvedby'],
      centerName: json['center_name'],
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
      'topics_covered': topicsCovered,
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
      'center_name': centerName,
    };
  }
}
