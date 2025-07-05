import 'package:flutter/material.dart';
import 'package:learning_mgt/screens/HomePage.dart';

import '../Utils/lms_styles.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String message;

  const PaymentSuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: AppDecorations.gradientBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()), // Replace with your actual landing screen widget
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // White background
                  foregroundColor: Colors.black, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  elevation: 2, // Optional: slight elevation for depth
                ),
                child: const Text('Back to Home'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}