import 'dart:convert';

import 'package:flutter/material.dart';

import '../Utils/APIManager.dart';

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
    required Function onSuccess,
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

      // Remove null values from the request body
      requestBody.removeWhere((key, value) => value == null);

      APIManager().apiRequest(
        context,
        API.savePayment,
            (response) {
          _isLoading = false;
          notifyListeners();
          onSuccess();
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
      onError(e.toString());
    }
  }
}