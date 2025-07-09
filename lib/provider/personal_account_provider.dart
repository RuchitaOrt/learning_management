import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/SPManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetGeneralDetails.dart';
import 'package:learning_mgt/model/OtpVerificationResponse.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:http/http.dart' as http;

class PersonalAccountProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController timeZoneController = TextEditingController();

  TextEditingController seafarersNoController = TextEditingController();
  TextEditingController passportNoController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController COCController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isPasswordfieldObscured = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Date of birth';
    }

    return null;
  }

  String? validateLanguage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Language';
    }

    return null;
  }

  String? validateTimeZone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Time ZOne';
    }

    return null;
  }

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;
  bool get isPasswordfieldObscured => _isPasswordfieldObscured;
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void togglePasswordFieldVisibility() {
    _isPasswordfieldObscured = !_isPasswordfieldObscured;
    notifyListeners();
  }

  // Validators
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name cannot be empty';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name cannot be empty';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number cannot be empty';
    } else if (value.length != 10) {
      return 'Phone Number should be 10 digits';
    }
    return null;
  }

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_regexHelper.isEmailIdValid(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return 'Password must include At least 8 characters long, uppercase, lowercase, a digit, and a special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isGeneralLoading = false;
  bool get isGeneralLoading => _isGeneralLoading;

  set isGeneralLoading(bool value) {
    _isGeneralLoading = value;
    notifyListeners();
  }

  GeneralCandidateData? _generalList;

  // Getter for data
  GeneralCandidateData get generalList => _generalList!;
  set generalList(GeneralCandidateData data) {
    _generalList = data;
    notifyListeners();
  }

  Future<void> getGeneralList() async {
    isGeneralLoading = true;
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getgeneraldetails,
        (response) async {
          GetGeneralDetails resp = response;
          _generalList = resp.data!;
          isGeneralLoading = false;
          notifyListeners();
          print(response);
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          isGeneralLoading = false;
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isGeneralLoading = false;
      notifyListeners();

      return Future.error("No Internet Connection");
    }
  }

  bool _isSendOTPLoading = false;
  bool get isSendOTPLoading => _isSendOTPLoading;
  set isSendOTPLoading(bool value) {
    _isSendOTPLoading = value;
    notifyListeners();
  }

  Map<String, dynamic> createChangePasswordRequestBody(String email) {
    return {
      "newpassword": confirmpasswordController.text,
    };
  }

  chnagePasswordAPI(String email) async {
    isSendOTPLoading = true;
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createChangePasswordRequestBody(email);
      print(jsonbody);

      APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.updatecandidatepassword,
        (response) async {
          OtpVerificationResponse resp = response;

          if (resp.n == 1) {
            ShowDialogs.showToast(resp.msg);
            Navigator.of(routeGlobalKey.currentContext!).pushNamed(
              TabScreen.route,
              arguments: {
                'selectedPos': -1,
                'isSignUp': false,
              },
            );
            isSendOTPLoading = false;
            notifyListeners();
          } else {
            ShowDialogs.showToast(resp.msg);
            isSendOTPLoading = false;
            notifyListeners();
          }
        },
        (error) {
          print('ERR msg is $error');
          isSendOTPLoading = false;
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        jsonval: json.encode(jsonbody),
      );
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      isSendOTPLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }

  bool _isSavingDetails = false;
  bool get isSavingDetails => _isSavingDetails;
  set isSavingDetails(bool value) {
    _isSavingDetails = value;
    notifyListeners();
  }

  Future<void> uploadDocuments(BuildContext context, String filePath) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      // Prepare the multipart request
      var request = http.MultipartRequest('POST',
          Uri.parse(await APIManager().apiEndPoint(API.updategeneraldetails)));

      request.fields['email'] = emailController.text;
      request.fields['first_name'] = firstNameController.text;
      request.fields['middle_name'] = middleNameController.text;
      request.fields['last_name'] = lastNameController.text;
      request.fields['dob'] = dobController.text;
      request.fields['mobilenumber'] = phoneNumberController.text;
      if (filePath != "") {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          filePath,
        ));
      }

      // Add auth token if needed
      final token = await SPManager().getAuthToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Debug print request details

      print('\nSending request...');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Print full response
      print('\nResponse Received:');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Full Response Body:');
      try {
        final jsonResponse = json.decode(responseBody);
        final prettyJson = JsonEncoder.withIndent('  ').convert(jsonResponse);
        print(prettyJson);
      } catch (e) {
        print(responseBody); // Print as plain text if not JSON
      }

      // Handle response
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);
        if (jsonResponse['n'] == 1) {
           print('Full Response Body: n1');
             Navigator.of(routeGlobalKey.currentContext!).pushNamed(
              TabScreen.route,
              arguments: {
                'selectedPos': -1,
                'isSignUp': false,
              },
            );
          _isSavingDetails = false;
          notifyListeners();
        } else {
           print('Full Response Body: n2');
          final errorMsg = jsonResponse['msg'] ?? 'Failed to upload documents';
          print('\nError: $errorMsg');
          _isSavingDetails = false;
          notifyListeners();
          throw Exception(errorMsg);
        }
      } else {
        final errorMsg =
            'Upload failed with status ${response.statusCode}: ${response.reasonPhrase}';
        print('\n$errorMsg');
        _isSavingDetails = false;
        notifyListeners();
        throw Exception(errorMsg);
      }
    } catch (e) {
      _isSavingDetails = false;
      notifyListeners();
      print('\nException: $e');
      print(StackTrace.current);
      ShowDialogs.showToast('Error uploading documents: $e');
      rethrow;
    } finally {
      _isSavingDetails = false;
      notifyListeners();
      print('\nUpload process completed');
    }
  }

   Future<void> uploadProfileDocuments(BuildContext context, String filePath) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      // Prepare the multipart request
      var request = http.MultipartRequest('POST',
          Uri.parse(await APIManager().apiEndPoint(API.updatecandidateprofilepicture)));

    
      if (filePath != "") {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          filePath,
        ));
      }

      // Add auth token if needed
      final token = await SPManager().getAuthToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Debug print request details

      print('\nSending request...');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Print full response
      print('\nResponse Received:');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Full Response Body:');
      try {
        final jsonResponse = json.decode(responseBody);
        final prettyJson = JsonEncoder.withIndent('  ').convert(jsonResponse);
        print(prettyJson);
      } catch (e) {
        print(responseBody); // Print as plain text if not JSON
      }

      // Handle response
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);
        if (jsonResponse['n'] == 1) {
           print('Full Response Body: n1');
             Navigator.of(routeGlobalKey.currentContext!).pushNamed(
              TabScreen.route,
              arguments: {
                'selectedPos': -1,
                'isSignUp': false,
              },
            );
          _isSavingDetails = false;
          notifyListeners();
        } else {
           print('Full Response Body: n2');
          final errorMsg = jsonResponse['msg'] ?? 'Failed to upload documents';
          print('\nError: $errorMsg');
          _isSavingDetails = false;
          notifyListeners();
          throw Exception(errorMsg);
        }
      } else {
        final errorMsg =
            'Upload failed with status ${response.statusCode}: ${response.reasonPhrase}';
        print('\n$errorMsg');
        _isSavingDetails = false;
        notifyListeners();
        throw Exception(errorMsg);
      }
    } catch (e) {
      _isSavingDetails = false;
      notifyListeners();
      print('\nException: $e');
      print(StackTrace.current);
      ShowDialogs.showToast('Error uploading documents: $e');
      rethrow;
    } finally {
      _isSavingDetails = false;
      notifyListeners();
      print('\nUpload process completed');
    }
  }
}
