import 'package:flutter/material.dart';
import 'package:learning_mgt/screens/Ceritification.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/screens/HomePage.dart';
import 'package:learning_mgt/screens/CoursePage.dart';
import 'package:learning_mgt/screens/Recommendation.dart';
import 'package:learning_mgt/screens/ResultScreen.dart';
import 'package:learning_mgt/screens/FeedbackScreen.dart';
import 'package:learning_mgt/screens/SavedCoursesScreen.dart';
import 'package:learning_mgt/screens/SupportCenterScreen.dart';
import 'package:learning_mgt/screens/Videoscreen.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/TrainingScreen.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/screens/faq_screen.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/screens/settingshome.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/screens/splash_screen.dart';

import '../screens/OrderSummary.dart';
import '../screens/PaymentScreen.dart';

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
      case ForgotPasswordScreen.route:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case ResetLinkSentScreen.route:
        return MaterialPageRoute(
          builder: (_) => ResetLinkSentScreen(),
        );
      case ChangePasswordScreen.route:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
        );
      case PasswordResetSuccessScreen.route:
        return MaterialPageRoute(
          builder: (_) => PasswordResetSuccessScreen(),
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
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => TabScreen(
            selectedPos:
                args?['selectedPos'] ?? -1, // Default to home instead of 0
            isSignUp: args?['isSignUp'] ?? false,
            selectedModule: args?['selectedModule'] ?? 0,
          ),
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
      case SavedCoursesScreen.route:
        return MaterialPageRoute(
          builder: (_) => SavedCoursesScreen(),
        );
      case ResultScreen.route:
        return MaterialPageRoute(
          builder: (_) => ResultScreen(),
        );
      case FAQScreen.route:
        return MaterialPageRoute(
          builder: (_) => FAQScreen(),
        );
      case CourseEnrollmentScreen.route:
        return MaterialPageRoute(
          builder: (_) => CourseEnrollmentScreen(),
        );
      case OrderSummaryScreen.route:
        return MaterialPageRoute(
          builder: (_) => OrderSummaryScreen(),
        );
      case FeedbackScreen.route:
        return MaterialPageRoute(
          builder: (_) => FeedbackScreen(),
        );
      case SupportCenterScreen.route:
        return MaterialPageRoute(
          builder: (_) => SupportCenterScreen(),
        );
      case VideoScreen.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VideoScreen(
            video: args['video'] ?? '',
            videoTopicSlug: args['videoTopicSlug'] ?? '',
            videoCourseSlug: args['videoCourseSlug'] ?? '',
            videoWatchTime: args['videoWatchTime'] ?? '0',
            isTrailer: args['isTrailer'] ?? false,
            courseID: args['courseID'] ?? '',
            topicID: args['topicID'] ?? '',
            videoCategory: args['videoCategory'] ?? '',
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
