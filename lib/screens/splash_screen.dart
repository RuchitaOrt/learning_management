import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/UtilityFile.dart';
import 'package:learning_mgt/Utils/VersionInfo.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/GlobalLists.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Utils/SPManager.dart';
import '../main.dart';
import 'HomePage.dart';
import 'TabScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  Timer? _navigationTimer;
  String versionText = "";

  @override
  void initState() {
    super.initState();
     
    WidgetsBinding.instance.addObserver(this);
   
 Utility().loadAPIConfig(context);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _startNavigationFallback();
  }

  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _startNavigationFallback() {
    _navigationTimer = Timer(const Duration(seconds: 5), () async {
      _navigateToFallback();
    });
  }

  void _navigateToFallback() async {
    final token = await SPManager().getAuthToken();
    if (token == null || token.isEmpty) {
      // No token found, navigate to SignInScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SignInScreen(),
        ),
      );
    } else {
      // Valid token exists, navigate to HomePage
      Navigator.of(routeGlobalKey.currentContext!).pushNamed(
        TabScreen.route,
        arguments: {
          'selectedPos': -1,
          'isSignUp': false,
        },
      );
    }
  }

  /*void _navigateToFallback() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SignInScreen(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: AppDecorations.gradientBackground,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: Center(
                child: SvgPicture.asset(
                  LMSImagePath.splashLogo,
                  height: height / 6,
                  width: height / 6,
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Text(
                  "Version :${GlobalLists.versionNumber}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: LearningColors.darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
