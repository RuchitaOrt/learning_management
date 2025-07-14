import 'dart:convert';
import 'dart:io';

import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/APIManager.dart';
import 'package:learning_mgt/Utils/SPManager.dart';
import 'package:learning_mgt/Utils/internetConnection.dart';

import 'package:learning_mgt/Utils/regex_helper.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetCandidateDocuments.dart';
import 'package:learning_mgt/model/GetGeneralDetails.dart';
import 'package:learning_mgt/model/GetSeafarer.dart';
import 'package:learning_mgt/model/OtpVerificationResponse.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

import '../model/RegistrationResponse.dart';

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

  Future<void> uploadProfileDocuments(
      BuildContext context, String filePath) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      // Prepare the multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(await APIManager()
              .apiEndPoint(API.updatecandidateprofilepicture)));

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

  Future<void> updateSeafarerDetails(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final requestBody = json.encode({
        "seaman_book_number": seafarersNoController.text,
        "passport_number": passportNoController.text,
        "department": departmentController.text,
        "rank": rankController.text,
        "pincode": pinCodeController.text,
        "country": countryController.text,
        "state": stateController.text,
        "city": cityController.text,
        "coc": COCController.text,
      });

      await APIManager().apiRequest(
        context,
        API.updateSeafarerDetails,
        (response) {
          try {
            if (response is CommonResponse) {
              _handleCommonResponse(response, context);
            } else if (response is Map<String, dynamic>) {
              _handleCommonResponse(CommonResponse.fromJson(response), context);
            } else if (response is String) {
              final parsed = json.decode(response);
              _handleCommonResponse(CommonResponse.fromJson(parsed), context);
            } else {
              ShowDialogs.showToast(
                  'Unexpected response type: ${response.runtimeType}');
            }
          } catch (e) {
            ShowDialogs.showToast('Parse error: ${e.toString()}');
          }
        },
        (error) {
          ShowDialogs.showToast('API Error: ${error.toString()}');
        },
        jsonval: requestBody,
      );
    } catch (e) {
      ShowDialogs.showToast('Unexpected error: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleCommonResponse(CommonResponse response, BuildContext context) {
    if (response.status) {
      ShowDialogs.showToast('Details updated successfully');
    } else {
      ShowDialogs.showToast(response.message);
    }
  }

  List<Document> documents = [];
  bool isLoadingDocuments = false;
  Map<String, TextEditingController> controllers = {};
  Map<String, String?> selectedFilePaths = {};
  Future<void> fetchDocuments() async {
    try {
      isLoadingDocuments = true;
      notifyListeners();

      final requestBody = "";

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getcandidatemandatorydocument,
        (response) {
          try {
            print('Raw response: ${response.data}');

            /// 🔥 Correct Parsing Step
            // final parsedResponse = GetCandidateDocuments.fromJson(response.data);

            final candidateData = response.data;
            if (candidateData == null) {
              print('No candidate data found.');
              return;
            }

            List<EligibilityDocument> eligibilityDocs =
                candidateData.eligibilityDocuments;
            EducationalDocument? educationDoc =
                candidateData.educationalDocuments;

            documents.clear();

            /// ✅ Add eligibility documents
            // for (var item in eligibilityDocs) {
            //   documents.add(
            //     Document(
            //       id: item.id ?? 0,
            //       documentName: item.documentName ?? 'Untitled',
            //       isActive: item.isActive ?? true,
            //       uploadedProof: item.uploadedProof,
            //     ),
            //   );
            // }

            // /// ✅ Add educational document
            // if (educationDoc != null) {
            //   documents.add(
            //     Document(
            //       id: educationDoc.id ?? 0,
            //       documentName: educationDoc.qualificationName ?? 'Educational Document',
            //       isActive: educationDoc.isActive ?? true,
            //       uploadedProof: educationDoc.uploadedCertificate,
            //       isEducationDocument: true,
            //     ),
            //   );
            // }
// Handle eligibility documents
            if (candidateData.eligibilityDocuments != null) {
              for (var item in candidateData.eligibilityDocuments) {
                documents.add(Document(
                  id: item.id ?? 0,
                  documentName: item.documentName ?? 'Untitled',
                  isActive: item.isActive ?? true,
                  uploadedProof: item.uploadedProof,
                ));
              }
            }

// Handle educational document
            if (candidateData.educationalDocuments != null) {
              final edu = candidateData.educationalDocuments!;
              documents.add(Document(
                id: edu.id ?? 0,
                documentName: edu.qualificationName ?? 'Educational Document',
                isActive: edu.isActive ?? true,
                uploadedProof: edu.uploadedCertificate,
                isEducationDocument: true,
              ));
            }

// ✅ Handle dynamic "proofdata" if exists
            if (response.data['proofdata'] != null &&
                response.data['proofdata'] is Map) {
              final proofData = response.data['proofdata'];
              documents.add(Document(
                id: proofData['id'] ?? 0,
                documentName: proofData['proof_name'] ?? 'Proof Document',
                isActive: proofData['isActive'] ?? true,
                uploadedProof: proofData['uploaded_proof'],
                isEducationDocument: false, // optional flag
              ));
            }

            /// 🎯 Init controllers
            for (var doc in documents) {
              controllers[doc.documentName] = TextEditingController();
              selectedFilePaths[doc.documentName] = doc.uploadedProof;
            }

            print('Documents loaded: ${documents.length}');
          } catch (e) {
            print('Error processing documents: $e');
          }
        },
        (error) {
          print('API Error: $error');
        },
        jsonval: requestBody,
      );
    } catch (e) {
      print('Exception in fetchDocuments: $e');
    } finally {
      isLoadingDocuments = false;
      notifyListeners();
    }
  }

  Map<String, PlatformFile?> selectedFiles = {};
  Future<void> uplodDocumentsAPI(BuildContext context) async {
    try {
      _isSavingDetails = true;
      notifyListeners();

      // Prepare the multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              await APIManager().apiEndPoint(API.uploadcandidatedocuments)));
      final candidateId = await SPManager().getUserId();
      // Add user ID and certificate name
      request.fields['user_id'] = "['${candidateId}']";
      request.fields['certificate_name'] = 'PHD'; // Or dynamic from input

      // Prepare doc_id and doc_name lists
      List<String> docIds = [];
      List<String> docNames = [];
      print("selectedFilePaths length");
      print('Total documents: ${documents.length}');

      for (final doc in documents) {
        print("selectedFilePaths length");
        final PlatformFile? selectedFile = selectedFiles[doc.documentName];
        print("RUCHOTA length");
        print(doc.documentName);
        print(selectedFile);
        List<String> docIds = [];
        List<String> docNames = [];
        Set<String> uploadedDocNames = {};

        for (final doc in documents) {
          final PlatformFile? selectedFile = selectedFiles[doc.documentName];

          if (selectedFile != null &&
              selectedFile.path != null &&
              !uploadedDocNames.contains(doc.documentName)) {
            final filePath = selectedFile.path!;
            uploadedDocNames.add(doc.documentName);

            docIds.add("${doc.id}");
            docNames.add("${doc.documentName}");

            request.files.add(
              await http.MultipartFile.fromPath(
                'document_file_upload',
                filePath,
              ),
            );
          }
        }

        if (docIds.isNotEmpty && docNames.isNotEmpty) {
          request.fields['doc_id'] =
              "[${docIds.map((id) => "'$id'").join(', ')}]";
          request.fields['doc_name'] =
              "[${docNames.map((name) => "'$name'").join(', ')}]";
        }
        // Only send if the file was selected locally and is not from a URL
        // if (selectedFile != null && selectedFile.path != null && (doc.uploadedProof == null || doc.uploadedProof!.isEmpty)) {
        //   final filePath = selectedFile.path!;

        //   request.fields.putIfAbsent('doc_id', () => '[]');
        //   request.fields.putIfAbsent('doc_name', () => '[]');

        //   // Append to existing array-like string
        //   final existingIds = request.fields['doc_id']!.replaceAll(RegExp(r'[\[\]\']'), '');
        //   final existingNames = request.fields['doc_name']!.replaceAll(RegExp(r'[\[\]\']'), '');

        //   final updatedIds = existingIds.isEmpty ? "'${doc.id}'" : "$existingIds, '${doc.id}'";
        //   final updatedNames = existingNames.isEmpty ? "'${doc.documentName}'" : "$existingNames, '${doc.documentName}'";

        //   request.fields['doc_id'] = "[$updatedIds]";
        //   request.fields['doc_name'] = "[$updatedNames]";

        //   request.files.add(await http.MultipartFile.fromPath(
        //     'document_file_upload',
        //     filePath,
        //   ));
        // }
      }
      // for (var doc in documents) {
      //   print(doc.documentName);
      //   final filePath = selectedFilePaths[doc.documentName];
      //     print("filePath");
      //   print(filePath);
      //   if (filePath != null && filePath.isNotEmpty) {
      //     if (doc.isEducationDocument) {
      //       request.files.add(await http.MultipartFile.fromPath(
      //         'educational_certificate_upload',
      //         filePath,
      //       ));
      //     } else {
      //       request.fields['doc_id'] = '[\'${doc.id}\']';
      //       request.fields['doc_name'] = '[\'${doc.documentName}\']';

      //       request.files.add(await http.MultipartFile.fromPath(
      //         'document_file_upload',
      //         filePath,
      //       ));
      //     }
      //   } else {
      //     print('No file selected for ${doc.documentName}');
      //   }
      // }

      // Add the collected doc_id and doc_name arrays
      if (docIds.isNotEmpty && docNames.isNotEmpty) {
        print('docIds for ${docIds}');
        request.fields['doc_id'] = "['${docIds.join("','")}']";
        request.fields['doc_name'] = "['${docNames.join("','")}']";
      }
      print(request.fields);
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
          ShowDialogs.showToast(jsonResponse['msg']);
        } else {
          final errorMsg = jsonResponse['msg'] ?? 'Failed to upload documents';
          print('\nError: $errorMsg');
          throw Exception(errorMsg);
        }
      } else {
        final errorMsg =
            'Upload failed with status ${response.statusCode}: ${response.reasonPhrase}';
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

  bool _isSeafarerLoading = false;
  bool get isSeafarerLoading => _isSeafarerLoading;

  // Set loading state
  set isSeafarerLoading(bool value) {
    _isSeafarerLoading = value;
    notifyListeners();
  }

  SeafarerData? _seafarerList;

  // Getter for data
  SeafarerData get seafarerList => _seafarerList!;
  set seafarerList(SeafarerData data) {
    _seafarerList = data;
    notifyListeners();
  }

  Future<void> getSeafarerListAPI() async {
    var status1 = await ConnectionDetector.checkInternetConnection();
    print("Seafaerer 1 ${_isSeafarerLoading}");
    _isSeafarerLoading = true;
    notifyListeners();
    print("Seafaerer 2 ${_isSeafarerLoading}");
    if (status1) {
      dynamic jsonbody = "";

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getseafarersdetails,
        (response) async {
          GetSeafarer resp = response;
          if (resp.n == 1) {
            seafarerList = resp.data!;
            seafarersNoController.text = seafarerList.seamanBookNumber ?? "";
            passportNoController.text = seafarerList.passportNumber ?? "";
            departmentController.text = seafarerList.departmentName ?? "";
            rankController.text = seafarerList.rankName ?? "";
            pinCodeController.text = seafarerList.pincode ?? "";
            countryController.text = seafarerList.countryName ?? "";
            cityController.text = seafarerList.cityName ?? "";
            stateController.text = seafarerList.stateName ?? "";
            COCController.text = seafarerList.coc ?? "";
            _isSeafarerLoading = false;
            notifyListeners();
          }
          _isSeafarerLoading = false;
          notifyListeners();
          print("Seafaerer 3 ${_isSeafarerLoading}");
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          _isSeafarerLoading = false;

          notifyListeners();
          print("Seafaerer 4 ${_isSeafarerLoading}");
          ShowDialogs.showToast("Server Not Responding");
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      _isSeafarerLoading = false;
      notifyListeners();
      print("Seafaerer 5 ${_isSeafarerLoading}");
      ShowDialogs.showToast("Please check internet connection");

      return Future.error("No Internet Connection");
    }
  }
}
