import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';

class RecommendedCourse {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String institue;
  final String mode;
  final String noofpeoplevisited;
  final String courseDuration;
  final String discountedAmount;
  final String amount;
  final String offerPercentage;
  final String status;//requested,pending,reapply
  final String courseStatus;//recommeded,mandatory


  RecommendedCourse(
     {
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.institue,
    required this.mode,
    required this.noofpeoplevisited,
    required this.courseDuration,
    required this.discountedAmount,
    required this.amount,
    required this.offerPercentage,
    required this.status,
    required this.courseStatus
  });
}

class RecommendedCourseProvider with ChangeNotifier {
  final Map<String, List<RecommendedCourse>> _coursesByCategory = {
    'All': [
      RecommendedCourse(
        id: '1',
        title: 'UI/UX Basics',
        description: 'Learn the basics of UI/UX design.',
        imageUrl: 'https://via.placeholder.com/150',
        mode: "online",
        noofpeoplevisited: "39",
        discountedAmount: "70",
        amount: "65",
        offerPercentage: "30 %",
        institue: "Centre for Maritime Education and Training (CMET)",
        courseDuration: "2 days",
        status: LMSStrings.strRequested,
        courseStatus: LMSStrings.strRecommended
        
      ),
      RecommendedCourse(
          id: '2',
          title: 'Figma Essentials',
          description: 'Master the Figma tool.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          status: LMSStrings.strPending,
        courseStatus: LMSStrings.strMandatory),
      RecommendedCourse(
          id: '3',
          title: 'Figma Essentials',
          description: 'Master the Figma tool.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
            status: LMSStrings.strReappy,
        courseStatus: LMSStrings.strRecommended)
    ],
    'Recommended': [
      RecommendedCourse(
          id: '1',
          title: 'UI/UX Basics',
          description: 'Learn the basics of UI/UX design.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
            status: LMSStrings.strPending,
        courseStatus: LMSStrings.strRecommended
          ),
      RecommendedCourse(
          id: '2',
          title: 'Figma Essentials',
          description: 'Master the Figma tool.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
           status: LMSStrings.strRequested,
        courseStatus: LMSStrings.strRecommended),
      RecommendedCourse(
          id: '3',
          title: 'Figma Essentials',
          description: 'Master the Figma tool.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          status: LMSStrings.strRequested,
        courseStatus: LMSStrings.strRecommended),
    ],
    'Mandatory': [
      RecommendedCourse(
          id: '3',
          title: 'Flutter for Beginners',
          description: 'Kickstart your Flutter journey.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          status: LMSStrings.strRequested,
        courseStatus: LMSStrings.strMandatory),
      RecommendedCourse(
          id: '4',
          title: 'Dart Language',
          description: 'Understand Dart deeply.',
          imageUrl: 'https://via.placeholder.com/150',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "65",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          status: LMSStrings.strReappy,
        courseStatus: LMSStrings.strMandatory),
    ],

  };

  Map<String, List<RecommendedCourse>> get coursesByCategory => _coursesByCategory;
}
