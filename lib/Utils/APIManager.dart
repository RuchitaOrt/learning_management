import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_mgt/Utils/AppEror.dart';
import 'package:learning_mgt/Utils/SPManager.dart';
import 'package:learning_mgt/model/GetCertificateResponse.dart';
import 'package:learning_mgt/model/GetCourseCategory.dart';
import 'package:learning_mgt/model/GetCourseDetailListResponse.dart';
import 'package:learning_mgt/model/GetCourseInstitueResponse.dart';
import 'package:learning_mgt/model/GetCourseListResponse.dart';
import 'package:learning_mgt/model/GetRecommdedResponse.dart';
import 'package:learning_mgt/model/GetResourceResponse.dart';
import 'package:learning_mgt/model/GetResultResponse.dart';
import 'package:learning_mgt/model/LoginResponse.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';

import '../model/RegistrationResponse.dart';

enum API {
  login,
  logout,
  countrylist,
  departmentlist,
  getqualifications,
  getdeptwiseranklist,
  emailOTP,
  verifyEmailOTP,
  registerCandidate,
  candidateDetails,
  getDocuments,
  getcoursecategorylist,
  getallcoursesbycategory,
  getcoursedetailsbyid,
  documentsUpload,
  getcourseresources,
  getstatecountry,
  getcourseinstitutions,
  recommendationlist,
  getcertificates,
  getresults
}

enum HTTPMethod { GET, POST, PUT, DELETE }

typedef successCallback = void Function(dynamic response);
typedef progressCallback = void Function(int progress);
typedef failureCallback = void Function(AppError error);

class APIManager {
  static Duration? timeout;
  static String? token;
  static String? baseURL;
  static String? apiVersion;
  var taskId;

  APIManager._privateConstructor();
  static final APIManager _instance = APIManager._privateConstructor();

  factory APIManager() {
    return _instance;
  }

  var url;
  void loadConfiguration(String configString) {
    Map config = jsonDecode(configString);
    var env = config['environment'];
    baseURL = config[env]['hostUrl'];
    apiVersion = config['version'];
    timeout = Duration(seconds: config[env]['timeout']);
    print('load config' + configString);
  }

  void setToken(String value) {
    token = value;
  }

  String apiBaseURL() {
    return baseURL!;
  }

  Future<String> apiEndPoint(API api) async {
    var apiPathString = "";

    switch (api) {
      case API.login:
        apiPathString = "/api/candidate/candidate-login";
        break;

      case API.logout:
        apiPathString = "/api/candidate/candidate-logout";
        break;
      case API.countrylist:
        apiPathString = "/api/candidate/country-list";
        break;
      case API.departmentlist:
        apiPathString = "/api/master/department-list";
        break;
      case API.getqualifications:
        apiPathString = "/api/master/get-qualifications";
        break;
      case API.getdeptwiseranklist:
        apiPathString = "/api/course/getdeptwiseranklist";
        break;
      case API.emailOTP:
        apiPathString = "/api/candidate/sendemail-otp";
        break;
      case API.verifyEmailOTP:
        apiPathString = "/api/candidate/verify-otp";
        break;
      case API.registerCandidate:
        apiPathString = "/api/candidate/register-candidate";
        break;
      case API.candidateDetails:
        apiPathString = "/api/candidate/candidate-details";
        break;
      case API.getDocuments:
        apiPathString = "/api/candidate/get-enrollment-documents";
        break;
      case API.getcoursecategorylist:
        apiPathString = "/api/course/get-course-category-list";
        break;
      case API.getallcoursesbycategory:
        apiPathString = "/api/course/get-allcourses-bycategory";
        break;
      case API.getcoursedetailsbyid:
        apiPathString = "/api/course/get-course-detailsbyid";
        break;
      case API.documentsUpload:
        apiPathString = "/api/candidate/candidate-documents-submit";
        break;
      case API.getcourseresources:
        apiPathString = "/api/course/get-course-resources";
        break;
      case API.getstatecountry:
        apiPathString = "/api/course/get-state-country";
        break;
      case API.getcourseinstitutions:
        apiPathString = "/api/course/get-course-institutions";
        break;
      case API.recommendationlist:
        apiPathString = "/api/course/recommendation-list";
        break;
      case API.getcertificates:
        apiPathString = "/api/candidate/getcertificates";
        break;
      case API.getresults:
        apiPathString = "/api/candidate/getresults";
        break;

      default:
        apiPathString = "/Login";
    }
    print(apiBaseURL());

    return this.apiBaseURL() + apiPathString;
  }

