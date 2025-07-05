import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetResultResponse.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

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


 String? _selectedCategory = "all";

  String? get selectedCategory => _selectedCategory;

  void selectCategory(String? categoryID) {
    _selectedCategory = categoryID;

    getResultAPI(_selectedCategory!);
    notifyListeners();
  }

  bool isSelected(String? category) {
    return _selectedCategory == category;
  }


    bool _isResultLoading = false;
  bool get isResultLoading => _isResultLoading;

  set isResultLoading(bool value) {
    _isResultLoading = value;
    notifyListeners();
  }
 List<ResultData> _courseResultList = [];

  // Getter for data
  List<ResultData> get courseResultList => _courseResultList;
  set courseResultList(List<ResultData> data) {
    _courseResultList = data;
    notifyListeners();
  }

void getResultAPI(String categoryID) async {
    // ShowDialogs.showLoadingDialog(context, routeGlobalKey, message: 'Sending OTP...');

    isResultLoading = true;
    print("isResultLoading $isResultLoading");
    _courseResultList = [];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      final body =  {
        'category_id':categoryID, //courseid,
        
      };

      try {
        await APIManager().apiRequest(
          routeGlobalKey.currentContext!,
          API.getresults,
          (response) {
            // Navigator.pop(context);
            GetResultResponse resp = response;
            if (resp.n == 1) {
              _courseResultList = resp.data!;
             
              print("_courseResultList");
              print(_courseResultList.length.toString());
               isResultLoading = false;
              notifyListeners();
               print("isResultLoading 1 $isResultLoading");
            }
             isResultLoading = false;
              notifyListeners();
          },
          (error) {
            // Navigator.pop(context);
            isResultLoading = false;
             print("isResultLoading 2 $isResultLoading");
            print("GETRESULT $error");
            notifyListeners();
            ShowDialogs.showToast("Server Not Responding");
          },
          jsonval: jsonEncode(body),
        );
      } catch (e) {
        isResultLoading = false;
         print("isResultLoading 4 $isResultLoading");
        notifyListeners();
        Navigator.pop(routeGlobalKey.currentContext!);
        ShowDialogs.showToast('Unexpected error: $e');
      }
    } else {
      isResultLoading = false;
       print("isResultLoading 5 $isResultLoading");
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
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
