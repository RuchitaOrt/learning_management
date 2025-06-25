class GetCourseDetailListResponse {
  int? n;
  String? msg;
  CourseData? data;

  GetCourseDetailListResponse({this.n, this.msg, this.data});

  factory GetCourseDetailListResponse.fromJson(Map<String, dynamic> json) {
    return GetCourseDetailListResponse(
      n: json['n'],
      msg: json['msg'],
      data: json['data'] != null ? CourseData.fromJson(json['data']) : null,
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
  String? followedBy;
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
  List<String>? topicsList;
  List<Module>? modulesList;
  List<Language>? languagesList;

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
    this.topicsList,
    this.modulesList,
    this.languagesList,
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
      topicsList: (json['topics_list'] as List?)?.map((e) => e.toString()).toList(),
      modulesList: (json['modules_list'] as List?)
          ?.map((e) => Module.fromJson(e))
          .toList(),
      languagesList: (json['languages_list'] as List?)
          ?.map((e) => Language.fromJson(e))
          .toList(),
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
    };
  }
}

class Module {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  bool? isActive;
  int? courseId;
  String? moduleName;
  String? moduleDescription;
  String? moduleHours;

  Module({
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

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      isActive: json['isActive'],
      courseId: json['course_id'],
      moduleName: json['module_name'],
      moduleDescription: json['module_description'],
      moduleHours: json['module_hours'],
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

class Language {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  bool? isActive;
  String? languagesName;

  Language({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.languagesName,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      isActive: json['isActive'],
      languagesName: json['languages_name'],
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