  HTTPMethod apiHTTPMethod(API api) {
    HTTPMethod method;
    switch (api) {
      case API.countrylist:
      case API.departmentlist:
      case API.getqualifications:
      case API.getcoursecategorylist:
      case API.getcertificates:
        method = HTTPMethod.GET;
        break;

      default:
        method = HTTPMethod.POST;
    }
    return method;
  }

  String classNameForAPI(API api) {
    String className;
    switch (api) {
      case API.login:
        className = "LoginResponse";
        break;
      case API.logout:
        className = "CommonResponse";
        break;
      case API.countrylist:
        className = "CountryListResponse";
        break;
      case API.departmentlist:
        className = "DepartmentListResponse";
        break;
      case API.getqualifications:
        className = "QualificationListResponse";

      case API.getdeptwiseranklist:
        className = "RankListResponse";
        break;

      case API.emailOTP:
        className = "OtpResponse";
        break;

      case API.verifyEmailOTP:
        className = "CommonResponse";
        break;
      case API.getDocuments:
        className = "DocumentListResponse";
        break;

      case API.getcoursecategorylist:
        className = "CategoryResponse";
        break;
      case API.getallcoursesbycategory:
        className = "GetCourseListResponse";
        break;
      case API.getcoursedetailsbyid:
        className = "GetCourseDetailListResponse";
        break;
      case API.getcourseresources:
        className = "GetResourceResponse";
        break;
      case API.getstatecountry:
        className = "GetStateResponse";
        break;
      case API.getcourseinstitutions:
        className = "GetCourseInstituteResponse";
        break;
      case API.recommendationlist:
        className = "GetRecommdedResponse";
        break;
      case API.getcertificates:
        className = "GetCertificateResponse";
        break;
      case API.getresults:
        className = "GetResultResponse";
        break;
      default:
        className = 'CommonResponse';
    }
    return className;
  }

  dynamic parseResponse(String className, var json) {
    dynamic responseObj;

    if (className == 'LoginResponse') {
      responseObj = LoginResponse.fromJson(json);
    } else if (className == 'DepartmentListResponse') {
      responseObj = DepartmentListResponse.fromJson(json);
    } else if (className == 'CountryListResponse') {
      responseObj = CountryListResponse.fromJson(json);
    } else if (className == 'RankListResponse') {
      responseObj = RankListResponse.fromJson(json);
    } else if (className == 'QualificationListResponse') {
      responseObj = QualificationListResponse.fromJson(json);
    } else if (className == 'OtpResponse') {
      responseObj = CommonResponse.fromJson(json);
    } else if (className == 'CategoryResponse') {
      responseObj = CategoryResponse.fromJson(json);
    } else if (className == 'GetCourseListResponse') {
      responseObj = CourseListResponse.fromJson(json);
    } else if (className == 'GetCourseDetailListResponse') {
      responseObj = GetCourseDetailListResponse.fromJson(json);
    } else if (className == 'CommonResponse') {
      responseObj = CommonResponse.fromJson(json);
    } else if (className == 'DocumentListResponse') {
      responseObj = DocumentListResponse.fromJson(json);
    } else if (className == 'GetResourceResponse') {
      responseObj = GetResourceResponse.fromJson(json);
    } else if (className == 'GetRecommdedResponse') {
      responseObj = GetRecommdedResponse.fromJson(json);
    } else if (className == 'GetCourseInstituteResponse') {
      responseObj = GetCourseInstituteResponse.fromJson(json);
    } else if (className == 'GetCertificateResponse') {
      responseObj = GetCertificateResponse.fromJson(json);
    } else if (className == 'GetResultResponse') {
      responseObj = GetResultResponse.fromJson(json);
    }

    return responseObj;
  }

