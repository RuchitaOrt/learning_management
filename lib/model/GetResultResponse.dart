class GetResultResponse {
  final int? n;
  final String? msg;
  final List<ResultData>? data;

  GetResultResponse({this.n, this.msg, this.data});

  factory GetResultResponse.fromJson(Map<String, dynamic> json) {
    return GetResultResponse(
      n: json['n'],
      msg: json['msg'],
      data: (json['data'] as List?)?.map((e) => ResultData.fromJson(e)).toList(),
    );
  }
}

class ResultData {
  final dynamic? id;
  final dynamic? courseName;
  final dynamic? courseCode;
  final dynamic? expiry;
  final dynamic? pricing;
  final dynamic? description;
  final dynamic? courseStatus;
  final List<String>? languages;
  final dynamic? ogCode;
  final bool? ogApproved;
  final bool? ptcApproved;
  final dynamic? getdays;
  final dynamic? mode;
  final dynamic? instName;
  final List<AttemptData>? attemptsData;
  final dynamic? attemptsLeft;
  final dynamic? timeTaken;
  final dynamic? totalMarks;
  final dynamic? cadStatus;

  ResultData({
    this.id,
    this.courseName,
    this.courseCode,
    this.expiry,
    this.pricing,
    this.description,
    this.courseStatus,
    this.languages,
    this.ogCode,
    this.ogApproved,
    this.ptcApproved,
    this.getdays,
    this.mode,
    this.instName,
    this.attemptsData,
    this.attemptsLeft,
    this.timeTaken,
    this.totalMarks,
    this.cadStatus,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) {
    return ResultData(
      id: json['id'],
      courseName: json['course_name'],
      courseCode: json['course_code'],
      expiry: json['expiry'],
      pricing: json['pricing'],
      description: json['description'],
      courseStatus: json['course_status'],
      languages: (json['languages'] as List?)?.map((e) => e.toString()).toList(),
      ogCode: json['og_code'],
      ogApproved: json['og_approved'],
      ptcApproved: json['ptc_approved'],
      getdays: json['getdays'],
      mode: json['mode'],
      instName: json['inst_name'],
      attemptsData: (json['attemptsdata'] as List?)?.map((e) => AttemptData.fromJson(e)).toList(),
      attemptsLeft: json['attempts_left'],
      timeTaken: json['time_taken'],
      totalMarks: json['total_marks'],
      cadStatus: json['cad_status'],
    );
  }
}

class AttemptData {
  final dynamic? id;
  final dynamic? startCreatedTime;
  final dynamic? marksObtained;
  final bool? isPassed;
  final dynamic? passStatus;
  final dynamic? mode;

  AttemptData({
    this.id,
    this.startCreatedTime,
    this.marksObtained,
    this.isPassed,
    this.passStatus,
    this.mode,
  });

  factory AttemptData.fromJson(Map<String, dynamic> json) {
    return AttemptData(
      id: json['id'],
      startCreatedTime: json['start_created_time'],
      marksObtained: json['marks_obtained'],
      isPassed: json['is_passed'],
      passStatus: json['pass_status'],
      mode: json['mode'],
    );
  }
}
