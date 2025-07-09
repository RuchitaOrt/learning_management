import 'dart:convert';

CandidateInstitutesResponse candidateInstitutesResponseFromJson(String str) =>
    CandidateInstitutesResponse.fromJson(json.decode(str));

String candidateInstitutesResponseToJson(CandidateInstitutesResponse data) =>
    json.encode(data.toJson());

class CandidateInstitutesResponse {
  final int n;
  final String msg;
  final List<Institute> data;

  CandidateInstitutesResponse({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory CandidateInstitutesResponse.fromJson(Map<String, dynamic> json) =>
      CandidateInstitutesResponse(
        n: json["n"] ?? 0,
        msg: json["msg"] ?? "",
        data: json["data"] == null
            ? []
            : List<Institute>.from(json["data"].map((x) => Institute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "n": n,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Institute {
  final String id;
  final String? lastLogin;
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool isActive;
  final String name;
  final int mobilenumber;
  final String? alternateMobilenumber;
  final String password;
  final String email;
  final bool status;
  final String source;
  final String accreditationNumber;
  final bool isParentTrainingCenter;
  final String? parentTrainingCenter;
  final int noOfClassroom;
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
  final String addressLineOne;
  final String addressLineTwo;
  final int country;
  final String state;
  final String city;
  final String pincode;
  final bool isMember;
  final String? memberType;
  final String? memberOf;
  final String? joiningDate;
  final int role;
  final int userType;
  final String ogCode;
  final String? ogId;
  final bool deactivate;
  final List<Course> courses;

  Institute({
    required this.id,
    this.lastLogin,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.isActive,
    required this.name,
    required this.mobilenumber,
    this.alternateMobilenumber,
    required this.password,
    required this.email,
    required this.status,
    required this.source,
    required this.accreditationNumber,
    required this.isParentTrainingCenter,
    this.parentTrainingCenter,
    required this.noOfClassroom,
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
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.isMember,
    this.memberType,
    this.memberOf,
    this.joiningDate,
    required this.role,
    required this.userType,
    required this.ogCode,
    this.ogId,
    required this.deactivate,
    required this.courses,
  });

  factory Institute.fromJson(Map<String, dynamic> json) => Institute(
        id: json["id"] ?? "",
        lastLogin: json["last_login"],
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"] ?? false,
        name: json["name"] ?? "",
        mobilenumber: json["mobilenumber"] ?? 0,
        alternateMobilenumber: json["alternate_mobilenumber"]?.toString(),
        password: json["password"] ?? "",
        email: json["email"] ?? "",
        status: json["status"] ?? false,
        source: json["source"] ?? "",
        accreditationNumber: json["accreditation_number"] ?? "",
        isParentTrainingCenter: json["is_parent_training_center"] ?? false,
        parentTrainingCenter: json["parent_training_center"],
        noOfClassroom: json["no_of_classroom"] ?? 0,
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        designation: json["designation"],
        reportingTo: json["reporting_to"],
        dob: json["dob"],
        gender: json["gender"],
        yearsOfExperience: json["years_of_experience"],
        previousInstitute: json["previous_institute"],
        teachingExperience: json["teaching_experience"],
        preferredTeachingMode: json["preferred_teaching_mode"],
        specialization: json["specialization"],
        languages: json["languages"],
        addressLineOne: json["address_line_one"] ?? "",
        addressLineTwo: json["address_line_two"] ?? "",
        country: json["country"] ?? 0,
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        pincode: json["pincode"] ?? "",
        isMember: json["is_member"] ?? false,
        memberType: json["member_type"],
        memberOf: json["member_of"],
        joiningDate: json["joining_date"],
        role: json["role"] ?? 0,
        userType: json["user_type"] ?? 0,
        ogCode: json["og_code"] ?? "",
        ogId: json["og_id"],
        deactivate: json["deactivate"] ?? false,
        courses: json["courses"] == null
            ? []
            : List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "name": name,
        "mobilenumber": mobilenumber,
        "alternate_mobilenumber": alternateMobilenumber,
        "password": password,
        "email": email,
        "status": status,
        "source": source,
        "accreditation_number": accreditationNumber,
        "is_parent_training_center": isParentTrainingCenter,
        "parent_training_center": parentTrainingCenter,
        "no_of_classroom": noOfClassroom,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "designation": designation,
        "reporting_to": reportingTo,
        "dob": dob,
        "gender": gender,
        "years_of_experience": yearsOfExperience,
        "previous_institute": previousInstitute,
        "teaching_experience": teachingExperience,
        "preferred_teaching_mode": preferredTeachingMode,
        "specialization": specialization,
        "languages": languages,
        "address_line_one": addressLineOne,
        "address_line_two": addressLineTwo,
        "country": country,
        "state": state,
        "city": city,
        "pincode": pincode,
        "is_member": isMember,
        "member_type": memberType,
        "member_of": memberOf,
        "joining_date": joiningDate,
        "role": role,
        "user_type": userType,
        "og_code": ogCode,
        "og_id": ogId,
        "deactivate": deactivate,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

class Course {
  final int id;
  final String createdAt;
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
  final String? ogApprovedby;
  final bool ptcApproved;
  final String? ptcApprovedby;

  Course({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.isActive,
    required this.courseName,
    required this.courseCode,
    required this.trainingMode,
    required this.duration,
    required this.expiry,
    this.followedBy,
    required this.topicsCovered,
    required this.pricing,
    required this.description,
    required this.courseStatus,
    required this.infoStatus,
    required this.languages,
    required this.ogCode,
    required this.ogApproved,
    this.ogApprovedby,
    required this.ptcApproved,
    this.ptcApprovedby,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"] ?? 0,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"] ?? false,
        courseName: json["course_name"] ?? "",
        courseCode: json["course_code"] ?? "",
        trainingMode: json["training_mode"] ?? "",
        duration: json["duration"] ?? "",
        expiry: json["expiry"] ?? "",
        followedBy: json["followed_by"],
        topicsCovered: json["topics_covered"] ?? "",
        pricing: json["pricing"] ?? "",
        description: json["description"] ?? "",
        courseStatus: json["course_status"] ?? "",
        infoStatus: json["info_status"] ?? "",
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"].map((x) => x.toString())),
        ogCode: json["og_code"] ?? "",
        ogApproved: json["og_approved"] ?? false,
        ogApprovedby: json["og_approvedby"],
        ptcApproved: json["ptc_approved"] ?? false,
        ptcApprovedby: json["ptc_approvedby"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "course_name": courseName,
        "course_code": courseCode,
        "training_mode": trainingMode,
        "duration": duration,
        "expiry": expiry,
        "followed_by": followedBy,
        "topics_covered": topicsCovered,
        "pricing": pricing,
        "description": description,
        "course_status": courseStatus,
        "info_status": infoStatus,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "og_code": ogCode,
        "og_approved": ogApproved,
        "og_approvedby": ogApprovedby,
        "ptc_approved": ptcApproved,
        "ptc_approvedby": ptcApprovedby,
      };
}
