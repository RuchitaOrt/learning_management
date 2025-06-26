class GetCourseInstituteResponse {
  final int? n;
  final String? msg;
  final List<InstituteData>? data;

  GetCourseInstituteResponse({
    this.n,
    this.msg,
    this.data,
  });

  factory GetCourseInstituteResponse.fromJson(Map<String, dynamic> json) {
    return GetCourseInstituteResponse(
      n: json['n'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => InstituteData.fromJson(e as Map<String, dynamic>))
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

class InstituteData {
  final String? id;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? name;
  final int? mobilenumber;
  final int? alternateMobilenumber;
  final String? password;
  final String? email;
  final bool? status;
  final String? source;
  final String? accreditationNumber;
  final bool? isParentTrainingCenter;
  final String? parentTrainingCenter;
  final int? noOfClassroom;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? designation;
  final String? reportingTo;
  final String? dob;
  final String? gender;
  final String? yearsOfExperience;
  final String? previousInstitute;
  final String? teachingExperience;
  final String? preferredTeachingMode;
  final String? specialization;
  final String? languages;
  final String? addressLineOne;
  final String? addressLineTwo;
  final int? country;
  final String? state;
  final String? city;
  final String? pincode;
  final bool? isMember;
  final String? memberType;
  final String? memberOf;
  final String? joiningDate;
  final int? role;
  final int? userType;
  final String? ogCode;
  final String? ogId;
  final bool? deactivate;
  final List<BatchData>? batches;
  final PaymentArray? paymentArray;

  InstituteData({
    this.id,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.name,
    this.mobilenumber,
    this.alternateMobilenumber,
    this.password,
    this.email,
    this.status,
    this.source,
    this.accreditationNumber,
    this.isParentTrainingCenter,
    this.parentTrainingCenter,
    this.noOfClassroom,
    this.firstName,
    this.middleName,
    this.lastName,
    this.designation,
    this.reportingTo,
    this.dob,
    this.gender,
    this.yearsOfExperience,
    this.previousInstitute,
    this.teachingExperience,
    this.preferredTeachingMode,
    this.specialization,
    this.languages,
    this.addressLineOne,
    this.addressLineTwo,
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.isMember,
    this.memberType,
    this.memberOf,
    this.joiningDate,
    this.role,
    this.userType,
    this.ogCode,
    this.ogId,
    this.deactivate,
    this.batches,
    this.paymentArray,
  });

  factory InstituteData.fromJson(Map<String, dynamic> json) {
    return InstituteData(
      id: json['id'] as String?,
      lastLogin: json['last_login'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      name: json['name'] as String?,
      mobilenumber: json['mobilenumber'] as int?,
      alternateMobilenumber: json['alternate_mobilenumber'] as int?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      status: json['status'] as bool?,
      source: json['source'] as String?,
      accreditationNumber: json['accreditation_number'] as String?,
      isParentTrainingCenter: json['is_parent_training_center'] as bool?,
      parentTrainingCenter: json['parent_training_center'] as String?,
      noOfClassroom: json['no_of_classroom'] as int?,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String?,
      designation: json['designation'] as String?,
      reportingTo: json['reporting_to'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      yearsOfExperience: json['years_of_experience'] as String?,
      previousInstitute: json['previous_institute'] as String?,
      teachingExperience: json['teaching_experience'] as String?,
      preferredTeachingMode: json['preferred_teaching_mode'] as String?,
      specialization: json['specialization'] as String?,
      languages: json['languages'] as String?,
      addressLineOne: json['address_line_one'] as String?,
      addressLineTwo: json['address_line_two'] as String?,
      country: json['country'] as int?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      pincode: json['pincode'] as String?,
      isMember: json['is_member'] as bool?,
      memberType: json['member_type'] as String?,
      memberOf: json['member_of'] as String?,
      joiningDate: json['joining_date'] as String?,
      role: json['role'] as int?,
      userType: json['user_type'] as int?,
      ogCode: json['og_code'] as String?,
      ogId: json['og_id'] as String?,
      deactivate: json['deactivate'] as bool?,
      batches: (json['batches'] as List?)
          ?.map((e) => BatchData.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentArray: json['payment_array'] != null
          ? PaymentArray.fromJson(json['payment_array'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_login': lastLogin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'isActive': isActive,
      'name': name,
      'mobilenumber': mobilenumber,
      'alternate_mobilenumber': alternateMobilenumber,
      'password': password,
      'email': email,
      'status': status,
      'source': source,
      'accreditation_number': accreditationNumber,
      'is_parent_training_center': isParentTrainingCenter,
      'parent_training_center': parentTrainingCenter,
      'no_of_classroom': noOfClassroom,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'designation': designation,
      'reporting_to': reportingTo,
      'dob': dob,
      'gender': gender,
      'years_of_experience': yearsOfExperience,
      'previous_institute': previousInstitute,
      'teaching_experience': teachingExperience,
      'preferred_teaching_mode': preferredTeachingMode,
      'specialization': specialization,
      'languages': languages,
      'address_line_one': addressLineOne,
      'address_line_two': addressLineTwo,
      'country': country,
      'state': state,
      'city': city,
      'pincode': pincode,
      'is_member': isMember,
      'member_type': memberType,
      'member_of': memberOf,
      'joining_date': joiningDate,
      'role': role,
      'user_type': userType,
      'og_code': ogCode,
      'og_id': ogId,
      'deactivate': deactivate,
      'batches': batches?.map((e) => e.toJson()).toList(),
      'payment_array': paymentArray?.toJson(),
    };
  }
}

class BatchData {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? branchId;
  final String? facultyId;
  final String? faculty2Id;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? maxCapacity;
  final String? mode;
  final String? schedulename;
  final String? actionStatus;
  final String? declineReason;
  final List<int>? courseIds;
  final List<String>? trainingCenterIds;
  final int? candidatesEnrolled;
  final String? capacity;
  final String? paymentLink;

  BatchData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.branchId,
    this.facultyId,
    this.faculty2Id,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.maxCapacity,
    this.mode,
    this.schedulename,
    this.actionStatus,
    this.declineReason,
    this.courseIds,
    this.trainingCenterIds,
    this.candidatesEnrolled,
    this.capacity,
    this.paymentLink,
  });

  factory BatchData.fromJson(Map<String, dynamic> json) {
    return BatchData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isActive: json['isActive'] as bool?,
      branchId: json['branch_id'] as String?,
      facultyId: json['faculty_id'] as String?,
      faculty2Id: json['faculty2_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      maxCapacity: json['max_capacity'] as String?,
      mode: json['mode'] as String?,
      schedulename: json['schedulename'] as String?,
      actionStatus: json['action_status'] as String?,
      declineReason: json['decline_reason'] as String?,
      courseIds:
          (json['course_ids'] as List?)?.map((e) => e as int).toList(),
      trainingCenterIds:
          (json['training_center_ids'] as List?)?.map((e) => e.toString()).toList(),
      candidatesEnrolled: json['candidates_enrolled'] as int?,
      capacity: json['capacity'] as String?,
      paymentLink: json['payment_link'] as String?,
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
      'branch_id': branchId,
      'faculty_id': facultyId,
      'faculty2_id': faculty2Id,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'max_capacity': maxCapacity,
      'mode': mode,
      'schedulename': schedulename,
      'action_status': actionStatus,
      'decline_reason': declineReason,
      'course_ids': courseIds,
      'training_center_ids': trainingCenterIds,
      'candidates_enrolled': candidatesEnrolled,
      'capacity': capacity,
      'payment_link': paymentLink,
    };
  }
}

class PaymentArray {
  final String? course;
  final String? schedule;
  final String? trainingcenterId;
  final String? coursePayment;

  PaymentArray({
    this.course,
    this.schedule,
    this.trainingcenterId,
    this.coursePayment,
  });

  factory PaymentArray.fromJson(Map<String, dynamic> json) {
    return PaymentArray(
      course: json['course'] as String?,
      schedule: json['schedule'] as String?,
      trainingcenterId: json['trainingcenter_id'] as String?,
      coursePayment: json['course_payment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course': course,
      'schedule': schedule,
      'trainingcenter_id': trainingcenterId,
      'course_payment': coursePayment,
    };
  }
}
