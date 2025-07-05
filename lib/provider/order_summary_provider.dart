import 'dart:convert';
import 'package:flutter/material.dart';
import '../Utils/APIManager.dart';
import '../model/LogoutResponse.dart';

class OrderSummaryProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> savePayment({
    required String courseId,
    required String scheduleId,
    required String trainingCenterId,
    required String candidateId,
    required String countryId,
    required String stateId,
    required String paymentMethod,
    String? transactionId,
    String? cardNumber,
    String? expiryDate,
    String? cvc,
    String? nameOnCard,
    required String amount,
    required BuildContext context,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final requestBody = {
        "courseid": courseId,
        "scheduleid": scheduleId,
        "trainingcenter_id": trainingCenterId,
        "candidateid": candidateId,
        "countryid": countryId,
        "stateid": stateId,
        "payment_method": paymentMethod,
        "transaction_id": transactionId,
        "card_number": cardNumber,
        "expiry_date": expiryDate,
        "cvc": cvc,
        "name_on_card": nameOnCard,
        "amount": amount,
      };

      requestBody.removeWhere((key, value) => value == null);

      await APIManager().apiRequest(
        context,
        API.savePayment,
            (response) {
          _isLoading = false;
          notifyListeners();

          print('Raw API response: ${response?.toString()}');
          print('Response type: ${response?.runtimeType}');

          if (response != null) {
            try {
              // Convert response to PaymentResponse
              final paymentResponse = response is PaymentResponse
                  ? response
                  : PaymentResponse.fromJson(response as Map<String, dynamic>);

              if (paymentResponse.isSuccess) {
                onSuccess(paymentResponse.message);
              } else {
                onError(paymentResponse.message);
              }
            } catch (e) {
              print('Error parsing response: $e');
              onError('Failed to process payment. Please try again.');
            }
          } else {
            onError('Empty server response');
          }
        },
            (error) {
          _isLoading = false;
          notifyListeners();
          onError(error.toString());
        },
        jsonval: jsonEncode(requestBody),
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Payment exception: $e');
      onError('An unexpected error occurred');
    }
  }
}

PaymentResponse paymentResponseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) =>
    json.encode(data.toJson());

class PaymentResponse {
  final int status;
  final String message;
  final Map<String, dynamic> data;

  PaymentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      status: json['n'] as int? ?? 0,  // Maps to 'n' from API
      message: json['msg'] as String? ?? '',  // Maps to 'msg' from API
      data: json['data'] as Map<String, dynamic>? ?? {},  // Maps to 'data' from API
    );
  }

  Map<String, dynamic> toJson() => {
    'n': status,
    'msg': message,
    'data': data,
  };

  bool get isSuccess => status == 1;
}