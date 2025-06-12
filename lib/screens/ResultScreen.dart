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
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final isExpanded = provider.expandedIndex == index;
        final Color baseColor = getButtonColorByStatus(item.result);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.courseName),
                          IconButton(
                          icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          onPressed: () => provider.toggleExpanded(index),
                        ),
                        ],),
                      Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: SizeConfig.blockSizeVertical*4.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor.withOpacity(0.1), 
                      foregroundColor: baseColor, // 🔵 
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: baseColor), 
                      ),
                      elevation: 0, 
                    ),
                    child: Text(
                      getButtonTextByStatus(item.result),
                      style: LMSStyles.tsWhiteNeutral50W60016.copyWith(color: baseColor), // 🔵 text
                    ),
                  ),
                ),
              ),
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text("Duration: ${item.duration}")),
                                   Expanded(child: Text("Result: ${item.resultStatus}")),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Status: ${item.courseStatus}")),
                                   Expanded(child: Text("Total Marks: ${item.totalMarks}")),
                                ],
                              ),
                             
                             
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // handle attempt
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Attempted ${item.courseName}")));
                                },
                                child: Text("Attempt"),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
Color getButtonColorByStatus(String status) {
  if (status == LMSStrings.strNoCompetent) {
    return LearningColors.red;
  } else if (status == LMSStrings.strCompetent) {
    return LearningColors.secondary550;
  }  else {
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
