
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';

class LMSStyles {
  LMSStyles._privateConstructor();
   static const TextStyle tswhiteW600 = TextStyle(
    color: LearningColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 25.0,
  );
   static const TextStyle tsblueW900 = TextStyle(
    color: LearningColors.darkBlue,
    fontWeight: FontWeight.w900,
    fontSize: 16.0,
  );
  static const TextStyle tssecondary550W700 = TextStyle(
    color: LearningColors.secondary550,
    fontWeight: FontWeight.w700,
    fontSize: 25.0,
  );
  static const TextStyle tsWhiteNeutral100W50014 = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static const TextStyle tsSubHeading = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
   static const TextStyle tsWhiteNeutral300W50012 = TextStyle(
    color: LearningColors.black18,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
   static const TextStyle tsHintstyle= TextStyle(
    color: Colors.blueGrey,
    fontWeight: FontWeight.w500,
    fontSize: 11.0,
  );
  static const TextStyle tsblackNeutralbold = TextStyle(
    color: LearningColors.black18,
    fontWeight: FontWeight.w800,
    fontSize: 14.0,
  );
   static const TextStyle tsWhiteNeutral300W300 = TextStyle(
    color: LearningColors.neutral300,
    fontWeight: FontWeight.w300,
    fontSize: 14.0,
  );
   static const TextStyle tsWhiteNeutral50W60016 = TextStyle(
    color: LearningColors.neutral50,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
   static const TextStyle tsHeading = TextStyle(
    color: LearningColors.black18,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
  static const TextStyle tsHeadingbold = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );
  static const TextStyle tsSubHeadingBold = TextStyle(
    color: LearningColors.black18,
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );
  static const TextStyle tsOrange50W60016 = TextStyle(
    color: Color.fromARGB(255, 221, 163, 87),
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );
   static const TextStyle tsPrimaryblue500300W500 = TextStyle(
    color: LearningColors.primaryBlue500,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static const TextStyle tsblackTileBold = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w800,
    fontSize: 18.0,
  );
  static const TextStyle tsblackTileBold2 = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w800,
    fontSize: 16,
  );
  static const TextStyle tsWhiteNeutral300W500 = TextStyle(
    color: LearningColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
}
class AppDecorations {
  static  BoxDecoration gradientBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xffFFE6C6).withOpacity(0),
        Color(0xffFFE6C6).withOpacity(0.7), 
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
    ),
  );
}