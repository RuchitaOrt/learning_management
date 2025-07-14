import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';
import 'package:learning_mgt/Utils/regex_helper.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/LoginResponse.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

import '../Utils/SPManager.dart';

class SignInProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();
  bool _isExploreChecked = false;

  bool get isExploreChecked => _isExploreChecked;
  bool _isCheckedTerms = false;

  bool get isCheckedTerms => _isCheckedTerms;

  bool _isChecked = false;

  bool get isChecked => _isChecked;

  bool _showTermsError = false;

  bool get showTermsError => _showTermsError;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void toggleTermsCheckbox(bool? value) {
    _isCheckedTerms = value ?? false;
    _showTermsError = false; // Hide error when checkbox is toggled
    notifyListeners();
  }

  // Setter
  set isExploreChecked(bool value) {
    _isExploreChecked = value;
    notifyListeners();
  }

  bool get areRequiredFieldsFilled {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        isCheckedTerms;
  }

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;
  String? selectedChip;
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_regexHelper.isEmailIdValid(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }
setIDandpassword()
{
    emailController.text="kattalemahesh@gmail.com";
          passwordController.text="Mahesh@8548";
          notifyListeners();
}
  /*String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return 'Password must include At least 8 characters long, uppercase, lowercase, a digit, and a special character';
    }
    return null;
  }*/

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners(); // Notify listeners when the state changes
  }

  // Method to validate form
  bool validateForm() {
    bool isFormValid = _formKey.currentState?.validate() ?? false;
    validateTermsAcceptance();
    return isFormValid && _isCheckedTerms;
  }

  var getToken = "";
  void onSingleChipSelected(String? label) {
    selectedChip = label; // Update the selected chip

    notifyListeners();
  }

  void validateTermsAcceptance() {
    _showTermsError = !_isCheckedTerms;
    notifyListeners();
  }

  Map<String, String> createRequestBody() {
    return {
      "email": emailController.text.trim(),
      "password": passwordController.text,
    };
  }

  Future<void> createSignIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners(); // optional if using Provider

    final isFormValid = _formKey.currentState?.validate() ?? false;
    final termsAccepted = _isCheckedTerms;

    if (!isFormValid || !termsAccepted) {
      _isLoading = false;
      notifyListeners();

      if (!termsAccepted) {
        ShowDialogs.showToast("Please accept the terms and privacy policy");
      }

      return;
    }

    /*if (!validateForm()) {
      _isLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please fill all fields correctly");
      return;
    }*/

    var status1 = await ConnectionDetector.checkInternetConnection();
    if (!status1) {
      _isLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
      return;
    }

    try {
      final requestBody = {
        "email": emailController.text.trim(),
        "password": passwordController.text,
      };

      print('Login request body: $requestBody');

      await APIManager().apiRequest(
        // routeGlobalKey.currentContext!,
        context,
        API.login,
            (response) async {
          _isLoading = false;
          notifyListeners();

          if (response is LoginResponse) {
            if (response.n == 1) {
              // Store the token
              await SPManager().setAuthToken(response.token);

              // Store the user data
              await SPManager().setUserData(json.encode(response.userData));

              // Print and store the ID
              if (response.userData != null) {
                print('User ID: ${response.userData!.id}');
                await SPManager().setUserId(response.userData!.id); // Assuming you have this method
              }

              ShowDialogs.showToast(response.msg);

              Navigator.of(context).pushNamed(
                TabScreen.route,
                arguments: {
                  'selectedPos': -1,
                  'isSignUp': false,
                },
              );
            } else {
              ShowDialogs.showToast(response.msg);
            }
          }
        },
            (error) {
          _isLoading = false;
          notifyListeners();
          print('Login error: $error');
          ShowDialogs.showToast("Login failed. Please try again.");
        },
        jsonval: json.encode(requestBody),
      );
      /*await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.login,
            (response) async {
          _isLoading = false;
          notifyListeners();

          if (response is LoginResponse) {
            if (response.n == 1) {
              await SPManager().setAuthToken(response.token);
              await SPManager().setUserData(json.encode(response.userData));

              ShowDialogs.showToast(response.msg);

              Navigator.of(routeGlobalKey.currentContext!).pushNamed(
                TabScreen.route,
                arguments: {
                  'selectedPos': -1,
                  'isSignUp': false,
                },
              );
            } else {
              ShowDialogs.showToast(response.msg);
            }
          }
        },
            (error) {
          _isLoading = false;
          notifyListeners();
          print('Login error: $error');
          ShowDialogs.showToast("Login failed. Please try again.");
        },
        jsonval: json.encode(requestBody),
      );*/
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Login exception: $e');
      ShowDialogs.showToast("An error occurred during login");
    }
  }

}
