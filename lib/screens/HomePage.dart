import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/GraphCard.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homeScreen";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int activeCourses = 3;
  int enrolledCourses = 8;
  int completedCourses = 5;
  int pendingCourses = 2;
  String? selectedModule;

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Container(
          decoration: AppDecorations.gradientBackground,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome, Ruchita!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: LearningColors.black,
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: LearningColors.darkBlue,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),*/
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  //margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome,",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Ruchita!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: LearningColors.black,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: LearningColors.darkBlue,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          // Verified badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const Icon(
                                Icons.verified, // You can also use Icons.shield or Icons.verified_user
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 12),

                // Overview Heading
                Text(
                  "Overview",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),

                // Grid Cards
                /*GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1.3,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CourseCard(
                      title: "Active",
                      count: activeCourses,
                      icon: Icons.play_arrow,
                      color: Colors.orange,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Enrolled",
                      count: enrolledCourses,
                      icon: Icons.school,
                      color: Colors.blue,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Completed",
                      count: completedCourses,
                      icon: Icons.check_circle,
                      color: Colors.green,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Pending",
                      count: pendingCourses,
                      icon: Icons.pending_actions,
                      color: Colors.red,
                      total: 10,
                    ),
                  ],
                ),*/

                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CourseCard(
                      title: "Result Percentile",
                      count: 87, // example: 87 percentile
                      total: 100,
                      icon: Icons.bar_chart_rounded,
                      color: Colors.deepPurple,
                      suffix: "%",
                    ),
                    CourseCard(
                      title: "Certificates Earned",
                      count: 4,
                      total: 10,
                      icon: Icons.verified_rounded,
                      color: Colors.green,
                    ),
                    CourseCard(
                      title: "Total Score",
                      count: 268,
                      total: 300,
                      icon: Icons.score,
                      color: Colors.blueAccent,
                    ),
                    CourseCard(
                      title: "Completed Courses",
                      count: 6,
                      total: 10,
                      icon: Icons.check_circle_outline,
                      color: Colors.orange,
                    ),
                  ],
                ),

                // Ongoing Courses Section
                const SizedBox(height: 12),
                Text(
                  "Ongoing Course",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
                CurrentCourseCard(
                  courseTitle: "Fundamental: Marine Navigation",
                  progress: 0.65,
                  currentModule: "Module 3: Navigation Techniques",
                  onModuleChanged: (value) {
                    setState(() {
                      selectedModule = value;
                    });
                  },
                ),
                /*SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: OngoingCourseCard(
                          courseTitle: "Fundamental :Marine Navigation",
                          progress: (index + 1) * 0.15,
                        ),
                      );
                    },
                  ),
                ),*/
                const SizedBox(height: 12),
                Text(
                  "Recommended Course",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height:Platform.isIOS?SizeConfig.blockSizeVertical * 35.5:SizeConfig.blockSizeVertical * 39,
                  // Platform.isIOS?MediaQuery.of(context).size.height * 0.36: MediaQuery.of(context).size.height * 0.39,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final courses = [
                        {
                          'title': 'Advanced Navigation Navigation Navigation Navigation Navigation Navigation',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlbIDRuVn3XZxVDRbpIMoYUUx-hS9v63awWLH97LbfhPw4VkQUK8iquu2LDFpaazgfSHM&usqp=CAU',
                          'duration': '8h 45m · 1.5L+ Learners',
                        },
                        {
                          'title': 'Marine Safety',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQy5J_LGg_5D-OkkskgbBnZXbdFq9Kuovbvew&s',
                          'duration': '6h 30m · 1.2L+ Learners',
                        },
                        {
                          'title': 'Engine Maintenance',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPVDI288Kwzhlmxzvyx6b9RbA0i5qgRcI7UA&s',
                          'duration': '10h 15m · 1L+ Learners',
                        },
                        {
                          'title': 'Cargo Operations',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://source.unsplash.com/featured/?cargo,ship',
                          'duration': '7h 20m · 1L+ Learners',
                        },
                      ];

                      return RecommendedCourseItem(
                        title: courses[index]['title']!,
                        content: courses[index]['content']!,
                        image: courses[index]['image']!,
                        duration: courses[index]['duration']!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Progress Graph
                Text(
                  "Progress Graph",
                  style:LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
             GraphCard()

              ],
            ),
          ),
        ),
      );
    });
  }
}

class CurrentCourseCard extends StatelessWidget {
  final String courseTitle;
  final double progress;
  final String currentModule;
  final ValueChanged<String?>? onModuleChanged;

