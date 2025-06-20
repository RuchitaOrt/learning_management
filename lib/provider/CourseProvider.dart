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
  // final String? category;

  Course({
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
    // this.category,
  });
}

class CourseProvider with ChangeNotifier {
  final Map<String, List<Course>> _coursesByCategory = {
    'All': [
      Course(
          id: '1',
          title: 'Naval Operations Course',
          description:
              'Provides training in planning and executing complex naval missions and maritime operations.',
          imageUrl:
              'https://responsiblestatecraft.org/media-library/screen-shot-2020-07-10-at-1-49-23-pm.png?id=34283984&width=1200&height=800&quality=90&coordinates=0%2C45%2C0%2C45',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "7500",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          // category: "Navigation"
          ),
      Course(
          id: '2',
          title: 'Seamanship Training',
          description: 'Learn basics in this Seamanship Training Program.',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUUF2yQq-oF_SfYG7SRS9SWeA-4kr1e13Slg&s',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "5500",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          // category: "Safety & Survival"
          ),
      Course(
          id: '3',
          title: 'Merchant Navy Coaching',
          description: 'Learn the basics of Merchant Navy Coaching.',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ39MAWDDNIsz60CTsicHJiecj8G05Lw1lMxA&s',
          mode: "online",
          noofpeoplevisited: "39",
          discountedAmount: "70",
          amount: "6500",
          offerPercentage: "30 %",
          institue: "Centre for Maritime Education and Training (CMET)",
          courseDuration: "2 days",
          // category: "Navigation"
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
          courseDuration: "2 days",
          // category: "Navigation"
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
          courseDuration: "2 days",
          // category: "Navigation"
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
          courseDuration: "2 days",
          // category: "Navigation"
          ),
    ],
    'Safety & Survival': [
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
          courseDuration: "2 days",
          // category: "Safety & Survival"
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
          courseDuration: "2 days",
          // category: "Safety & Survival"
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
          courseDuration: "2 days",
          // category: "Engineering"
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
          courseDuration: "2 days",
          // category: "Engineering"
          ),
    ],
    'Cargo Handling': [
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
          courseDuration: "2 days",
          // category: "Cargo Handling"
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
          courseDuration: "2 days",
          // category: "Cargo Handling"
          ),
    ],
    'Compliance': [
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
          courseDuration: "2 days",
          // category: "Compliance"
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
          courseDuration: "2 days",
          // category: "Compliance"
          ),
    ],
  };

  Map<String, List<Course>> get coursesByCategory => _coursesByCategory;
}
