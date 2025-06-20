import 'package:flutter/material.dart';

class SupportCenterProvider extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controllers for form fields
  final TextEditingController _ticketSubjectController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _attachmentController = TextEditingController();

  // Getters for form key and controllers
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get ticketSubjectController => _ticketSubjectController;
  TextEditingController get priorityController => _priorityController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get attachmentController => _attachmentController;

  // Selected values for dropdowns
  String? _selectedPriority;
  String? _selectedCategory;
  String? _selectedFilePath;
  String? _selectedFileName;

  // Getters for selected values
  String? get selectedPriority => _selectedPriority;
  String? get selectedCategory => _selectedCategory;
  String? get selectedFilePath => _selectedFilePath;
  String? get selectedFileName => _selectedFileName;

  // Priority and Category options
  final List<String> _priorities = ['High', 'Medium', 'Low'];
  final List<String> _categories = ['Category 1', 'Category 2', 'Category 3'];

  List<String> get priorities => _priorities;
  List<String> get categories => _categories;

  // Form submission state
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  // Set selected priority
  void setSelectedPriority(String? priority) {
    _selectedPriority = priority;
    _priorityController.text = priority ?? '';
    notifyListeners();
  }

  // Set selected category
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    _categoryController.text = category ?? '';
    notifyListeners();
  }

  // Set selected file
  void setSelectedFile(String? filePath, String? fileName) {
    _selectedFilePath = filePath;
    _selectedFileName = fileName;
    _attachmentController.text = fileName ?? '';
    notifyListeners();
  }

  // Clear selected file
  void clearSelectedFile() {
    _selectedFilePath = null;
    _selectedFileName = null;
    _attachmentController.clear();
    notifyListeners();
  }

  // Validation methods
  String? validateTicketSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ticket subject is required';
    }
    if (value.trim().length < 5) {
      return 'Ticket subject must be at least 5 characters';
    }
    return null;
  }

  String? validatePriority(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Priority is required';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  String? validateFile(String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      return 'Please select a file';
    }
    return null;
  }

  // Submit form
  Future<bool> submitTicket() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    _isSubmitting = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      // Here you would typically make an API call to submit the ticket
      // Example:
      // await ApiService.submitTicket({
      //   'subject': _ticketSubjectController.text,
      //   'priority': _selectedPriority,
      //   'category': _selectedCategory,
      //   'description': _descriptionController.text,
      //   'attachment': _selectedFilePath,
      // });

      _isSubmitting = false;
      notifyListeners();
      
      // Clear form after successful submission
      clearForm();
      
      return true;
    } catch (e) {
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  // Clear form
  void clearForm() {
    _ticketSubjectController.clear();
    _priorityController.clear();
    _categoryController.clear();
    _descriptionController.clear();
    _attachmentController.clear();
    
    _selectedPriority = null;
    _selectedCategory = null;
    _selectedFilePath = null;
    _selectedFileName = null;
    
    notifyListeners();
  }

  // Reset form validation
  void resetFormValidation() {
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    _ticketSubjectController.dispose();
    _priorityController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _attachmentController.dispose();
    super.dispose();
  }
}
