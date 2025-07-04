import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/model/GetResultResponse.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/ResultProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  static const String route = "/result";
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!provider.isLoading) {
        provider.getCategoryList();
      }

      final resultProvider =
          Provider.of<ResultProvider>(context, listen: false);

      // if (!resultProvider.isResultLoading) {
      resultProvider.getResultAPI("all");
      // }
    });
  }

  final List<CourseResult> results = [
    CourseResult(
      courseName: 'Ea reprehenderit in ullam eaque.',
      resultStatus: 'Virtual',
      duration: '00:40:00',
      courseStatus: '₹33000',
      totalMarks: '25',
      result: LMSStrings.strNoCompetent,
    ),
    CourseResult(
      courseName: 'Data Structures',
      resultStatus: 'Offline',
      duration: '02:56:00',
      courseStatus: '₹3300',
      totalMarks: '25',
      result: LMSStrings.strCompetent,
    ),
    CourseResult(
      courseName: 'Data Structures',
      resultStatus: 'Offline',
      duration: '02:56:00',
      courseStatus: '₹3300',
      totalMarks: '25',
      result: LMSStrings.strInreview,
    ),
    CourseResult(
      courseName: 'Data Structures',
      resultStatus: 'Offline',
      duration: '02:56:00',
      courseStatus: '₹3300',
      totalMarks: '25',
      result: LMSStrings.strCompetent,
    ),
    CourseResult(
      courseName: 'Ea reprehenderit in ullam eaque.',
      resultStatus: 'Virtual',
      duration: '00:40:00',
      courseStatus: '₹33000',
      totalMarks: '25',
      result: LMSStrings.strNoCompetent,
    ),
    // Add more as needed
  ];

  void _showAttemptBottomSheet(BuildContext context, ResultData item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF8F9FA),
                  Color(0xFFE9ECEF),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Course title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(color: Colors.grey.shade200, width: 1),
                    //   borderRadius: BorderRadius.circular(12),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.1),
                    //       spreadRadius: 1,
                    //       blurRadius: 8,
                    //       offset: Offset(0, 2),
                    //     ),
                    //   ],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                            child: Row(
                              children: [
                                // Institute image instead of icon
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      LMSImagePath
                                          .certificateLogo, // Replace with your image path
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                       item.instName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                           item.courseName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                          item.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: Colors.orange, width: 1),
                            ),
                            child: Text(
                              "Attempts left: ${item.attemptsLeft.toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ListView.builder(
      controller: scrollController,
      itemCount: item.attemptsData?.length ?? 0,
      itemBuilder: (context, index) {
        final attempt = item.attemptsData![index];
        final attemptNumber = (index + 1).toString().padLeft(2, '0');
        final isLast = index == (item.attemptsData!.length - 1);

        return _buildAttemptItem(
          attemptNumber: attemptNumber,
          date: attempt.startCreatedTime ?? '', // format if needed
          mode: attempt.mode ?? '',
          isSuccess: attempt.isPassed ?? false,
          isLast: isLast,
        );
      },
    ),
  ),
),

                // Attempts timeline
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: ListView(
                //       controller: scrollController,
                //       children: [
                //         _buildAttemptItem(
                //           attemptNumber: "01",
                //           date: "10th January, 10:40",
                //           mode: "Online",
                //           isSuccess: true,
                //           isLast: false,
                //         ),
                //         _buildAttemptItem(
                //           attemptNumber: "02",
                //           date: "10th January, 10:40",
                //           mode: "Institutes",
                //           isSuccess: false,
                //           isLast: false,
                //         ),
                //         _buildAttemptItem(
                //           attemptNumber: "03",
                //           date: "10th January, 10:40",
                //           mode: "Online",
                //           isSuccess: false,
                //           isLast: false,
                //         ),
                //         _buildAttemptItem(
                //           attemptNumber: "04",
                //           date: "10th January, 10:40",
                //           mode: "Institutes",
                //           isSuccess: false,
                //           isLast: true,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Reattempt button
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.shade700],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Starting reattempt for ${item.courseName}")));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Reattempt Exam",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget courseChips() {
    final landingProvider = Provider.of<LandingScreenProvider>(context);
    final courseProvider = Provider.of<ResultProvider>(context);
    // final categories = courseProvider.coursesByCategory.keys.toList();
    final categories = landingProvider.categoryList;

    if (landingProvider.isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: LearningColors.darkBlue,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            // Static 'ALL' chip
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text('ALL'),
                selected: courseProvider.selectedCategory == "all",
                showCheckmark: false,
                onSelected: (selected) {
                  courseProvider.selectCategory("all");
                },
                selectedColor: LearningColors.darkBlue,
                backgroundColor: courseProvider.selectedCategory == "all"
                    ? LearningColors.darkBlue
                    : Colors.grey.shade200,
                labelStyle: TextStyle(
                    color: courseProvider.selectedCategory == "all"
                        ? LearningColors.neutral100
                        : Colors.black),
              ),
            ),
            // Dynamic chips from categories list
            ...categories.map((category) {
              final String categoryId = category.id.toString();

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(category.categoryName!),
                  selected: courseProvider.selectedCategory == categoryId,
                  showCheckmark: false,
                  onSelected: (selected) {
                    courseProvider.selectCategory(
                      selected ? category.id.toString() : "all",
                    );
                  },
                  selectedColor: LearningColors.darkBlue,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: courseProvider.selectedCategory == categoryId
                        ? LearningColors.neutral100
                        : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

// Add this helper method for building attempt items:
  Widget _buildAttemptItem({
    required String attemptNumber,
    required String date,
    required String mode,
    required bool isSuccess,
    required bool isLast, // Add this parameter to identify the last item
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column with icon and line
          Column(
            children: [
              // Status icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSuccess ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              // Connecting line (only if not the last item)
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(top: 8),
                ),
            ],
          ),

          SizedBox(width: 16),

          // Attempt details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Attempt $attemptNumber",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  mode,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? selectedResult;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResultProvider>(context, listen: false);
    print("GET RESULT LENGTH");
    print(provider.courseResultList.length.toString());
    return Scaffold(
        key: scaffoldKey,
        endDrawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {
              // provider.toggleSearchIconCategory();
            },
            isSearchValueVisible: false,
            onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ),
        body: Container(
          decoration: AppDecorations.gradientBackground,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Results",
                      style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        LMSImagePath.filter,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              courseChips(),
              SizedBox(
                height: 20,
              ),
              getResultList()
            ],
          ),
        ));
  }

  Widget getResultList() {
    final provider = Provider.of<ResultProvider>(context);
    if (provider.isResultLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: LearningColors.darkBlue,
      ));
    }
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.courseResultList.length,
        itemBuilder: (context, index) {
          final item = provider.courseResultList[index];
          final isExpanded = provider.expandedIndex == index;
          final Color baseColor = getButtonColorByStatus(item.courseStatus!);

          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with title and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.courseName!,
                          style: LMSStyles.tsblackTileBold.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      color: baseColor.withOpacity(0.0),
                    ),
                    child: Row(
                      children: [
                        // Colored dot
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: baseColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8), // Space between dot and text
                        Text(
                          getButtonTextByStatus(item.courseStatus!),
                          style: TextStyle(
                            color: baseColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  // Details grid
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration:",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.timeTaken!,
                              style: LMSStyles.tsblackTileBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Result:",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.mode!,
                              style: LMSStyles.tsblackTileBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status:",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.courseStatus!,
                              style: LMSStyles.tsblackTileBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Marks:",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.totalMarks.toString(),
                              style: LMSStyles.tsblackTileBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Attempt button
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        _showAttemptBottomSheet(context, item);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Attempt",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _getFilterCategories() {
    return [
      'All',
      'Navigation',
      'Safety & Survival',
      'Engineering',
      'Cargo Handling',
      'Compliance'
    ];
  }

  List<CourseResult> _getFilteredResults() {
    if (selectedResult == null || selectedResult == 'All') {
      return results;
    }

    // Filter results based on selected category
    // You can customize this logic based on how you want to categorize your courses
    return results.where((result) {
      // Add your filtering logic here based on course categories
      // For now, returning all results as an example
      return true;
    }).toList();
  }
}

Color getButtonColorByStatus(String status) {
  if (status == LMSStrings.strNoCompetent) {
    return LearningColors.red;
  } else if (status == LMSStrings.strCompetent) {
    return LearningColors.secondary550;
  } else {
    return LearningColors.darkBlue;
  }
}

String getButtonTextByStatus(String status) {
  if (status == LMSStrings.strNoCompetent) {
    return LMSStrings.strNoCompetent;
  } else if (status == LMSStrings.strCompetent) {
    return LMSStrings.strCompetent;
  } else {
    return LMSStrings.strInreview;
  }
}
