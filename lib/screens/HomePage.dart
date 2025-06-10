import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
    static const String route = "/homeScreen";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeCourses = 3;
  int enrolledCourses = 8;
  int completedCourses = 5;

  @override
  Widget build(BuildContext context) {
    return 
     Consumer<LandingScreenProvider>(builder: (context, provider, _) {
  return  Scaffold(
      backgroundColor: Colors.grey[100],
     appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isSearchClickVisible: () {
                // provider.toggleSearchIconCategory();
              },
              isSearchValueVisible: provider.isSearchIconVisible,
            ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: CourseCard(
                title: "Active",
                count: activeCourses,
                icon: Icons.play_arrow,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CourseCard(
                title: "Enrolled",
                count: enrolledCourses,
                icon: Icons.school,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CourseCard(
                title: "Completed",
                count: completedCourses,
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
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
  final IconData icon;
  final Color color;

  const CourseCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical*17,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
        // LearningColors.neutral100,
         color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          const SizedBox(height: 2),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: LearningColors.black,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical*2,),
          Text(
            "$title Course${count != 1 ? "s" : ""}",
            style: TextStyle(color: LearningColors.black,fontSize: 12,),
          ),
        ],
      ),
    );
  }
}
