import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetRecommdedResponse.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

class RecommendedCourse {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String institue;
  final String mode;
  final String noofpeoplevisited;
  final String courseDuration;
  final String discountedAmount;
  final String amount;
  final String offerPercentage;
  final String status;//requested,pending,reapply
  final String courseStatus;//recommeded,mandatory


  RecommendedCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.institue,
    required this.mode,
    required this.noofpeoplevisited,
    required this.courseDuration,
    required this.discountedAmount,
    required this.amount,
    required this.offerPercentage,
    required this.status,
    required this.courseStatus
  });
}

class RecommendedCourseProvider with ChangeNotifier {
  String? _selectedCategory = "All";

  String? get selectedCategory => _selectedCategory;

  void selectCategory(String? categoryID) {
    _selectedCategory = categoryID;

    recommendedCourseListAPI(_selectedCategory!);
    notifyListeners();
  }

  bool isSelected(String? category) {
    return _selectedCategory == category;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  List<CourseModel> _recommendedcourseList = [];

  // Getter for data
  List<CourseModel> get recommendedcourseList => _recommendedcourseList;
  set recommendedcourseList(List<CourseModel> data) {
    _recommendedcourseList = data;
    notifyListeners();
  }
void recommendedCourseListAPI(String listingType) async {
    // ShowDialogs.showLoadingDialog(context, routeGlobalKey, message: 'Sending OTP...');
 print("_recommendedcourseList");
    isLoading = true;
    _recommendedcourseList = [];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      final body = {'listtype': listingType};

 print("_recommendedcourseList");
      try {
        await APIManager().apiRequest(
          routeGlobalKey.currentContext!,
          API.recommendationlist,
          (response) {
            // Navigator.pop(context);
            print("_recommendedcourseList");
            print("_recommendedcourseList ${response.n}");
            GetRecommdedResponse resp = response;
            if (resp.n == 1) {
              _recommendedcourseList = resp.data!;
              
              print("_recommendedcourseList");
              print(_recommendedcourseList.length.toString());
            }
            isLoading = false;
              notifyListeners();
          },
          (error) {
            // Navigator.pop(context);
            isLoading = false;
            notifyListeners();
            ShowDialogs.showToast("Server Not Responding");
          },
          jsonval: jsonEncode(body),
        );
      } catch (e) {
        isLoading = false;
        notifyListeners();
        Navigator.pop(routeGlobalKey.currentContext!);
        ShowDialogs.showToast('Unexpected error: $e');
      }
    } else {
      isLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }



List category=["All","Mandatory","Recommended"];
}
