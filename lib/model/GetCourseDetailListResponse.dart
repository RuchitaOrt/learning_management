class GetCourseDetailListResponse {
  final int? n;
  final String? msg;
  final CourseDetailData? data;

  GetCourseDetailListResponse({
    this.n,
    this.msg,
    this.data,
  });

  factory GetCourseDetailListResponse.fromJson(Map<String, dynamic> json) {
    return GetCourseDetailListResponse(
      n: json['n'] as int?,
      msg: json['msg'] as String?,
      data: json['data'] != null
          ? CourseDetailData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n': n,
      'msg': msg,
      'data': data?.toJson(),
    };
  }
}

class CourseDetailData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? courseName;
  final String? courseCode;
  final String? trainingMode;
  final String? duration;
  final String? expiry;
  final dynamic followedBy;
  final String? topicsCovered;
  final String? pricing;
  final String? description;
  final String? courseStatus;
  final String? infoStatus;
  final List<String>? languages;
  final String? ogCode;
  final bool? ogApproved;
  final String? ogApprovedBy;
  final bool? ptcApproved;
  final String? ptcApprovedBy;
  final String? centerName;
  final List<String>? topicsList;
  final List<ModuleData>? modulesList;
  final List<LanguageData>? languagesList;
  final String? enrollStatus;

  CourseDetailData({
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
    this.topicsList,
    this.modulesList,
    this.languagesList,
    this.enrollStatus,
  });

  factory CourseDetailData.fromJson(Map<String, dynamic> json) {
    return CourseDetailData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      courseName: json['course_name'] as String?,
      courseCode: json['course_code'] as String?,
      trainingMode: json['training_mode'] as String?,
      duration: json['duration'] as String?,
      expiry: json['expiry'] as String?,
      followedBy: json['followed_by'],
      topicsCovered: json['topics_covered'] as String?,
      pricing: json['pricing'] as String?,
      description: json['description'] as String?,
      courseStatus: json['course_status'] as String?,
      infoStatus: json['info_status'] as String?,
      languages:
          (json['languages'] as List?)?.map((e) => e.toString()).toList(),
      ogCode: json['og_code'] as String?,
      ogApproved: json['og_approved'] as bool?,
      ogApprovedBy: json['og_approvedby'] as String?,
      ptcApproved: json['ptc_approved'] as bool?,
      ptcApprovedBy: json['ptc_approvedby'] as String?,
      centerName: json['center_name'] as String?,
      topicsList:
          (json['topics_list'] as List?)?.map((e) => e.toString()).toList(),
      modulesList: (json['modules_list'] as List?)
          ?.map((e) => ModuleData.fromJson(e as Map<String, dynamic>))
          .toList(),
      languagesList: (json['languages_list'] as List?)
          ?.map((e) => LanguageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      enrollStatus: json['enroll_status'] as String?,
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
      'topics_list': topicsList,
      'modules_list': modulesList?.map((e) => e.toJson()).toList(),
      'languages_list': languagesList?.map((e) => e.toJson()).toList(),
      'enroll_status': enrollStatus,
    };
  }
}

class ModuleData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final int? courseId;
  final String? moduleName;
  final String? moduleDescription;
  final String? moduleHours;

  ModuleData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.courseId,
    this.moduleName,
    this.moduleDescription,
    this.moduleHours,
  });

  factory ModuleData.fromJson(Map<String, dynamic> json) {
    return ModuleData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      courseId: json['course_id'] as int?,
      moduleName: json['module_name'] as String?,
      moduleDescription: json['module_description'] as String?,
      moduleHours: json['module_hours'] as String?,
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
      'course_id': courseId,
      'module_name': moduleName,
      'module_description': moduleDescription,
      'module_hours': moduleHours,
    };
  }
}

class LanguageData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? languagesName;

  LanguageData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.languagesName,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      languagesName: json['languages_name'] as String?,
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
      'languages_name': languagesName,
    };
  }
}