  Future<void> apiRequest(BuildContext context, API api,
      successCallback onSuccess, failureCallback onFailure,
      {dynamic parameter,
      dynamic params,
      dynamic path,
      dynamic jsonval}) async {
    var jsonResponse;
    http.Response? response;
    Map<String, String> headers = {};
    String? token = await SPManager().getAuthToken();
    print("token: ${token}");
    print("token: coming");
    // var body = (parameter != null ? json.encode(parameter) : jsonval);
    // String body = json.encode(jsonval);
    var body = jsonval is String ? jsonval : json.encode(jsonval);
    print("body");
    print("bodu" + body);
    url = await this.apiEndPoint(api);
    if (path != null) {
      url = url + path;
      print(url);
    }

    if (token != null && token.isNotEmpty) {
      headers = {
        "Accept": 'application/json',
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };
      print("header is $headers");
    } else {
      headers = {
        "Accept": 'application/json',
        "Content-Type": "application/json",
      };
      // }
    }
    print('URL is $url');

    print("body is $body");

    print("header is $headers");

    try {
      if (this.apiHTTPMethod(api) == HTTPMethod.POST) {
        response =
            await http.post(Uri.parse(url), body: body, headers: headers);
        // .timeout(timeout!);
        if (kDebugMode) {
          final body = response.body;
          const chunkSize = 800;

          for (var i = 0; i < body.length; i += chunkSize) {
            print(body.substring(
                i, i + chunkSize > body.length ? body.length : i + chunkSize));
          }
        }
        // print(response.body);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.GET) {
        //   print(url);
        response =
            await http.get(Uri.parse(url), headers: headers).timeout(timeout!);
        // log('response of get');
        //print(response.body);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.PUT) {
        print('body is -' + body);
        response = await http
            .put(
              Uri.parse(url),
              body: body,
              headers: headers,
            )
            .timeout(timeout!);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.DELETE) {
        response = await http
            .delete(Uri.parse(url), headers: headers)
            .timeout(timeout!);
      }

      //TODO : Handle 201 status code as well
      print('API is ${api}');
      print('Resp is ${response!.statusCode}');

      if (response.statusCode == 200) {
        //logout appi response is not json

        // In apiRequest method:
        if (response.statusCode == 200) {
          try {
            var jsonResponse = json.decode(response.body);
            onSuccess(parseResponse(classNameForAPI(api), jsonResponse));
          } catch (e) {
            var appError =
                parseError("Failed to parse response" as http.Response);
            onFailure(appError);
          }
        }
        jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          onSuccess(
              this.parseResponse(this.classNameForAPI(api), jsonResponse));
        } else {
          print("status");
          print("status: ${jsonResponse["status"]}");
          print("msg: ${jsonResponse["msg"]}");
          print("api $api");
          String message = jsonResponse['message'] ?? 'Unknown Error';
          ShowDialogs.showToast(message);

          if (jsonResponse['errors'] != null) {
            // Assuming 'errors' contains dynamic fields, you can handle them like this:
            Map<String, dynamic> errors = jsonResponse['errors'];

            dynamic dynamicResponse = {
              'message': message,
              'errors': errors,
            };

            // Call onSuccess and return the dynamic response
            onSuccess(dynamicResponse);
          }
        }
      } else if (response.statusCode == 401) {
        ShowDialogs().unAthorizedTokenErrorDialog(context,
            message: "Session expired. Please login again.");
      } else {
        var appError = this.parseError(response);

        onFailure(appError);
      }
    } catch (error) {
      // executed for errors of all types other than Exception
      var appError = FetchDataError(error.toString());
      // FLog.error(
      //     text:
      //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');
      onFailure(appError);
    }
  }

  dynamic parseUploadError(String response, int statusCode) {
    var jsonResponse;
    var message;
    if (response != null && response.length > 0) {
      jsonResponse = json.decode(response);
      if (jsonResponse != null && jsonResponse["status_Message"] != null) {
        message = jsonResponse["status_Message"];
      } else {
        message = response;
      }
    }

    switch (statusCode) {
      case 400:
        return BadRequestError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
        return ShowDialogs.showToast("server Error");
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${statusCode}');
    }
  }

  dynamic parseError(http.Response response) {
    var jsonResponse;
    var message;

    if (response.body != null && response.body.toString().length > 0) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse["desc"] != null) {
        message = jsonResponse["desc"];
      } else {
        message = response.body.toString();
      }
    }

    switch (response.statusCode) {
      case 400:
        return BadRequestError(message);
      case 200:
        return MessageError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
