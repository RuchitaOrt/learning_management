// search_provider.dart
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  bool get isSearchFocused => _isSearchFocused;

  List<String> _recentSearches = [
    "Maritime Safety",
    "Navigation Courses",
    "STCW Training",
    "Engine Room Simulator"
  ];

  final List<String> _popularSearches = [
    "GMDSS Certification",
    "Marine Engineering",
    "Port Management",
    "Ship Security",
    "Maritime Law",
    "Tanker Operations"
  ];

  List<String> get recentSearches => _recentSearches;
  List<String> get popularSearches => _popularSearches;

  void clearRecentSearches() {
    _recentSearches = [];
    notifyListeners();
  }

  void addRecentSearch(String query) {
    if (!_recentSearches.contains(query)) {
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) {
        _recentSearches = _recentSearches.sublist(0, 5);
      }
      notifyListeners();
    }
  }

  void setSearchFocus(bool focused) {
    _isSearchFocused = focused;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}