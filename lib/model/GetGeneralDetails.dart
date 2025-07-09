class GetGeneralDetails {
  final int n;
  final String msg;
  final GeneralCandidateData? data;

  GetGeneralDetails({
    required this.n,
    required this.msg,
    required this.data,
  });

  factory GetGeneralDetails.fromJson(Map<String, dynamic> json) {
    return GetGeneralDetails(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] != null ? GeneralCandidateData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'n': n,
        'msg': msg,
        'data': data?.toJson(),
      };
}

class GeneralCandidateData {
  final String? id;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool? isActive;
  final String? profilePic;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? countryCode;
  final int? mobilenumber;
  final int? alternateMobilenumber;
  final String? highestQualification;
  final String? qualificationYear;
  final String? dob;
  final String? passportExpiryDate;
  final String? passportNumber;
  final String? nationality;
  final int? country;
  final String? state;
  final String? city;
  final String? pincode;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? vesselName;
  final String? nextVessel;
  final String? signOnDate;
  final String? signOfDate;
  final String? seamanBookNumber;
  final String? department;
  final String? rank;
  final String? source;
  final String? candidateStatus;
  final String? actionTakenBy;
  final int? actionTakenByUserType;
  final String? applicationNumber;
  final String? declineReason;
  final String? certificateName;
  final String? educationalCertificate;
  final String? deletedBy;
  final String? walkinBy;
  final String? coc;

  GeneralCandidateData({
    this.id,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.profilePic,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.password,
    this.countryCode,
    this.mobilenumber,
    this.alternateMobilenumber,
    this.highestQualification,
    this.qualificationYear,
    this.dob,
    this.passportExpiryDate,
    this.passportNumber,
    this.nationality,
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.addressLineOne,
    this.addressLineTwo,
    this.vesselName,
    this.nextVessel,
    this.signOnDate,
    this.signOfDate,
    this.seamanBookNumber,
    this.department,
    this.rank,
    this.source,
    this.candidateStatus,
    this.actionTakenBy,
    this.actionTakenByUserType,
    this.applicationNumber,
    this.declineReason,
    this.certificateName,
    this.educationalCertificate,
    this.deletedBy,
    this.walkinBy,
    this.coc,
  });

  factory GeneralCandidateData.fromJson(Map<String, dynamic> json) => GeneralCandidateData(
        id: json['id'],
        lastLogin: json['last_login'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        createdBy: json['createdBy'],
        updatedBy: json['updatedBy'],
        isActive: json['isActive'],
        profilePic: json['profile_pic'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        countryCode: json['country_code'],
        mobilenumber: json['mobilenumber'],
        alternateMobilenumber: json['alternate_mobilenumber'],
        highestQualification: json['highest_qualification'],
        qualificationYear: json['qualification_year'],
        dob: json['dob'],
        passportExpiryDate: json['passport_expiry_date'],
        passportNumber: json['passport_number'],
        nationality: json['nationality'],
        country: json['country'],
        state: json['state'],
        city: json['city'],
        pincode: json['pincode'],
        addressLineOne: json['address_line_one'],
        addressLineTwo: json['address_line_two'],
        vesselName: json['vessel_name'],
        nextVessel: json['next_vessel'],
        signOnDate: json['sign_on_date'],
        signOfDate: json['sign_of_date'],
        seamanBookNumber: json['seaman_book_number'],
        department: json['department'],
        rank: json['rank'],
        source: json['source'],
        candidateStatus: json['candidate_status'],
        actionTakenBy: json['action_takenby'],
        actionTakenByUserType: json['action_takenby_user_type'],
        applicationNumber: json['application_number'],
        declineReason: json['decline_reason'],
        certificateName: json['certificate_name'],
        educationalCertificate: json['educational_certificate'],
        deletedBy: json['deleted_by'],
        walkinBy: json['walkin_by'],
        coc: json['coc'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'last_login': lastLogin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'isActive': isActive,
        'profile_pic': profilePic,
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'country_code': countryCode,
        'mobilenumber': mobilenumber,
        'alternate_mobilenumber': alternateMobilenumber,
        'highest_qualification': highestQualification,
        'qualification_year': qualificationYear,
        'dob': dob,
        'passport_expiry_date': passportExpiryDate,
        'passport_number': passportNumber,
        'nationality': nationality,
        'country': country,
        'state': state,
        'city': city,
        'pincode': pincode,
        'address_line_one': addressLineOne,
        'address_line_two': addressLineTwo,
        'vessel_name': vesselName,
        'next_vessel': nextVessel,
        'sign_on_date': signOnDate,
        'sign_of_date': signOfDate,
        'seaman_book_number': seamanBookNumber,
        'department': department,
        'rank': rank,
        'source': source,
        'candidate_status': candidateStatus,
        'action_takenby': actionTakenBy,
        'action_takenby_user_type': actionTakenByUserType,
        'application_number': applicationNumber,
        'decline_reason': declineReason,
        'certificate_name': certificateName,
        'educational_certificate': educationalCertificate,
        'deleted_by': deletedBy,
        'walkin_by': walkinBy,
        'coc': coc,
      };
}
