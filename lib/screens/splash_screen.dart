import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/VersionInfo.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';


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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Utility().loadAPIConfig(context);
     getAppVersion();
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
        builder: (_) =>  SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
     
      body: Container(
        width: SizeConfig.blockSizeHorizontal *100,
        decoration: AppDecorations.gradientBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              LMSImagePath.splashLogo,
              height: height / 6,
              width: height / 6,
            ),
            const SizedBox(height: 10),
           
          ],
        ),
      ),
    );
  }
}
