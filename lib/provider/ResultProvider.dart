import 'package:flutter/material.dart';

class ResultProvider with ChangeNotifier {
  int? _expandedIndex;

  int? get expandedIndex => _expandedIndex;

  void toggleExpanded(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }
}
class CourseResult {
  final String courseName;
  final String resultStatus;
  final String duration;
  final String courseStatus;
  final String totalMarks;
  final String result;

  CourseResult({
    required this.courseName,
    required this.resultStatus,
    required this.duration,
    required this.courseStatus,
    required this.totalMarks,
    required this.result,
  });
}
