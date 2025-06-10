import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController departmentController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController seafarerController = TextEditingController();
  TextEditingController passportController = TextEditingController();

  TextEditingController birhtCertificateController = TextEditingController();
  TextEditingController passportCerticateController = TextEditingController();
  TextEditingController CDCCertificateontroller = TextEditingController();
  TextEditingController CourseCompletionCertController =
      TextEditingController();
  TextEditingController COCCertificateController = TextEditingController();

  String? selectedBirthCertificateFilePath;
  String? selectedPassport;
  String? selectedCDC;
  String? selectedCompletionCertificate;
  String? selectedCOC;
  // Validator example
  String? validateBirthCertificate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your birth certificate';
    }
    return null;
  }

  Future<void> pickBirthCertificateFile(String pickedValue) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      if (pickedValue == "BirthCertificate") {
        selectedBirthCertificateFilePath = result.files.single.path!;
        birhtCertificateController.text = result.files.single.name;
      } else if (pickedValue == "PassportCertificate") {
        selectedPassport = result.files.single.path!;
        passportCerticateController.text = result.files.single.name;
      }
      else if (pickedValue == "CDCCertificate") {
        selectedCDC = result.files.single.path!;
        CDCCertificateontroller.text = result.files.single.name;
      }
      else if (pickedValue == "CourseCompletionCertificate") {
        selectedCompletionCertificate = result.files.single.path!;
        CourseCompletionCertController.text = result.files.single.name;
      }
      else if (pickedValue == "COCCertificate") {
        selectedCOC = result.files.single.path!;
        COCCertificateController.text = result.files.single.name;
      }

      notifyListeners();
    }
  }

  void clearBirthCertificateFile() {
    selectedBirthCertificateFilePath = null;
    birhtCertificateController.clear();
    notifyListeners();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  bool _isPasswordObscured = true;
  bool _isconfirmPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey1 => _formKey1;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey2 => _formKey2;
  bool get isPasswordObscured => _isPasswordObscured;
  bool get isconfirmPasswordObscured => _isconfirmPasswordObscured;
  final formKeyBasic = GlobalKey<FormState>();
  final formKeyDetail = GlobalKey<FormState>();
  final formKeyUpload = GlobalKey<FormState>();
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isconfirmPasswordObscured = !_isconfirmPasswordObscured;
    notifyListeners();
  }

  List<String> careerFields = [
    "Software Engineer",
    "Designer",
    "Marketing",
    "Finance"
  ];
  String? selectedCareerField;
  List<String>? resumeFile = [];

  void setSelectedCareerField(String value) {
    selectedCareerField = value;
    notifyListeners();
  }

  void setResumeFile(List<String>? filePath) {
    resumeFile = filePath;
    notifyListeners();
  }

  // Validators
  // String? validateFirstName(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'First Name cannot be empty';
  //   }
  //   return null;
  // }
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First Name cannot be empty';
    }

    final namePattern = RegExp(r"^[a-zA-Z]+$");

    if (!namePattern.hasMatch(value.trim())) {
      return 'First Name can contain only letters';
    }

    return null;
  }

  String? validateSeafaer(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Sea farer cannot be empty';
    }

    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name cannot be empty';
    }

    final namePattern = RegExp(r"^[a-zA-Z]+$");

    if (!namePattern.hasMatch(value.trim())) {
      return 'Last Name can contain only letters';
    }
    return null;
  }

  String? validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Passport cannot be empty';
    }

    return null;
  }

  String? validateDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Department cannot be empty';
    }

    return null;
  }

  String? validateRank(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rank cannot be empty';
    }

    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country cannot be empty';
    }

    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Date of birth';
    }

    return null;
  }

  String? validatePincodet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Pincode';
    }

    return null;
  }

  String? validatePassportCertificate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Upload Passport';
    }

    return null;
  }

  String? validateCareerField(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a career field";
    }
    return null;
  }

  String? validateResume(List<String>? files) {
    if (files == null || files.isEmpty) {
      return "Please upload at least one resume";
    }
    return null;
  }

  String? validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reason cannot be empty';
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

  // String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password cannot be empty';
  //   }
  //   return null;
  // }
  String? validatePassword(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    // // Check if the password length is at least 8 characters
    // if (value.length < 8) {
    //   return 'Password must be at least 8 characters';
    // }

    // Check if the password contains at least one uppercase letter, one lowercase letter, one digit, and one special character
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return 'Password must include At least 8 characters long, uppercase, lowercase, a digit, and a special character';
    }

    return null; // Return null if the password passes all checks
  }

  // Method to validate form
  // bool validateForm() {
  //   return _formKey.currentState?.validate() ?? false;
  // }

  //   bool validateDetailForm() {
  //   return _formKey1.currentState?.validate() ?? false;
  // }
  //   bool validateUploadForm() {
  //   return _formKey2.currentState?.validate() ?? false;
  // }
}
