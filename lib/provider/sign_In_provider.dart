
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/regex_helper.dart';

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

}