  const CurrentCourseCard({
    super.key,
    required this.courseTitle,
    required this.progress,
    required this.currentModule,
    this.onModuleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and Play Button
          Text(
            courseTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),

          /// Progress Indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: LearningColors.primaryBlue550.withOpacity(0.15),
              color: LearningColors.darkBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${(progress * 100).toInt()}% completed",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          /// Expanded Module List (Replacing Dropdown)
          /*Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: LearningColors.darkBlue.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Modules',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300, height: 1),
                ...[
                  "Module 1: Introduction",
                  "Module 2: Basic Navigation",
                  "Module 3: Navigation Techniques",
                  "Module 4: Advanced Concepts",
                  "Module 5: Final Assessment"
                ].map((module) {
                  final isSelected = module == currentModule;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      module,
                      style: TextStyle(
                        color: isSelected ? LearningColors.darkBlue : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.circle_outlined, size: 20, color: Colors.grey),
                    onTap: () {
                      if (onModuleChanged != null) {
                        onModuleChanged!(module);
                      }
                    },
                  );
                }).toList(),
              ],
            ),
          ),*/

          /// Expandable Module List using ExpansionTile
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: LearningColors.darkBlue.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  currentModule,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                iconColor: LearningColors.darkBlue,
                collapsedIconColor: LearningColors.darkBlue,
                children: () {
                  final modules = [
                    "Module 1: Introduction",
                    "Module 2: Basic Navigation",
                    "Module 3: Navigation Techniques",
                    "Module 4: Advanced Concepts",
                    "Module 5: Final Assessment"
                  ];
                  final currentIndex = modules.indexOf(currentModule);

                  return modules.asMap().entries.map((entry) {
                    final index = entry.key;
                    final module = entry.value;

                    Color textColor;
                    Widget? trailingIcon;

                    if (index < currentIndex) {
                      textColor = LearningColors.darkBlue;
                      trailingIcon = const Icon(Icons.check_circle, color: LearningColors.darkBlue);
                    } else if (index == currentIndex) {
                      textColor = LearningColors.darkBlue;
                      trailingIcon = null;
                    } else {
                      textColor = LearningColors.neutral400;
                      trailingIcon = null;
                    }

                    return ListTile(
                      title: Text(
                        module,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: index == currentIndex ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      trailing: trailingIcon,
                      onTap: () {
                        if (onModuleChanged != null) {
                          onModuleChanged!(module);
                        }
                      },
                    );
                  }).toList();
                }(),
              ),
            ),
          ),

          /// Dropdown for Modules
          /*Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: LearningColors.darkBlue.withOpacity(0.2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentModule,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: LearningColors.primaryBlue550),
                isExpanded: true,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: TextStyle(
                  color: LearningColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                items: [
                  "Module 1: Introduction",
                  "Module 2: Basic Navigation",
                  "Module 3: Navigation Techniques",
                  "Module 4: Advanced Concepts",
                  "Module 5: Final Assessment"
                ].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onModuleChanged,
              ),
            ),
          ),*/

          const SizedBox(height: 20),

          /// Continue Watching
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    LearningColors.darkBlue.withOpacity(0.95),
                    LearningColors.primaryBlue550,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: LearningColors.darkBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Understanding Ships Operating in Polar Waters",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Resume",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final int count;
  final int total;
  final IconData icon;
  final Color color;
  final String suffix;

  const CourseCard({
    super.key,
    required this.title,
    required this.count,
    required this.total,
    required this.icon,
    required this.color,
    this.suffix = "",
  });

  @override
  Widget build(BuildContext context) {
    double percent = (total == 0) ? 0 : count / total;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon top-right
          Align(
            alignment: Alignment.topRight,
            child: Icon(icon, color: color, size: 28),
          ),
          const Spacer(),
          Text(
            "$count$suffix",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          // Progress bar
          LinearProgressIndicator(
            value: percent.clamp(0.0, 1.0),
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}

class OngoingCourseCard extends StatelessWidget {
  final String courseTitle;
  final double progress;

  const OngoingCourseCard({
    super.key,
    required this.courseTitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          LinearProgressIndicator(
            value: progress,
            color: Colors.blue,
            backgroundColor: Colors.blue[100],
          ),
          const SizedBox(height: 8),
          Text("${(progress * 100).toInt()}% completed"),
        ],
      ),
    );
  }
}

class RecommendedCourseItem extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String duration;

  const RecommendedCourseItem({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// Image with "Recommended" tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        LearningColors.darkBlue,
                        LearningColors.primaryBlue550,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Title, Content,Duration, Button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: LMSStyles.tsWhiteNeutral300W3002.copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: LMSStyles.tsblackTileBold2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: LearningColors.neutral500),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: LMSStyles.tsWhiteNeutral300W3002.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: LearningColors.darkBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Course',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:learning_mgt/Utils/learning_colors.dart';
// import 'package:learning_mgt/Utils/sizeConfig.dart';
// import 'package:learning_mgt/provider/LandingScreenProvider.dart';
// import 'package:learning_mgt/widgets/CustomAppBar.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//     static const String route = "/homeScreen";
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int activeCourses = 3;
//   int enrolledCourses = 8;
//   int completedCourses = 5;

//   @override
//   Widget build(BuildContext context) {
//     return 
//      Consumer<LandingScreenProvider>(builder: (context, provider, _) {
//   return  Scaffold(
//       backgroundColor: Colors.grey[100],
//      appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(kToolbarHeight),
//             child: CustomAppBar(
//               isSearchClickVisible: () {
//                 // provider.toggleSearchIconCategory();
//               },
//               isSearchValueVisible: provider.isSearchIconVisible,
//             ),
//           ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: CourseCard(
//                 title: "Active",
//                 count: activeCourses,
//                 icon: Icons.play_arrow,
//                 color: Colors.orange,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: CourseCard(
//                 title: "Enrolled",
//                 count: enrolledCourses,
//                 icon: Icons.school,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: CourseCard(
//                 title: "Completed",
//                 count: completedCourses,
//                 icon: Icons.check_circle,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//      });
//   }
// }

// class CourseCard extends StatelessWidget {
//   final String title;
//   final int count;
//   final IconData icon;
//   final Color color;

//   const CourseCard({
//     super.key,
//     required this.title,
//     required this.count,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.blockSizeVertical*17,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color:
//         // LearningColors.neutral100,
//          color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
         
//           const SizedBox(height: 2),
//           Text(
//             "$count",
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: LearningColors.black,
//             ),
//           ),
//           SizedBox(height: SizeConfig.blockSizeVertical*2,),
//           Text(
//             "$title Course${count != 1 ? "s" : ""}",
//             style: TextStyle(color: LearningColors.black,fontSize: 12,),
//           ),
//         ],
//       ),
//     );
//   }
// }
