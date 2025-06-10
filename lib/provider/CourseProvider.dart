import 'package:flutter/material.dart';

class Course {
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


  Course( {
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

  });
}

class CourseProvider with ChangeNotifier {
  final Map<String, List<Course>> _coursesByCategory = {
    'All': [
      Course(
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
     


      ),
      Course(
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
        courseDuration: "2 days"

      ),
        Course(
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
        courseDuration: "2 days"

      ),
    ],
    'Navigation': [
      Course(
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
        courseDuration: "2 days"


      ),
      Course(
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
        courseDuration: "2 days"

      ),
        Course(
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
        courseDuration: "2 days"

      ),
    ],
    'Safety & Survial': [
      Course(
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
        courseDuration: "2 days"

      ),
      Course(
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
        courseDuration: "2 days"

      ),
    ],
     'Engineering': [
      Course(
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
        courseDuration: "2 days"

      ),
      Course(
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
        courseDuration: "2 days"

      ),
    ],
       'Cargo Handling ': [
      Course(
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
        courseDuration: "2 days"

      ),
      Course(
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
        courseDuration: "2 days"

      ),
    ],
     'Compilance': [
      Course(
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
        courseDuration: "2 days"

      ),
      Course(
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
        courseDuration: "2 days"

      ),
    ],
  };

  Map<String, List<Course>> get coursesByCategory => _coursesByCategory;
}
