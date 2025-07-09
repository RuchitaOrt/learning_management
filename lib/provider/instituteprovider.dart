import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/CandidateInstituteResponse.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

class InstituteProvider extends ChangeNotifier {


    bool _isInstitueLoading = false;
  bool get isInstitueLoading => _isInstitueLoading;

  set isInstitueLoading(bool value) {
    _isInstitueLoading = value;
    notifyListeners();
  }
 List<Institute> _institutcourseList = [];

  // Getter for data
  List<Institute> get institutcourseList => _institutcourseList;
  set institutcourseList(List<Institute> data) {
    _institutcourseList = data;
    notifyListeners();
  }
  void getInstituteAPI() async {
   

    isInstitueLoading = true;
    _institutcourseList = [];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      final body = "";

      try {
        await APIManager().apiRequest(
          routeGlobalKey.currentContext!,
          API.getcandidateinstitutescoursedetails,
          (response) {
            // Navigator.pop(context);
            CandidateInstitutesResponse resp = response;
            if (resp.n == 1) {
              _institutcourseList = resp.data;
             
              print("_institutcourseList");
              print(_institutcourseList.length.toString());
            }
             isInstitueLoading = false;
              notifyListeners();
          },
          (error) {
            // Navigator.pop(context);
            isInstitueLoading = false;
            notifyListeners();
            ShowDialogs.showToast("Server Not Responding");
          },
          jsonval: jsonEncode(body),
        );
      } catch (e) {
        isInstitueLoading = false;
        notifyListeners();
        Navigator.pop(routeGlobalKey.currentContext!);
        ShowDialogs.showToast('Unexpected error: $e');
      }
    } else {
      isInstitueLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
  // final List<Map<String, dynamic>> _institutesData = [
  //   {
  //     'name': "Centre for Maritime Education and Training (CMET)",
  //     'iconPath': LMSImagePath.certificateLogo,
  //     'courses': [
  //       {
  //         'title': "Master precise plotting methods for complex voyages.",
  //         'description':
  //             "Consequatur maiores vero qui ex dicta alias sunt in. Sit officiis ex ut vel. Aut quam repellendus veniam accusantium qui quidem hic. Id sapiente et minus accusamus dolor molestiae molestias.",
  //         'enrollmentNo': "#313264984",
  //         'date': "Jan 20, 2025",
  //         'time': "00:00:00",
  //         'duration': "4 days",
  //         'mode': "Offline",
  //         'price': 72.00,
  //       },
  //       {
  //         'title': "Advanced Navigation Systems",
  //         'description':
  //             "Learn modern GPS and electronic navigation systems for maritime operations.",
  //         'enrollmentNo': "#313264985",
  //         'date': "Feb 10, 2025",
  //         'time': "14:00:00",
  //         'duration': "3 days",
  //         'mode': "Online",
  //         'price': 85.00,
  //       },
  //     ],
  //   },
  //   {
  //     'name': "Excellence & Competency Training Center, Inc. (EXACT)",
  //     'iconPath': LMSImagePath.certificateLogo,
  //     'courses': [
  //       {
  //         'title': "Advanced Ship Handling and Maneuvering.",
  //         'description':
  //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  //         'enrollmentNo': "#987654321",
  //         'date': "Feb 15, 2025",
  //         'time': "09:00:00",
  //         'duration': "7 days",
  //         'mode': "Online",
  //         'price': 120.00,
  //       },
  //     ],
  //   },
    
  // ];

  // List<Map<String, dynamic>> get institutesData => _institutesData;

  // // Method to add new institute
  // void addInstitute(Map<String, dynamic> institute) {
  //   _institutesData.add(institute);
  //   notifyListeners();
  // }

  // // Method to add course to existing institute
  // void addCourseToInstitute(int instituteIndex, Map<String, dynamic> course) {
  //   if (instituteIndex >= 0 && instituteIndex < _institutesData.length) {
  //     _institutesData[instituteIndex]['courses'].add(course);
  //     notifyListeners();
  //   }
  // }

  // // Method to remove course from institute
  // void removeCourseFromInstitute(int instituteIndex, int courseIndex) {
  //   if (instituteIndex >= 0 && instituteIndex < _institutesData.length) {
  //     List<Map<String, dynamic>> courses = _institutesData[instituteIndex]['courses'];
  //     if (courseIndex >= 0 && courseIndex < courses.length) {
  //       courses.removeAt(courseIndex);
  //       notifyListeners();
  //     }
  //   }
  // }

  // // Method to update course details
  // void updateCourse(int instituteIndex, int courseIndex, Map<String, dynamic> updatedCourse) {
  //   if (instituteIndex >= 0 && instituteIndex < _institutesData.length) {
  //     List<Map<String, dynamic>> courses = _institutesData[instituteIndex]['courses'];
  //     if (courseIndex >= 0 && courseIndex < courses.length) {
  //       courses[courseIndex] = updatedCourse;
  //       notifyListeners();
  //     }
  //   }
  // }
}
