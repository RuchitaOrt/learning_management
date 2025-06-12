import 'package:flutter/material.dart';

class FAQProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _faqData = [
    {
      'title': "My Account",
      'icon': Icons.account_circle,
      'questions': [
        {
          'question': "Account Opening",
          'answer': "To open an account, click on the 'Sign Up' button and fill in your personal details. You'll need to verify your email address and complete the KYC process.",
        },
        {
          'question': "Account Reactivation", 
          'answer': "If your account has been deactivated, contact our support team with your account details. We'll help you reactivate it after verifying your identity.",
        },
        {
          'question': "Login And Password Reset",
          'answer': "Click 'Forgot Password' on the login screen. Enter your email address and follow the instructions sent to reset your password.",
        },
      ],
    },
    {
      'title': "Trading",
      'icon': Icons.trending_up,
      'questions': [
        {
          'question': "Futures & Options",
          'answer': "Learn about derivatives trading including futures contracts and options. Understand margin requirements and risk management strategies.",
        },
        {
          'question': "Strategy Bot",
          'answer': "Automated trading strategies that execute trades based on predefined conditions. Set up your parameters and let the bot trade for you.",
        },
        {
          'question': "Equity",
          'answer': "Trade stocks and shares of publicly listed companies. Access real-time market data and advanced charting tools.",
        },
      ],
    },
    {
      'title': "Charges / Plans",
      'icon': Icons.payment,
      'questions': [
        {
          'question': "Trade Free Youth Plan",
          'answer': "Special plan for users under 25 years with zero brokerage on equity delivery trades. Valid ID proof required for age verification.",
        },
        {
          'question': "Trade Free Plan",
          'answer': "Zero brokerage plan with monthly subscription fee. Includes unlimited equity delivery trades and discounted intraday rates.",
        },
        {
          'question': "Trade Free Pro Plan",
          'answer': "Premium plan with advanced features including priority customer support, research reports, and exclusive market insights.",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get faqData => _faqData;

  void addFAQCategory(Map<String, dynamic> category) {
    _faqData.add(category);
    notifyListeners();
  }

  void addQuestionToCategory(int categoryIndex, Map<String, dynamic> question) {
    if (categoryIndex >= 0 && categoryIndex < _faqData.length) {
      _faqData[categoryIndex]['questions'].add(question);
      notifyListeners();
    }
  }
}
