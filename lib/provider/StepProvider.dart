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
// import 'package:flutter/material.dart';

// class StepProvider with ChangeNotifier {
//   int _currentStep =  -1 ;//means no step selected initially
//   bool _isSubmitted = false;

//   int get currentStep => _currentStep;
//   bool get isSubmitted => _isSubmitted;

//   void nextStep() {
//     if (currentStep == -1) {
//       // On Start click
//       _currentStep = 1; // Mark step 0 done, move current to step 1
//     } else if (currentStep < 2) {
//       _currentStep++;
//     }
//     notifyListeners();
//     // if (_currentStep < 2) {
//     //   _currentStep++;
//     //   notifyListeners();
//     // }
//   }
  

//   void previousStep() {
//     if (_currentStep > -1) {
//       _currentStep--;
//       notifyListeners();
//     }
//   }

//   void submit() {
//     _isSubmitted = true;
//     _currentStep = 3;
//     notifyListeners();
//   }

//   void reset() {
//     _currentStep = -1;
//     _isSubmitted = false;
//     notifyListeners();
//   }
// }
// // import 'package:flutter/material.dart';

// class StepProvider extends ChangeNotifier {
//   int _currentStep = -1; // -1 means not started
//   bool _isSubmitted = false;

//   // Separate form keys for each step
//   // final List<GlobalKey<FormState>> formKeys = [
//   //   GlobalKey<FormState>(), // BasicForm
//   //   GlobalKey<FormState>(), // DetailForm
//   //   GlobalKey<FormState>(), // UploadForm
//   // ];

//   int get currentStep => _currentStep;
//   bool get isSubmitted => _isSubmitted;

//   // GlobalKey<FormState> get currentFormKey {
//   //   if (_currentStep < 0 || _currentStep >= formKeys.length) {
//   //     return GlobalKey<FormState>(); // dummy key (should not happen)
//   //   }
//   //   return formKeys[_currentStep];
//   // }

//   void nextStep() {
//     if (_currentStep < formKeys.length - 1) {
//       _currentStep++;
//       notifyListeners();
//     }
//   }

//   void previousStep() {
//     if (_currentStep > 0) {
//       _currentStep--;
//       notifyListeners();
//     }
//   }

//   void submit() {
//     _isSubmitted = true;
//     notifyListeners();
//   }

//   void reset() {
//     _currentStep = -1;
//     _isSubmitted = false;
//     notifyListeners();
//   }
// }
