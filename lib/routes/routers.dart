import 'package:flutter/material.dart';
import 'package:learning_mgt/screens/Ceritification.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/screens/HomePage.dart';
import 'package:learning_mgt/screens/CoursePage.dart';
import 'package:learning_mgt/screens/Recommendation.dart';
import 'package:learning_mgt/screens/ResultScreen.dart';
import 'package:learning_mgt/screens/FeedbackScreen.dart';

import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/TrainingScreen.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/screens/faq_screen.dart';
import 'package:learning_mgt/screens/settingshome.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/screens/splash_screen.dart';

class Routers {
  // Create a static method to configure the router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // To get arguments use settings.arguments
      // Arguments can be passed in the widget calling
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case SignInScreen.route:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      case VerificationScreen.route:
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(),
        );
      case SettingsHome.route:
        return MaterialPageRoute(
          builder: (_) => SettingsHome(),
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case CoursePage.route:
        return MaterialPageRoute(
          builder: (_) => CoursePage(),
        );
      case CourseDetailPage.route:
        return MaterialPageRoute(
          builder: (_) => CourseDetailPage(),
        );
      case TabScreen.route:
        return MaterialPageRoute(
          builder: (_) => TabScreen(),
        );
      case TrainingScreen.route:
        return MaterialPageRoute(
          builder: (_) => TrainingScreen(),
        );
      case Recommendation.route:
        return MaterialPageRoute(
          builder: (_) => Recommendation(),
        );
      case Ceritification.route:
        return MaterialPageRoute(
          builder: (_) => Ceritification(),
        );
      case ResultScreen.route:
        return MaterialPageRoute(
          builder: (_) => ResultScreen(),
        );
      case FAQScreen.route:
        return MaterialPageRoute(
          builder: (_) => FAQScreen(),
        );
      case FeedbackScreen.route:
        return MaterialPageRoute(
          builder: (_) => FeedbackScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
