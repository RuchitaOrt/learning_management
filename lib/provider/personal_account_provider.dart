

import 'package:flutter/material.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';

class PersonalAccountProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
 TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
    TextEditingController oldpasswordController = TextEditingController();
    TextEditingController dobController = TextEditingController();
  TextEditingController  languageController= TextEditingController();
    TextEditingController  timeZoneController= TextEditingController();

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
     if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$').hasMatch(value)) {
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

  
}
