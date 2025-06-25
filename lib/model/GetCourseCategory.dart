class CategoryResponse {
  final int? n;
  final String? msg;
  final List<CategoryData>? data;

  CategoryResponse({
    this.n,
    this.msg,
    this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      n: json['n'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'n': n,
        'msg': msg,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class CategoryData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? categoryName;
  final String? tags;
  final bool? status;

  CategoryData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.categoryName,
    this.tags,
    this.status,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      categoryName: json['category_name'] as String?,
      tags: json['tags'] as String?,
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'isActive': isActive,
        'category_name': categoryName,
        'tags': tags,
        'status': status,
      };
}
