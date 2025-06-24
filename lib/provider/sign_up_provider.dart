import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';
import 'package:learning_mgt/dto/DocumentField.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';

import '../model/RegistrationResponse.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  
  TextEditingController otpController = TextEditingController();

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
  String? selectedTag;
  int _otpCountdown = 0;
  Timer? _otpTimer;

  int get otpCountdown => _otpCountdown;
  bool get isOtpCooldownActive => _otpCountdown > 0;

  int get cooldownSeconds => _otpCountdown;
  bool _isOtpSent = false;
  bool get isOtpSent => _isOtpSent;
  bool isEmailVerified = false;

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

  Candidate? _registeredCandidate;
  Candidate? get registeredCandidate => _registeredCandidate;

  int? selectedDepartmentId;
  int? selectedCountryId;
  int? selectedRankId;
  bool _isSavingDetails = false;
  bool get isSavingDetails => _isSavingDetails;

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
  final formKeyOTP = GlobalKey<FormState>();
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

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP cannot be empty';
    } else if (value.length != 6) {
      return 'OTP should be 6 digits';
    }
    return null;
  }

  void clearTagSelection() {
    selectedTag = null;
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
 List<DocumentField> documentFields = [];
  Map<String, TextEditingController> controllers = {};
  Map<String, String?> selectedFilePaths = {};

  Future<void> loadDocumentsFromAPI() async {
    // Replace with real API
    documentFields = [
      DocumentField(name: "Birth Certificate", hint: "Upload Birth Certificate"),
      DocumentField(name: "Passport Certificate", hint: "Upload Passport Certificate"),
       DocumentField(name: "CDC Certificate", hint: "Upload CDC Certificate"),
        DocumentField(name: "Course Completion Certificate", hint: "Upload Course Completion Certificate"),
         DocumentField(name: "COC Certificate", hint: "Upload COC Certificate"),

    ];

    for (var doc in documentFields) {
      controllers[doc.name] = TextEditingController();
      selectedFilePaths[doc.name] = null;
    }

    notifyListeners();
  }

  // void pickFile(String docName) {
  //   // implement your file picker here
  //   selectedFilePaths[docName] = "/mock/path/to/$docName.jpg";
  //   notifyListeners();
  // }
Future<void> pickFile(String docName) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'], // customize this
  );

  if (result != null && result.files.single.path != null) {
    selectedFilePaths[docName] = result.files.single.path!;
    final fileName = result.files.single.name;
      controllers[docName]?.text = fileName;
  } else {
    // user canceled or error
    selectedFilePaths[docName] = null;
  }

  notifyListeners();
}

  void removeFile(String docName) {
    selectedFilePaths[docName] = null;
    notifyListeners();
  }

  String? validateFile(String? val) {
    return val == null || val.isEmpty ? "Required" : null;
  }

  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP cannot be empty';
    } else if (value.length != 4) {
      return 'OTP must be 4 digits';
    }
    return null;
  }

  void startOtpTimer() {
    _otpCountdown = 30;
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _otpCountdown--;
      if (_otpCountdown <= 0) {
        _otpTimer?.cancel();
      }
      notifyListeners();
    });
  }

  void markOtpSent(bool value) {
    _isOtpSent = value;
    notifyListeners();
  }

  bool get isFormValid {
    return (
        firstNameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            validateEmailField(emailController.text) == null &&
            isEmailVerified && // OTP must be verified
            validatePhoneNumber(phoneNumberController.text) == null &&
            validatePassword(passwordController.text) == null &&
            validateConfirmPassword(confirmpasswordController.text) == null
    );
  }

  void disposeAll() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }


  void sendEmailOtp(BuildContext context, String email) async {
    // ShowDialogs.showLoadingDialog(context, routeGlobalKey, message: 'Sending OTP...');

    final body = {'email': email};

    try {
      await APIManager().apiRequest(
        context,
        API.emailOTP,
            (response) {
          // Navigator.pop(context);

          if (response is CommonResponse && response.n == 1) {
            markOtpSent(true);
            startOtpTimer();
            ShowDialogs.showToast(response.message);
          } else {
            ShowDialogs.showToast('Failed to send OTP');
          }
        },
            (error) {
          // Navigator.pop(context);
          ShowDialogs.showToast('Error sending OTP: $error');
        },
        jsonval: jsonEncode(body),
      );
    } catch (e) {
      Navigator.pop(context);
      ShowDialogs.showToast('Unexpected error: $e');
    }
  }

  Future<void> verifyEmailOtp(BuildContext context, String email) async {
    try {
      final requestBody = {
        "email": email,
        "otp": otpController.text,
      };

      await APIManager().apiRequest(
        context,
        API.verifyEmailOTP,
            (response) {
          if (response is CommonResponse) {
            if (response.n == 1) {  // Success case
              ShowDialogs.showToast(response.msg);
              isEmailVerified = true;
              notifyListeners();
            } else {
              print('message: ${response.msg}');
              ShowDialogs.showToast(response.msg);
            }
          } else {
            ShowDialogs.showToast('Unexpected response format');
          }
        },
            (error) {
          print('Error: ${error.toString()}');
          ShowDialogs.showToast('OTP verification failed: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      ShowDialogs.showToast('Error verifying OTP: ${e.toString()}');
    }
  }

  void handleVerificationResponse(CommonResponse response) {
    if (response.status) {  // Success case
      ShowDialogs.showToast(response.message);
      isEmailVerified = true;
      notifyListeners();
    } else {
      print('message: ${response.message}');
      ShowDialogs.showToast(response.message);
    }
  }

  Future<void> registerCandidate(BuildContext context) async {
    try {
      _isRegistering = true;
      notifyListeners();

      final requestBody = {
        "first_name": firstNameController.text.trim(),
        "middle_name": "",
        "last_name": lastNameController.text.trim(),
        "country_code": "+91",
        "mobilenumber": phoneNumberController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      await APIManager().apiRequest(
        context,
        API.registerCandidate, // Make sure this is defined in your API class
            (response) {
          if (response is CommonResponse) {
            if (response.n == 1) {
              ShowDialogs.showToast(response.msg);
              _registeredCandidate = Candidate.fromJson(response.data);
            } else {
              ShowDialogs.showToast(response.msg);
              throw Exception(response.msg);
            }
          } else {
            throw Exception('Unexpected response format');
          }
        },
            (error) {
          throw Exception('Registration failed: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      ShowDialogs.showToast(e.toString());
      rethrow; // Re-throw to handle in the calling function
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }

  Future<void> saveCandidateDetails(BuildContext context) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      if (_registeredCandidate?.id == null) {
        throw Exception('Candidate ID not found');
      }

      final requestBody = {
        "id": _registeredCandidate!.id,
        "passport_number": passportController.text.trim(),
        "department": selectedDepartmentId?.toString(),
        "rank": selectedRankId?.toString(),
        "dob": dobController.text.trim(),
        "country": selectedCountryId?.toString(),
        "pincode": pincodeController.text.trim(),
        "highest_qualification": "1", // Update if you have this field
        "seafearers_number": seafarerController.text.trim(),
      };
      print('Request body for candidate detail: $requestBody');

      await APIManager().apiRequest(
        context,
        API.candidateDetails,
            (response) {
          if (response is CommonResponse) {
            if (response.n == 1) {
              ShowDialogs.showToast(response.msg);
              // Update candidate data with new details if needed
              if (response.data != null) {
                _registeredCandidate = Candidate.fromJson(response.data);
              }
            } else {
              throw Exception(response.msg);
            }
          }
        },
            (error) {
          throw Exception('Failed to save details: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      ShowDialogs.showToast(e.toString());
      rethrow;
    } finally {
      _isSavingDetails = false;
      notifyListeners();
    }
  }

  // Add methods to handle department/country selection
  void setSelectedDepartment(Department department) {
    selectedDepartmentId = department.id;
    departmentController.text = department.departmentName;
    notifyListeners();
  }

  void setSelectedCountry(Country country) {
    selectedCountryId = country.id;
    countryController.text = country.name;
    notifyListeners();
  }

  void setSelectedRank(Rank rank) {
    selectedRankId = rank.id;
    rankController.text = rank.rank;
    notifyListeners();
  }


  /*Future<void> verifyEmailOtp(BuildContext context, String email) async {
    try {
      final requestBody = {
        "email": email,
        "otp": otpController.text,
      };

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.verifyEmailOTP,
            (response) {
          if (response is CommonResponse && response.status == true) {
            ShowDialogs.showToast(response.message);
          }
        },
            (error) {
          ShowDialogs.showToast('OTP verification failed: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      print('Error verifying OTP: ${e.toString()}');
      ShowDialogs.showToast('Error verifying OTP: ${e.toString()}');
    }
  }*/

  Future<void> getCountryListAPI() async {
    

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.countrylist,
        (response) async {
         
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

   Future<void> getDepartmentListAPI() async {
    

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.departmentlist,
        (response) async {
         
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
   Future<void> getQualificationListAPI() async {
    

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getqualifications,
        (response) async {
         
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
}
