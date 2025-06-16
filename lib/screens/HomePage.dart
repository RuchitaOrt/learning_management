import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
     
        backgroundColor: Colors.grey[100],
        
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {},
            isSearchValueVisible: provider.isSearchIconVisible,
              onMenuPressed: () => scaffoldKey.currentState?.openDrawer(), 
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              Text(
                "Welcome, Ruchita!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: LearningColors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Overview Heading
              Text(
                "Overview",
                style: LMSStyles.tsblackTileBold,
              ),
              const SizedBox(height: 8),

              // Grid Cards
              GridView.count(
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
              ),


              // Ongoing Courses Section
              Text(
                "Ongoing Courses",
                style: LMSStyles.tsblackTileBold,
              ),
              const SizedBox(height: 8),
              SizedBox(
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
              ),

              const SizedBox(height: 20),

              // Progress Graph
              Text(
                "Progress Graph",
                style:LMSStyles.tsblackTileBold,
              ),
              const SizedBox(height: 8),
           GraphCard()

            ],
          ),
        ),
      );
    });
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final int count;
  final int total; // total courses for progress
  final IconData icon;
  final Color color;

  const CourseCard({
    super.key,
    required this.title,
    required this.count,
    required this.total,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double percent = (total == 0) ? 0 : count / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
        Colors.white,
        //  color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Progress
          CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 6.0,
            percent: percent.clamp(0.0, 1.0),
            center: Text(
              "$count",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            progressColor: color,
            backgroundColor: color.withOpacity(0.2),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 16),
 Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title Course${count != 1 ? "s" : ""}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
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
