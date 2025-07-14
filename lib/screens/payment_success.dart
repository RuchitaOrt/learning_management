import 'dart:async';
import 'package:flutter/material.dart';
import '../Utils/lms_styles.dart';
import '../main.dart';
import 'TabScreen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String message;

  const PaymentSuccessScreen({super.key, required this.message});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(routeGlobalKey.currentContext!).pushReplacementNamed(
          TabScreen.route,
          arguments: {
            'selectedPos': -1,
            'isSignUp': false,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecorations.gradientBackground,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              Text(
                widget.message,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
