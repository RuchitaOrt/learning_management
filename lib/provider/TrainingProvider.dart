import 'package:flutter/material.dart';

class TrainingCourse {
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
  final String completionPercentage;
  final String status;


  TrainingCourse( {
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.institue,
    required this.mode,
    required this.noofpeoplevisited,
   required  this.courseDuration,
    required this.discountedAmount,
    required this.amount,
    required this.offerPercentage,
    required this.completionPercentage,
    required this.status

  });
}

class TrainingProvider with ChangeNotifier {
  final Map<String, List<TrainingCourse>> _coursesByCategory = {
    // 'All': [
    //   TrainingCourse(
    //     id: '1',
    //     title: 'UI/UX Basics',
    //     description: 'Learn the basics of UI/UX design.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "0",
    //     status: "Not Started"
     


    //   ),
    //   TrainingCourse(
    //     id: '2',
    //     title: 'Figma Essentials',
    //     description: 'Master the Figma tool.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "10",
    //     status: "In Progress"

    //   ),
    //     TrainingCourse(
    //     id: '3',
    //     title: 'Figma Essentials',
    //     description: 'Master the Figma tool.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "20",
    //     status: "In Progress"

    //   ),
    //   TrainingCourse(
    //     id: '2',
    //     title: 'Figma Essentials',
    //     description: 'Master the Figma tool.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "0",
    //     status: "Not Started"

    //   ),
    //    TrainingCourse(
    //     id: '3',
    //     title: 'Flutter for Beginners',
    //     description: 'Kickstart your Flutter journey.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "100",
    //     status: "Completed"

    //   ),
    //   TrainingCourse(
    //     id: '3',
    //     title: 'Flutter for Beginners',
    //     description: 'Kickstart your Flutter journey.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "",
    //     status: "Expired"

    //   ),
 
    // ],
    // 'Not Started': [
    //   TrainingCourse(
    //     id: '1',
    //     title: 'UI/UX Basics',
    //     description: 'Learn the basics of UI/UX design.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "0",
    //     status: "Not Started"


    //   ),
    //   TrainingCourse(
    //     id: '2',
    //     title: 'Figma Essentials',
    //     description: 'Master the Figma tool.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "0",
    //     status: "Not Started"

    //   ),
       
    // ],
    // 'In Progress': [
    //   TrainingCourse(
    //     id: '3',
    //     title: 'Flutter for Beginners',
    //     description: 'Kickstart your Flutter journey.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "20",
    //     status: "In Progress"

    //   ),
    //   TrainingCourse(
    //     id: '4',
    //     title: 'Dart Language',
    //     description: 'Understand Dart deeply.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "10",
    //     status: "In Progress"

    //   ),
    // ],
     'Completed': [
      TrainingCourse(
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
        completionPercentage: "100",
        status: "Completed"

      ),
      TrainingCourse(
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
        completionPercentage: "100",
        status: "Completed"

      ),
      
    ],
    //    'Expired ': [
    //   TrainingCourse(
    //     id: '3',
    //     title: 'Flutter for Beginners',
    //     description: 'Kickstart your Flutter journey.',
    //     imageUrl: 'https://via.placeholder.com/150',
    //     mode: "online",
    //     noofpeoplevisited: "39",
    //     discountedAmount: "70",
    //     amount: "65",
    //     offerPercentage: "30 %",
    //     institue: "Centre for Maritime Education and Training (CMET)",
    //     courseDuration: "2 days",
    //     completionPercentage: "",
    //     status: "Expired"

    //   ),
 
    // ],
     
  };

  Map<String, List<TrainingCourse>> get coursesByCategory => _coursesByCategory;
}
