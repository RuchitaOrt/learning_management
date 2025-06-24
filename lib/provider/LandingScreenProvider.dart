

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/SPManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetCourseCategory.dart';
import 'package:learning_mgt/model/LogoutResponse.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';


class LandingScreenProvider with ChangeNotifier {
 
  bool _isSearchIconVisible = false;

  bool get isSearchIconVisible => _isSearchIconVisible;
  set isSearchIconVisible(bool value) {
    _isSearchIconVisible = value;
  }
  Future<Map<String, dynamic>> createRequestBody(String token) async {
    return {
      "token":token!=""?token: await SPManager().getAuthToken(),
      
    };
  }

  Future<void> logout(BuildContext context) async {
    // Use the root context instead of dialog context
    final rootContext = routeGlobalKey.currentContext;
    if (rootContext == null) return;

    ShowDialogs.showLoadingDialog(rootContext, routeGlobalKey, message: 'Logging out...');

    try {
      final token = await SPManager().getAuthToken();
      if (token == null || token.isEmpty) {
        Navigator.pop(rootContext);
        ShowDialogs.showToast('No active session found');
        return;
      }

      final requestBody = {"token": token};

      await APIManager().apiRequest(
        rootContext,
        API.logout,
            (response) async {
          Navigator.pop(rootContext); // Close loading dialog
          if (response is CommonResponse) {
            await SPManager().clearAuthData();
            ShowDialogs.showToast(response.msg);
            Navigator.of(rootContext).pushNamedAndRemoveUntil(
              SignInScreen.route,
                  (route) => false,
            );
          }
        },
            (error) {
          Navigator.pop(rootContext); // Close loading dialog
          ShowDialogs.showToast('Logout failed: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      if (rootContext.mounted) {
        Navigator.pop(rootContext);
        ShowDialogs.showToast('Error during logout: ${e.toString()}');
      }
    }

    
  }

    List<CategoryData> _courseList = [];

  // Getter for data
  List<CategoryData> get courseList => _courseList;
  set courseList(List<CategoryData> data) {
    _courseList = data;
    notifyListeners();
  }

    Future<void> getCategoryList() async {
    

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getcoursecategorylist,
        (response) async {
            CategoryResponse resp = response;
            _courseList=resp.data!;
         print(response);
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

     
      return Future.error("No Internet Connection");
    }
  }

 /*Future<void> logoutAPI(String token) async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = await createRequestBody(token);
     print("logout");
print(token);
      APIManager().apiRequest(routeGlobalKey.currentContext!, API.logout,
          (response) async {
        CommonResponse resp = response;
        // if (response['status'] == true) {
         if (resp.status == true) {
          print("success");
          if(token=="")
          {
 ShowDialogs.showToast(resp.message);
          SPManager().setAuthToken("");
              print("logout");
                 Navigator.of(
                       routeGlobalKey.currentContext!,
                     ).pushNamed(
                       SignInScreen.route,
                     );

          }else{
            
          }
       
         
         }
        // } else {
        //   // Handle failu
        //   print("response status fail");
        //   print(response['errors']);

        // }
      }, (error) {
     
        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }*/
}


