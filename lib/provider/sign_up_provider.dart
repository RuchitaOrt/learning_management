import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';
import 'package:learning_mgt/dto/DocumentField.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/OtpVerificationResponse.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';

import '../Utils/SPManager.dart';
import '../model/RegistrationResponse.dart';
import 'package:http/http.dart' as http;

import 'StepProvider.dart';

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
  List<Department> _departments = [];
  List<Country> _countries = [];
  List<Rank> _ranks = [];
  bool _isLoadingDepartments = false;
  bool _isLoadingCountries = false;
  bool _isLoadingRanks = false;
  String? _departmentError;
  String? _countryError;
  String? _rankError;
  List<Department> get departments => _departments;
  List<Country> get countries => _countries;
  List<Rank> get ranks => _ranks;
  bool get isLoadingDepartments => _isLoadingDepartments;
  bool get isLoadingCountries => _isLoadingCountries;
  bool get isLoadingRanks => _isLoadingRanks;
  String? get departmentError => _departmentError;
  String? get countryError => _countryError;
  String? get rankError => _rankError;
  List<Qualification> qualifications = [];
  bool isLoadingQualifications = false;
  String? qualificationError;
  int? selectedQualificationId;
  TextEditingController qualificationController = TextEditingController();
  String? selectedQualificationName;
  List<Document> documents = [];
  bool isLoadingDocuments = false;
  String? documentError;
  bool _isSendingOtp = false;
  bool _isVerifyingOtp = false;
  bool get isSendingOtp => _isSendingOtp;
  bool get isVerifyingOtp => _isVerifyingOtp;
  bool _isOverallLoading = false;
  bool get isOverallLoading => _isOverallLoading;
  bool _isInitialLoadComplete = false;
  bool get isInitialLoadComplete => _isInitialLoadComplete;
  bool _isLoadingDetails = false;
  bool get isLoadingDetails => _isLoadingDetails;
  List<StateModel> _states = [];
  bool _isLoadingStates = false;
  String? _stateError;
  // String? selectedState;
  List<StateModel> get states => _states;
  bool get isLoadingStates => _isLoadingStates;
  String? get stateError => _stateError;
  Country? _selectedCountry;
  // String? _selectedState;
  Country? get selectedCountry => _selectedCountry;
  StateModel? selectedState;
  Country? _dialogSelectedCountry;
  Country? get dialogSelectedCountry => _dialogSelectedCountry;

  void setSelectedCountry(Country country) {
    _selectedCountry = country;
    selectedCountryId = country.id;
    countryController.text = country.name;
    fetchStatesByCountry(country.id); // fetch states immediately
    notifyListeners();
  }

  void setDialogSelectedCountry(Country country) {
    _dialogSelectedCountry = country;
    notifyListeners();
  }

  void setSelectedState(dynamic state) {
    if (state == null) {
      selectedState = null;
    } else if (state is StateModel) {
      selectedState = state;
    } else if (state is String) {
      selectedState = _states.firstWhere((s) => s.name == state);
    }
    notifyListeners();
  }

  /*Future<void> fetchStatesByCountry(int countryId) async {
    try {
      _isLoadingStates = true;
      _stateError = null;
      _states = [];
      notifyListeners();

      final requestBody = json.encode({"id": countryId.toString()});

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getstatecountry,
            (response) {
          if (response is Map<String, dynamic>) {
            if (response['n'] == 1) {
              final data = response['data'] as List;
              _states = data.map((stateJson) => StateModel.fromJson(stateJson)).toList();
              notifyListeners(); // Add this here to update UI immediately

              print("Fetched states: ${_states.map((e) => e.name).toList()}");

              print("Received states: $data");
              print("Mapped states: $_states");
            } else {
              _stateError = response['msg'] ?? 'Failed to load states';
            }
          } else {
            _stateError = 'Unexpected response format';
          }
          notifyListeners(); // And here for error cases
        },
            (error) {
          _stateError = 'Failed to load states: ${error.toString()}';
          notifyListeners();
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _stateError = 'Failed to load states';
      notifyListeners();
    } finally {
      _isLoadingStates = false;
      notifyListeners();
    }
  }*/

  Future<void> fetchStatesByCountry(int countryId) async {
    try {
      _isLoadingStates = true;
      _stateError = null;
      _states = [];
      notifyListeners();

      final requestBody = json.encode({"id": countryId.toString()});

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getstatecountry,
            (response) {
          print("✅ Raw response in fetchStatesByCountry: $response");

          // ✅ Directly use the response as StateResponse
          if (response is StateResponse) {
            if (response.n == 1 && response.data.isNotEmpty) {
              _states = response.data;
              print("✅ Parsed state list: ${_states.map((s) => s.name).toList()}");
            } else {
              _stateError = response.msg;
              print("❌ API returned n != 1 or empty list");
            }
          } else {
            _stateError = '❌ Unexpected response format';
            print("❌ Response is not of type StateResponse");
          }

          notifyListeners();
        },
            (error) {
          _stateError = 'Failed to load states: ${error.toString()}';
          notifyListeners();
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _stateError = 'Failed to load states: $e';
      notifyListeners();
    } finally {
      _isLoadingStates = false;
      notifyListeners();
    }
  }

  /*Future<void> fetchStatesByCountry(int countryId) async {
    try {
      _isLoadingStates = true;
      _stateError = null;
      _states = [];
      notifyListeners();

      final requestBody = json.encode({"id": countryId.toString()});

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getstatecountry,
            (response) {
          if (response is StateListResponse) {
            _states = response.data;
            print('Fetched ${_states.length} states for country $countryId');
            for (var state in _states) {
              print('State: ${state.name}');
            }
          } else {
            _stateError = 'Unexpected response format';
          }
        },
            (error) {
          _stateError = 'Failed to load states: ${error.toString()}';
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _stateError = 'Failed to load states';
    } finally {
      _isLoadingStates = false;
      notifyListeners();
    }
  }*/

  Future<void> fetchInitialData(BuildContext context) async {
    _isLoadingDetails = true;
    notifyListeners();

    try {
      await Future.wait([
        fetchDepartments(context),
        fetchCountries(context),
        fetchQualifications(context),
      ]);
    } catch (e) {
      // Handle error
    } finally {
      _isLoadingDetails = false;
      notifyListeners();
    }
  }

  void setSendingOtp(bool value) {
    _isSendingOtp = value;
    notifyListeners();
  }

  void setVerifyingOtp(bool value) {
    _isVerifyingOtp = value;
    notifyListeners();
  }


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

    try {
      DateFormat('dd-MM-yyyy').parse(value);
      return null;
    } catch (e) {
      return 'Please enter date in DD-MM-YYYY format';
    }
    // return null;
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
    } else if (value.length != 4) {
      return 'OTP should be 4 digits';
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
      DocumentField(name: "Passport", hint: "Upload Passport Certificate"),
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

  void setSelectedDepartment(Department department) {
    selectedDepartmentId = department.id;
    departmentController.text = department.departmentName;
    notifyListeners();
  }

  /*void setSelectedCountry(Country country) {
    selectedCountryId = country.id;
    countryController.text = country.name;
    notifyListeners();
  }*/

  void setSelectedRank(Rank rank) {
    selectedRankId = rank.id;
    rankController.text = rank.rank;
    notifyListeners();
  }

  String? validateQualification(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your qualification';
    }
    return null;
  }

  void setSelectedQualification(Qualification qualification) {
    selectedQualificationId = qualification.id;
    selectedQualificationName = qualification.qualificationName;
    qualificationController.text = qualification.qualificationName;
    notifyListeners();
  }

  void processDocuments(List<Document> apiDocuments, List<String> settingDocuments) {
    documentFields.clear();
    controllers.clear();
    selectedFilePaths.clear();

    // Match API documents with setting documents
    for (var apiDoc in apiDocuments) {
      if (settingDocuments.contains(apiDoc.documentName)) {
        documentFields.add(DocumentField(
          name: apiDoc.documentName,
          hint: 'Upload ${apiDoc.documentName}',
        ));
        controllers[apiDoc.documentName] = TextEditingController();
        selectedFilePaths[apiDoc.documentName] = apiDoc.uploadedProof;
      }
    }

    notifyListeners();
  }

  void disposeAll() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
  }

  /*void sendEmailOtp(BuildContext context, String email) async {
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
  }*/

  void sendEmailOtp(BuildContext context, String email) async {
    setSendingOtp(true); // Start loading

    final body = {'email': email};

    try {
      await APIManager().apiRequest(
        context,
        API.emailOTP,
            (response) {
          setSendingOtp(false); // Stop loading
          if (response is CommonResponse && response.n == 1) {
            markOtpSent(true);
            startOtpTimer();
            ShowDialogs.showToast(response.message);
          } else {
            ShowDialogs.showToast(response.message);
          }
        },
            (error) {
          setSendingOtp(false); // Stop loading
          ShowDialogs.showToast('Error sending OTP: $error');
        },
        jsonval: jsonEncode(body),
      );
    } catch (e) {
      setSendingOtp(false); // Stop loading
      ShowDialogs.showToast('Unexpected error: $e');
    }
  }

  Future<void> verifyEmailOtp(BuildContext context, String email) async {
    setVerifyingOtp(true);
    try {
      final requestBody = {
        "email": email,
        "otp": otpController.text,
      };

      await APIManager().apiRequest(
        context,
        API.verifyEmailOTP,
            (response) {
          setVerifyingOtp(false);
          if (response is CommonResponse) {
            if (response.n == 1) {
              ShowDialogs.showToast(response.msg);
              isEmailVerified = true;
              notifyListeners();
            } else {
              ShowDialogs.showToast(response.msg);
            }
          }
        },
            (error) {
          setVerifyingOtp(false);
          ShowDialogs.showToast('OTP verification failed: ${error.toString()}');
        },
        jsonval: json.encode(requestBody),
      );
    } catch (e) {
      setVerifyingOtp(false);
      ShowDialogs.showToast('Error verifying OTP: ${e.toString()}');
    }
  }

  /*Future<void> verifyEmailOtp(BuildContext context, String email) async {
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
  }*/

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

  /*Future<void> registerCandidate(BuildContext context) async {
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
  }*/

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
        API.registerCandidate,
            (response) {
          if (response is CommonResponse) {
            if (response.n == 1) {
              // Success case - new registration
              ShowDialogs.showToast(response.msg);
              _registeredCandidate = Candidate.fromJson(response.data);
            } else if (response.msg.toLowerCase().contains('email already exists') ?? false) {
              // Email exists but we'll proceed since it's verified
              if (isEmailVerified) {
                // Create a dummy candidate with just the email to proceed
                /*_registeredCandidate = Candidate(
                  id: 0.toString(),
                  email: emailController.text.trim(),
                );*/
                //ShowDialogs.showToast('Using existing verified email');
              } else {
                throw Exception(response.msg);
              }
            } else {
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
      rethrow;
    } finally {
      _isRegistering = false;
      notifyListeners();
    }
  }

  Future<void> saveCandidateDetails(BuildContext context) async {
    print('Selected Country ID: $selectedCountryId');

    try {
      _isSavingDetails = true;
      notifyListeners();

      if (_registeredCandidate?.id == null) {
        throw Exception('Candidate ID not found');
      }

      // Convert date format from DD-MM-YYYY to YYYY-MM-DD
      String formattedDob = '';
      if (dobController.text.isNotEmpty) {
        try {
          final parsedDate = DateFormat('dd-MM-yyyy').parse(dobController.text);
          formattedDob = DateFormat('yyyy-MM-dd').format(parsedDate);
        } catch (e) {
          throw Exception('Invalid date format. Please use DD-MM-YYYY');
        }
      }

      final requestBody = {
        "id": _registeredCandidate!.id,
        "passport_number": passportController.text.trim(),
        "department": selectedDepartmentId?.toString(),
        "rank": selectedRankId?.toString(),
        "dob": formattedDob,
        "country": selectedCountryId?.toString(),
        "pincode": pincodeController.text.trim(),
        "highest_qualification": selectedQualificationId, // Update if you have this field
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

  /*Future<void> fetchAllFormData(BuildContext context) async {
    try {
      _isOverallLoading = true;
      notifyListeners();

      // Fetch all data in parallel
      await Future.wait([
        fetchDepartments(context),
        fetchCountries(context),
        fetchQualifications(context),
      ]);
    } finally {
      _isOverallLoading = false;
      notifyListeners();
    }
  }*/
  Future<void> fetchAllFormData(BuildContext context) async {
    try {
      _isOverallLoading = true;
      _isInitialLoadComplete = false;
      notifyListeners();

      // Reset errors
      _departmentError = null;
      _countryError = null;
      _rankError = null;
      qualificationError = null;

      // Fetch all data in parallel
      await Future.wait([
        fetchDepartments(context),
        fetchCountries(context),
        fetchQualifications(context),
      ]);

      _isInitialLoadComplete = true;
    } catch (e) {
      // Handle any unexpected errors
      debugPrint('Error loading form data: $e');
    } finally {
      _isOverallLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDepartments(BuildContext context) async {
    try {
      _departmentError = null;
      await APIManager().apiRequest(
        context,
        API.departmentlist,
            (response) {
          if (response is DepartmentListResponse) {
            _departments = response.data;
          } else {
            _departmentError = 'Unexpected response format';
          }
        },
            (error) {
          _departmentError = 'Failed to load departments: ${error.toString()}';
        },
      );
    } catch (e) {
      _departmentError = 'Failed to load departments ${e.toString()}';
    }
  }

  Future<void> fetchCountries(BuildContext context) async {
    try {
      _countryError = null;
      await APIManager().apiRequest(
        context,
        API.countrylist,
            (response) {
          if (response is CountryListResponse) {
            _countries = response.data.where((c) => c.isActive).toList();
          } else {
            _countryError = 'Unexpected response format';
          }
        },
            (error) {
          _countryError = 'Failed to load countries: ${error.toString()}';
        },
      );
    } catch (e) {
      _countryError = 'Failed to load countries ${e.toString()}';
    }
  }

  Future<void> fetchRanks(BuildContext context, int departmentId) async {
    try {
      _rankError = null;
      _ranks.clear();
      final requestBody = json.encode({"departmentid": departmentId.toString()});

      await APIManager().apiRequest(
        context,
        API.getdeptwiseranklist,
            (response) {
          if (response is RankListResponse) {
            _ranks = response.data.where((r) => r.isActive).toList();
          }
        },
            (error) {
          _rankError = 'Failed to load ranks: ${error.toString()}';
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _rankError = 'Failed to load ranks';
    }
  }

  Future<void> fetchQualifications(BuildContext context) async {
    try {
      qualificationError = null;
      await APIManager().apiRequest(
        context,
        API.getqualifications,
            (response) {
          if (response is QualificationListResponse) {
            qualifications = response.data;
          } else {
            qualificationError = 'Unexpected response type: ${response.runtimeType}';
          }
        },
            (error) {
          qualificationError = 'Failed to load qualifications: ${error.toString()}';
        },
      );
    } catch (e) {
      qualificationError = 'Failed to load qualifications: $e';
    }
  }

  /*Future<void> fetchDepartments(BuildContext context) async {
    try {
      _isLoadingDepartments = true;
      _departmentError = null;
      notifyListeners();

      await APIManager().apiRequest(
        context,
        API.departmentlist,
            (response) {
          if (response is DepartmentListResponse) {
            _departments = response.data;
          } else {
            _departmentError = 'Unexpected response format';
          }
        },
            (error) {
          _departmentError = 'Failed to load departments: ${error.toString()}';
        },
      );
    } catch (e) {
      _departmentError = 'Failed to load departments ${e.toString()}';
    } finally {
      _isLoadingDepartments = false;
      notifyListeners();
    }
  }

  Future<void> fetchCountries(BuildContext context) async {
    try {
      _isLoadingCountries = true;
      _countryError = null;
      notifyListeners();

      await APIManager().apiRequest(
        context,
        API.countrylist,
            (response) {
          if (response is CountryListResponse) {
            _countries = response.data.where((c) => c.isActive).toList();
          } else {
            _countryError = 'Unexpected response format';
          }
        },
            (error) {
          _countryError = 'Failed to load countries: ${error.toString()}';
        },
      );
    } catch (e) {
      _countryError = 'Failed to load countries ${e.toString()}';
    } finally {
      _isLoadingCountries = false;
      notifyListeners();
    }
  }

  Future<void> fetchRanks(BuildContext context, int departmentId) async {
    try {
      _isLoadingRanks = true;
      _rankError = null;
      _ranks.clear();
      notifyListeners();

      final requestBody = json.encode({"departmentid": departmentId.toString()});

      await APIManager().apiRequest(
        context,
        API.getdeptwiseranklist,
            (response) {
          if (response is RankListResponse) {
            _ranks = response.data.where((r) => r.isActive).toList();
          }
        },
            (error) {
          _rankError = 'Failed to load ranks: ${error.toString()}';
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _rankError = 'Failed to load ranks';
    } finally {
      _isLoadingRanks = false;
      notifyListeners();
    }
  }

  Future<void> fetchQualifications(BuildContext context) async {
    try {
      isLoadingQualifications = true;
      qualificationError = null;
      notifyListeners();

      print('Fetching qualifications...');

      await APIManager().apiRequest(
        context,
        API.getqualifications,
            (response) {
          try {
            print('Raw API response: $response');
            print('Response type: ${response.runtimeType}');

            // ✅ response is already QualificationListResponse
            if (response is QualificationListResponse) {
              qualifications = response.data;
              qualificationError = null;
              print('Successfully loaded ${qualifications.length} qualifications');
            } else {
              qualificationError = 'Unexpected response type: ${response.runtimeType}';
            }
          } catch (e) {
            print('Parsing error: $e');
            qualificationError = 'Failed to parse qualifications: $e';
          }
          notifyListeners();
        },
            (error) {
          print('API error: $error');
          qualificationError = 'Failed to load qualifications: ${error.toString()}';
          notifyListeners();
        },
      );
    } catch (e) {
      print('Exception in fetchQualifications: $e');
      qualificationError = 'Failed to load qualifications: $e';
      notifyListeners();
    } finally {
      isLoadingQualifications = false;
      notifyListeners();
    }
  }*/

  Future<void> fetchDocuments() async {
    try {
      isLoadingDocuments = true;
      documentError = null;
      notifyListeners();

      final requestBody = json.encode({
        "candidateid": _registeredCandidate!.id,
      });

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getDocuments,
            (response) {
          try {
            documents.clear();

            // Handle DocumentListResponse case
            if (response is DocumentListResponse) {
              documents.addAll(response.data);
              print('Received ${documents.length} documents from DocumentListResponse');
            }
            // Handle Map response
            else if (response is Map<String, dynamic>) {
              // Process proof_data
              if (response['data']?['proof_data'] is List) {
                documents.addAll(
                    (response['data']['proof_data'] as List)
                        .map((docJson) => Document.fromJson(docJson))
                        .toList()
                );
              }

              // Process education_document_data
              if (response['data']?['education_document_data'] is Map) {
                final eduDoc = response['data']['education_document_data'];
                documents.add(Document.fromJson(eduDoc, isEducation: true));
              }
            }
            // Handle String response
            else if (response is String) {
              final parsed = json.decode(response);
              if (parsed['data']?['proof_data'] is List) {
                documents.addAll(
                    (parsed['data']['proof_data'] as List)
                        .map((docJson) => Document.fromJson(docJson))
                        .toList()
                );
              }
              if (parsed['data']?['education_document_data'] is Map) {
                final eduDoc = parsed['data']['education_document_data'];
                documents.add(Document.fromJson(eduDoc, isEducation: true));
              }
            }

            // Print debug info
            print('Total documents found: ${documents.length}');
            for (var doc in documents) {
              print('Document: ${doc.documentName}, Uploaded: ${doc.uploadedProof ?? "Not uploaded"}');
            }

            // Initialize controllers
            for (var doc in documents) {
              controllers[doc.documentName] = TextEditingController();
              selectedFilePaths[doc.documentName] = doc.uploadedProof;
            }
          } catch (e) {
            print('Error processing documents: $e');
            documentError = 'Failed to process documents: $e';
          }
        },
            (error) {
          print('API Error: $error');
          documentError = 'Failed to load documents: ${error.toString()}';
        },
        jsonval: requestBody,
      );
    } catch (e) {
      print('Exception in fetchDocuments: $e');
      documentError = 'Failed to load documents: $e';
    } finally {
      isLoadingDocuments = false;
      notifyListeners();
    }
  }

  Future<void> uploadDocuments(BuildContext context) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      // Prepare the multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(await APIManager().apiEndPoint(API.documentsUpload))
      );

      // Add user ID and certificate name
      request.fields['user_id'] = "['${_registeredCandidate!.id}']";
      request.fields['certificate_name'] = 'PHD'; // Or dynamic from input

      // Prepare doc_id and doc_name lists
      List<String> docIds = [];
      List<String> docNames = [];

      for (var doc in documents) {
        final filePath = selectedFilePaths[doc.documentName];
        if (filePath != null && filePath.isNotEmpty) {
          if (doc.isEducationDocument) {
            request.files.add(await http.MultipartFile.fromPath(
              'educational_certificate_upload',
              filePath,
            ));
          } else {
            request.fields['doc_id'] = '[\'${doc.id}\']';
            request.fields['doc_name'] = '[\'${doc.documentName}\']';

            request.files.add(await http.MultipartFile.fromPath(
              'document_file_upload',
              filePath,
            ));
          }
        } else {
          print('No file selected for ${doc.documentName}');
        }
      }

      // Add the collected doc_id and doc_name arrays
      if (docIds.isNotEmpty && docNames.isNotEmpty) {
        request.fields['doc_id'] = "['${docIds.join("','")}']";
        request.fields['doc_name'] = "['${docNames.join("','")}']";
      }

      // Add auth token if needed
      final token = await SPManager().getAuthToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Debug print request details
      print('\nRequest Details:');
      print('URL: ${request.url}');
      print('Method: ${request.method}');
      print('Headers: ${request.headers}');
      print('Fields:');
      request.fields.forEach((key, value) {
        print('  $key: $value');
      });
      print('Files:');
      for (var file in request.files) {
        print('  ${file.field}: ${file.filename} (${file.length} bytes)');
      }

      // Send request
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
          print('\nSuccess: ${jsonResponse['msg']}');
          // Show the success message that's already defined in the UI
          Provider.of<StepProvider>(context, listen: false).submit();
        } else {
          final errorMsg = jsonResponse['msg'] ?? 'Failed to upload documents';
          print('\nError: $errorMsg');
          throw Exception(errorMsg);
        }
      } else {
        final errorMsg = 'Upload failed with status ${response.statusCode}: ${response.reasonPhrase}';
        print('\n$errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
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
 Map<String, dynamic> createOTPVerificationRequestBody(String email) {
    return {
      "email": email,
       "otp":otpController.text
    };
  }
  //otp verification
 bool _isSendOTPLoading = false;
  bool get isSendOTPLoading => _isSendOTPLoading;
  set isSendOTPLoading(bool value) {
    _isSendOTPLoading = value;
    notifyListeners();
  }

   forgetPasswordOTPVerification(String email) async {
    isSendOTPLoading=true;
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createOTPVerificationRequestBody(email);
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.sendpasswordverificationotp,
          (response) async {
        OtpVerificationResponse resp = response;

        if(resp.n==1)
        {
        ShowDialogs.showToast(resp.msg);
        Navigator.of(routeGlobalKey.currentContext!)
                              .pushNamed(
                            ChangePasswordScreen.route,
                          arguments:{
                            'email':email,
                            'comingFrom':"1"
                          }
                          );
                           isSendOTPLoading=false;
                           notifyListeners();
        }else{
 ShowDialogs.showToast(resp.msg);
 isSendOTPLoading=false;
                           notifyListeners();
        }
      }, (error) {
        print('ERR msg is $error');
isSendOTPLoading=false;
                           notifyListeners();
        ShowDialogs.showToast("Server Not Responding");
      }, jsonval:  json.encode(jsonbody),);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
       isSendOTPLoading=false;
                           notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
//channge password
 bool _ischangepasswordLoading = false;
  bool get ischangepasswordLoading => _ischangepasswordLoading;
  set ischangepasswordLoading(bool value) {
    _ischangepasswordLoading = value;
    notifyListeners();
  }
 Map<String, dynamic> createChangePasswordRequestBody(String email) {
    return {
      "email": email,
       "password":passwordController.text
    };
  }
   changepassword(String email) async {
    var status1 = await ConnectionDetector.checkInternetConnection();
ischangepasswordLoading=true;
    if (status1) {
      dynamic jsonbody = createChangePasswordRequestBody(email);
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.setpassword,
          (response) async {
        OtpVerificationResponse resp = response;

        if(resp.n==1)
        {
        ShowDialogs.showToast(resp.msg);
        Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed(
                                PasswordResetSuccessScreen.route,
                                arguments: {
                                  'selectedPos': -1,
                                  'isSignUp': false,
                                },
                              );
                              ischangepasswordLoading=false;
                              notifyListeners();
        }else{
 ShowDialogs.showToast(resp.msg);
  ischangepasswordLoading=false;
                              notifyListeners();
        }
      }, (error) {
        print('ERR msg is $error');
 ischangepasswordLoading=false;
                              notifyListeners();
        ShowDialogs.showToast("Server Not Responding");
      }, jsonval:  json.encode(jsonbody),);
    } else {
       ischangepasswordLoading=false;
                              notifyListeners();
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
