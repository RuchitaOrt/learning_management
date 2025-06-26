import 'package:flutter/material.dart';

class StepProvider with ChangeNotifier {
  int _currentStep = 0;
  bool _isSubmitted = false;

  int get currentStep => _currentStep;
  bool get isSubmitted => _isSubmitted;

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void submit() {
    _isSubmitted = true;
    notifyListeners();
  }

  void reset() {
    _currentStep = 0;
    _isSubmitted = false;
    notifyListeners();
  }
}