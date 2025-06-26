class GetResourceResponse {
  final int? n;
  final String? msg;
  final List<ResourceData>? data;

  GetResourceResponse({
    this.n,
    this.msg,
    this.data,
  });

  factory GetResourceResponse.fromJson(Map<String, dynamic> json) {
    return GetResourceResponse(
      n: json['n'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ResourceData.fromJson(e as Map<String, dynamic>))
          .toList(),
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

class ResourceData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final int? courseId;
  final int? moduleId;
  final int? language;
  final String? materialType;
  final String? materialLabel;
  final String? materialLink;
  final String? materialFile;
  final String? modulename;

  ResourceData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.courseId,
    this.moduleId,
    this.language,
    this.materialType,
    this.materialLabel,
    this.materialLink,
    this.materialFile,
    this.modulename,
  });

  factory ResourceData.fromJson(Map<String, dynamic> json) {
    return ResourceData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      courseId: json['course_id'] as int?,
      moduleId: json['module_id'] as int?,
      language: json['language'] as int?,
      materialType: json['material_type'] as String?,
      materialLabel: json['material_label'] as String?,
      materialLink: json['material_link'] as String?,
      materialFile: json['material_file'] as String?,
      modulename: json['modulename'] as String?,
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
      'module_id': moduleId,
      'language': language,
      'material_type': materialType,
      'material_label': materialLabel,
      'material_link': materialLink,
      'material_file': materialFile,
      'modulename': modulename,
    };
  }
}
