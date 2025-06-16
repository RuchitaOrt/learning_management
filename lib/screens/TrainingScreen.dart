import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';

import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/TrainingProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/ProgressBar.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends StatefulWidget {
  static const String route = "/TrainingScreen";
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCategory;

  // Timer management for each course
  Map<String, Timer?> _timers = {};
  Map<String, int> _remainingSeconds = {};

  @override
  void initState() {
    super.initState();

    // Delay the initialization to avoid calling Provider before build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
          Provider.of<TrainingProvider>(context, listen: false);
      if (courseProvider.coursesByCategory.isNotEmpty) {
        setState(() {
          selectedCategory = courseProvider.coursesByCategory.keys.first;
        });

        // Auto-start timers for all completed courses
        _startAllCompletedCourseTimers(courseProvider);
      }
    });
  }

  @override
  void dispose() {
    // Cancel all active timers to prevent memory leaks
    _timers.values.forEach((timer) => timer?.cancel());
    super.dispose();
  }

  // Auto-start timers for all completed courses
  void _startAllCompletedCourseTimers(TrainingProvider courseProvider) {
    final completedCourses = _getAllCompletedCourses(courseProvider);

    for (int i = 0; i < completedCourses.length; i++) {
      final course = completedCourses[i];
      final courseId = course.id ?? course.title ?? 'course_$i';
      _startCountdownTimer(courseId);
    }
  }

  // Start countdown timer for a specific course (24 hours = 86400 seconds)
  void _startCountdownTimer(String courseId) {
    // Cancel existing timer if any
    _timers[courseId]?.cancel();

    // Set initial time to 24 hours (86400 seconds)
    _remainingSeconds[courseId] = 24 * 60 * 60;

    // Create periodic timer that updates every second
    _timers[courseId] = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds[courseId]! > 0) {
          _remainingSeconds[courseId] = _remainingSeconds[courseId]! - 1;
        } else {
          // Timer reached 0, cancel it
          timer.cancel();
          _timers[courseId] = null;
        }
      });
    });
  }

  // Format timer display (HH:MM:SS)
  String _formatCountdownTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  // Get timer status for a course
  String _getTimerStatus(String courseId) {
    int remainingTime = _remainingSeconds[courseId] ?? 0;
    bool hasActiveTimer = _timers[courseId] != null && remainingTime > 0;

    if (hasActiveTimer) {
      return 'active';
    } else if (remainingTime == 0 && _timers.containsKey(courseId)) {
      return 'expired';
    } else {
      return 'inactive';
    }
  }

  // Check if all courses are completed
  bool _areAllCoursesCompleted(TrainingProvider courseProvider) {
    if (courseProvider.coursesByCategory.isEmpty) return false;

    for (var categoryList in courseProvider.coursesByCategory.values) {
      for (var course in categoryList) {
        if (course.completionPercentage != "100") {
          return false;
        }
      }
    }
    return true;
  }

  // Get all completed courses
  List<TrainingCourse> _getAllCompletedCourses(
      TrainingProvider courseProvider) {
    List<TrainingCourse> completedCourses = [];
    for (var categoryList in courseProvider.coursesByCategory.values) {
      for (var course in categoryList) {
        if (course.completionPercentage == "100") {
          completedCourses.add(course);
        }
      }
    }
    return completedCourses;
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<TrainingProvider>(context);
    final categories = courseProvider.coursesByCategory.keys.toList();
    final allCoursesCompleted = _areAllCoursesCompleted(courseProvider);
    final completedCourses = _getAllCompletedCourses(courseProvider);

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          ShowDialogs.exitDialog();
          return false;
        },
        child: Scaffold(
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            decoration: AppDecorations.gradientBackground,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Check for different states
                    if (categories.isEmpty) ...[
                      // No courses state
                      _buildEmptyState(),
                    ] else if (allCoursesCompleted &&
                        completedCourses.isNotEmpty) ...[
                      // All courses completed state
                      _buildCompletedCoursesState(completedCourses),
                    ] else ...[
                      // Regular courses state
                      _buildRegularCoursesState(categories, courseProvider),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 10),
              Image.asset(
                LMSImagePath.emptycourse,
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 30,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              Text(
                'No courses available',
                style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Text(
                'Start your learning journey by enrolling in a course',
                style: LMSStyles.tsSubHeadingBold.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4),
              ElevatedButton(
                onPressed: () {
                  // Add your enrollment navigation logic here
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    SizeConfig.blockSizeHorizontal * 40,
                    SizeConfig.blockSizeVertical * 6,
                  ),
                  backgroundColor: LearningColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Enroll Now',
                  style:
                      LMSStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedCoursesState(List<TrainingCourse> completedCourses) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
      child: Column(
        children: [
          Image.asset(
                LMSImagePath.emptycourse,
                width: SizeConfig.blockSizeHorizontal * 60,
                height: SizeConfig.blockSizeVertical * 30,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Text(
            'No Ongoing Courses',
            style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Text(
            'Continue your learning journey by enrolling in a new course',
            style: LMSStyles.tsSubHeadingBold.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          ElevatedButton(
            onPressed: () {
              // Add your enrollment navigation logic here
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                SizeConfig.blockSizeHorizontal * 40,
                SizeConfig.blockSizeVertical * 6,
              ),
              backgroundColor: LearningColors.primaryBlue550,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: Text(
              'Explore courses',
              style: LMSStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              itemCount: completedCourses.length,
              itemBuilder: (context, index) {
                return IntrinsicHeight(
                  child:
                      _buildCompletedCourseCard(completedCourses[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCourseCard(TrainingCourse course, int index) {
    // Create unique course ID for timer tracking
    String courseId = course.id ?? course.title ?? 'course_$index';
    int remainingTime = _remainingSeconds[courseId] ?? 0;
    String timerStatus = _getTimerStatus(courseId);

    return Container(
      width: SizeConfig.blockSizeHorizontal * 80,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                LearningColors.white,
                LearningColors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: timerStatus == 'expired'
                            ? Colors.red.shade100
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: timerStatus == 'expired'
                                ? Colors.red.shade300
                                : Colors.red.shade200,
                            width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                              timerStatus == 'expired'
                                  ? Icons.timer_off
                                  : Icons.timer,
                              color: timerStatus == 'expired'
                                  ? Colors.red
                                  : Colors.red,
                              size: 12),
                          SizedBox(width: 4),
                          Text(
                            timerStatus == 'expired'
                                ? 'Expired'
                                : _formatCountdownTime(remainingTime),
                            style: TextStyle(
                              color: timerStatus == 'expired'
                                  ? Colors.red.shade800
                                  : Colors.red.shade700,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                // Header row with certificate logo, institute, and timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: Certificate logo and institute
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            LMSImagePath.certificateLogo,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                          Expanded(
                            child: Text(
                              course.institue,
                              style: LMSStyles.tsHeadingbold
                                  .copyWith(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right side: Timer in top-right corner
                  ],
                ),
                SizedBox(height: 8),

                // Course title
                Text(
                  course.title,
                  style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),

                // Course description
                Text(
                  course.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: LMSStyles.tsSubHeadingBold.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),

                SizedBox(height: 8),

                // Course details row
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 14, color: Colors.grey.shade600),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        course.courseDuration,
                        style: LMSStyles.tsHeading.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.people, size: 14, color: Colors.grey.shade600),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        course.noofpeoplevisited,
                        style: LMSStyles.tsHeading.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Completion badge
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                //   decoration: BoxDecoration(
                //     color: Colors.green,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Text(
                //     'COMPLETED',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 16),

                Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: course.status == "Expired"
                    ? Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('The Course has been expired',
                                    overflow: TextOverflow.ellipsis,
                                    style: LMSStyles.tsSubHeadingBold.copyWith(
                                        color: LearningColors.red,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  SizeConfig.blockSizeHorizontal * 24,
                                  SizeConfig.blockSizeVertical * 4),
                              backgroundColor: LearningColors.darkBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              LMSStrings.strReapplylNow,
                              style: LMSStyles.tsWhiteNeutral50W60016,
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 16),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: ProgressBar(
                                  currentPosition:
                                      double.parse(course.completionPercentage),
                                  duration: double.parse("100"),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text("${course.completionPercentage} %")
                            ],
                          ),
                        ),
                      ),
              ),

                // Action buttons (simplified without timer)
                Row(
                  children: [
                    // View button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to course details
                        },
                        icon: Icon(Icons.visibility, size: 14),
                        label: Text(
                          'View',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.primaryBlue550,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          minimumSize: Size(0, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    // Download button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: timerStatus == 'expired' ? null : () {},
                        icon: Icon(Icons.download, size: 14),
                        label: Text(
                          'Download',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: timerStatus == 'expired'
                              ? Colors.grey
                              : Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          minimumSize: Size(0, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegularCoursesState(
      List<String> categories, TrainingProvider courseProvider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Your Training",
                style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    showCheckmark: false,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = selected ? category : null;
                      });
                    },
                    selectedColor: LearningColors.primaryBlue550,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: selectedCategory == category
                          ? LearningColors.neutral100
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 8),
        if (selectedCategory != null &&
            courseProvider.coursesByCategory[selectedCategory!] != null) ...[
          ...courseProvider.coursesByCategory[selectedCategory!]!
              .map((course) => _buildVerticalCard(course))
              .toList()
        ]
      ],
    );
  }

  Widget _buildVerticalCard(TrainingCourse course) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: course.status == "Expired"
                ? LinearGradient(
                    colors: [
                      Colors.red.shade100,
                      Colors.red.shade100,
                      Colors.red.shade100,
                      Colors.red.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  )
                : LinearGradient(
                    colors: [
                      LearningColors.white,
                      LearningColors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(LMSImagePath.certificateLogo),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      child: Text(
                        course.institue,
                        style: LMSStyles.tsHeadingbold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.3,
              ),
              Text(course.title, style: LMSStyles.tsSubHeadingBold),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 0.1,
              ),
              Text(
                course.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: LMSStyles.tsSubHeadingBold
                    .copyWith(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(LMSImagePath.mode),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text(course.mode, style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(LMSImagePath.usermultiple),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text(course.noofpeoplevisited,
                              style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(LMSImagePath.time),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text(course.courseDuration,
                              style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: course.status == "Expired"
                    ? Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('The Course has been expired',
                                    overflow: TextOverflow.ellipsis,
                                    style: LMSStyles.tsSubHeadingBold.copyWith(
                                        color: LearningColors.red,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  SizeConfig.blockSizeHorizontal * 24,
                                  SizeConfig.blockSizeVertical * 4),
                              backgroundColor: LearningColors.darkBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              LMSStrings.strReapplylNow,
                              style: LMSStyles.tsWhiteNeutral50W60016,
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 16),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: ProgressBar(
                                  currentPosition:
                                      double.parse(course.completionPercentage),
                                  duration: double.parse("100"),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text("${course.completionPercentage} %")
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
