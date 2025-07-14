class GetSeafarer {
  final int n;
  final String msg;
  final SeafarerData? data;

  GetSeafarer({
    required this.n,
    required this.msg,
    this.data,
  });

  factory GetSeafarer.fromJson(Map<String, dynamic> json) {
    return GetSeafarer(
      n: json['n'] ?? 0,
      msg: json['msg'] ?? '',
      data: json['data'] != null ? SeafarerData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'n': n,
        'msg': msg,
        'data': data?.toJson(),
      };
}

class SeafarerData {
  final String? id;
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
  final int? state;
  final int? city;
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
  final String? actionTakenby;
  final String? actionTakenbyUserType;
  final String? applicationNumber;
  final String? declineReason;
  final String? certificateName;
  final String? educationalCertificate;
  final String? deletedBy;
  final String? walkinBy;
  final String? coc;
  final String? stateName;
  final String? countryName;
  final String? departmentName;
  final String? rankName;
  final String? cityName;

  SeafarerData({
    this.id,
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
    this.actionTakenby,
    this.actionTakenbyUserType,
    this.applicationNumber,
    this.declineReason,
    this.certificateName,
    this.educationalCertificate,
    this.deletedBy,
    this.walkinBy,
    this.coc,
    this.stateName,
    this.countryName,
    this.departmentName,
    this.rankName,
    this.cityName,
  });

  factory SeafarerData.fromJson(Map<String, dynamic> json) {
    return SeafarerData(
      id: json['id'],
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
      actionTakenby: json['action_takenby'],
      actionTakenbyUserType: json['action_takenby_user_type'],
      applicationNumber: json['application_number'],
      declineReason: json['decline_reason'],
      certificateName: json['certificate_name'],
      educationalCertificate: json['educational_certificate'],
      deletedBy: json['deleted_by'],
      walkinBy: json['walkin_by'],
      coc: json['coc'],
      stateName: json['state_name'],
      countryName: json['country_name'],
      departmentName: json['department_name'],
      rankName: json['rank_name'],
      cityName: json['city_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'action_takenby': actionTakenby,
      'action_takenby_user_type': actionTakenbyUserType,
      'application_number': applicationNumber,
      'decline_reason': declineReason,
      'certificate_name': certificateName,
      'educational_certificate': educationalCertificate,
      'deleted_by': deletedBy,
      'walkin_by': walkinBy,
      'coc': coc,
      'state_name': stateName,
      'country_name': countryName,
      'department_name': departmentName,
      'rank_name': rankName,
      'city_name': cityName,
    };
  }
}
