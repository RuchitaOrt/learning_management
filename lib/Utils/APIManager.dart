import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_mgt/Utils/AppEror.dart';
import 'package:learning_mgt/Utils/SPManager.dart';
import 'package:learning_mgt/model/LoginResponse.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';

enum API {
 
  login,
  logout,
  countrylist,
  departmentlist,
  getqualifications
  
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
        className = "LoginResponse";
        break;
        case API.countrylist:
        className = "LoginResponse";
        break;
        case API.departmentlist:
        className = "LoginResponse";
        break;
        case API.getqualifications:
        className = "LoginResponse";
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
        print(response.body);
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

        jsonResponse = json.decode(response.body);

        if (jsonResponse["status"] == true ||
            jsonResponse["status"] == "success") {
          onSuccess(
              this.parseResponse(this.classNameForAPI(api), jsonResponse));
        } else {
          print("status");
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
