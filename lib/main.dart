import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_mgt/provider/CertificateProvider.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/RecommendedCourseProvider.dart';
import 'package:learning_mgt/provider/ResultProvider.dart';
import 'package:learning_mgt/provider/StepProvider.dart';

import 'package:learning_mgt/provider/TrainingProvider.dart';
import 'package:learning_mgt/provider/faqprovider.dart';
// import 'package:learning_mgt/provider/feedbackprovider.dart';
import 'package:learning_mgt/provider/instituteprovider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/provider/sign_In_provider.dart';
import 'package:learning_mgt/provider/sign_up_provider.dart';
import 'package:learning_mgt/routes/routers.dart';
import 'package:learning_mgt/screens/splash_screen.dart';
import 'package:learning_mgt/widgets/GlobalLists.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> routeGlobalKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
class MyApp extends StatefulWidget {
  const MyApp() : super();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }
Future<void> _getAppVersion() async {
   
  WidgetsBinding.instance.addPostFrameCallback((_) async {
     PackageInfo packageInfo = await PackageInfo.fromPlatform();
setState(() {
   GlobalLists.versionNumber= packageInfo.version;
});
 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider<PersonalAccountProvider>(
          create: (context) => PersonalAccountProvider(),
        ),
        ChangeNotifierProvider<LandingScreenProvider>(
          create: (context) => LandingScreenProvider(),
        ),
        ChangeNotifierProvider<TrainingProvider>(
          create: (context) => TrainingProvider(),
        ),
        ChangeNotifierProvider<CourseProvider>(
          create: (context) => CourseProvider(),
        ),
        ChangeNotifierProvider<InstituteProvider>(
          create: (context) => InstituteProvider(),
        ),
        ChangeNotifierProvider<FAQProvider>(
          create: (context) => FAQProvider(),
        ),
        // ChangeNotifierProvider<FeedbackProvider>(
        //   create: (context) => FeedbackProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => StepProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StepProvider(),
        ),
        ChangeNotifierProvider<RecommendedCourseProvider>(
          create: (context) => RecommendedCourseProvider(),
        ),
        ChangeNotifierProvider<CertificateCourseprovider>(
          create: (context) => CertificateCourseprovider(),
        ),
        ChangeNotifierProvider<ResultProvider>(
          create: (context) => ResultProvider(),
        ),
        
         ChangeNotifierProvider<InstituteProvider>(
          create: (context) => InstituteProvider(),
        ), 
       ChangeNotifierProvider(
      create: (_) => StepProvider(),
      
    ),
    
      ],
      child: MaterialApp(
        title: 'LMS',
        debugShowCheckedModeBanner: false,
        navigatorKey: routeGlobalKey,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
        ),
        initialRoute: SplashScreen.route,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
