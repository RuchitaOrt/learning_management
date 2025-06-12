import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
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

  String? selectedResult;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultProvider(),
      child: Scaffold(
        key: scaffoldKey,
       drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {
              // provider.toggleSearchIconCategory();
            },
            isSearchValueVisible: false,
             onMenuPressed: () => scaffoldKey.currentState?.openDrawer(), 
          ),
        ),
        body: Consumer<ResultProvider>(
          builder: (context, provider, child) {
            return Container(
              decoration: AppDecorations.gradientBackground,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Text(
                          "Results",
                          style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          children: _getFilterCategories().map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(category),
                                selected: selectedResult == category,
                                showCheckmark: false,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedResult = selected ? category : null;
                                  });
                                },
                                selectedColor: LearningColors.primaryBlue550,
                                backgroundColor: Colors.white60,
                                labelStyle: TextStyle(
                                  color: selectedResult == category
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _getFilteredResults().length,
                      itemBuilder: (context, index) {
                        final item = _getFilteredResults()[index];
                        final isExpanded = provider.expandedIndex == index;
                        final Color baseColor =
                            getButtonColorByStatus(item.result);

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.courseName,
                                        style:
                                            LMSStyles.tsblackTileBold.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
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
                                      SizedBox(
                                          width:
                                              8), // Space between dot and text
                                      Text(
                                        getButtonTextByStatus(item.result),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            item.duration,
                                            style: LMSStyles.tsblackTileBold
                                                .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            item.resultStatus,
                                            style: LMSStyles.tsblackTileBold
                                                .copyWith(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            item.courseStatus,
                                            style: LMSStyles.tsblackTileBold
                                                .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            item.totalMarks,
                                            style: LMSStyles.tsblackTileBold
                                                .copyWith(
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Attempted ${item.courseName}")));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.blue, width: 1.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                  ),
                ],
              ),
            );
          },
        ),
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