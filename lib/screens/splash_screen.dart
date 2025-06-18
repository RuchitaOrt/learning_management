import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/VersionInfo.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/GlobalLists.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SignInScreen(),
      ),
    );
  }

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
            Center(
              child: SvgPicture.asset(
                LMSImagePath.splashLogo,
                height: height / 8,
                width: height / 8,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
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
          ],
        ),
      ),
    );
  }
}
