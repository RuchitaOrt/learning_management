

import 'package:flutter/material.dart';


class LandingScreenProvider with ChangeNotifier {
 
  bool _isSearchIconVisible = false;

  bool get isSearchIconVisible => _isSearchIconVisible;
  set isSearchIconVisible(bool value) {
    _isSearchIconVisible = value;
  }

}


