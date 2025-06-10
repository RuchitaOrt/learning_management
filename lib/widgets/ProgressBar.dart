import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double currentPosition;  // Current video position
  final double duration;         // Total video duration

  ProgressBar({
    required this.currentPosition,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentPosition / duration;  // Progress as a fraction of total duration

    return Container(
      width: double.infinity,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[300],  // Background color for the progress bar
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,  // This will determine how much of the bar is filled based on current position
        child: Container(
          height: 5,
          decoration: BoxDecoration(
            color: Colors.green,  // Green color for the progress
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
