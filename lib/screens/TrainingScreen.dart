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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<TrainingProvider>(context);
    final categories = courseProvider.coursesByCategory.keys.toList();

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      // Show loading spinner while fetching data

      return WillPopScope(
        onWillPop: () async {
          ShowDialogs.exitDialog();
          return false;
        },
        child: Scaffold(
         
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isSearchClickVisible: () {
                // provider.toggleSearchIconCategory();
              },
              isSearchValueVisible: provider.isSearchIconVisible,
               onMenuPressed: () => scaffoldKey.currentState?.openDrawer(), 
            ),
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
Padding(
  padding: const EdgeInsets.only(left: 8),
  child: Text(
                       "Your Training",
                        style: LMSStyles.tsHeadingbold.copyWith(fontSize: 20),
                   
                      ),
),
                    

                    ],),
                     SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
                  SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Row(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0), // spacing between chips
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
)
,
                    SizedBox(height: 8),
                    if (selectedCategory != null &&
                        courseProvider.coursesByCategory[selectedCategory!] !=
                            null) ...[
                      ...courseProvider.coursesByCategory[selectedCategory!]!
                          .map((course) => _buildVerticalCard(course))
                          .toList()
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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
                  // LearningColors.white,
                Colors.red.shade100,
                 Colors.red.shade100,
                  Colors.red.shade100,
                Colors.red.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ):LinearGradient(
              colors: [
                LearningColors.white,
               LearningColors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
         ),
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
                          Text(course.courseDuration, style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                   
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                course.status=="Expired"?
                 Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('The Course has been expired',
                              overflow: TextOverflow.ellipsis,
                              style: LMSStyles.tsSubHeadingBold.copyWith(color: LearningColors.red,fontSize: 12)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                    onPressed: () {
                      
                       
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeHorizontal * 24,
                          SizeConfig.blockSizeVertical * 4),
                      backgroundColor: LearningColors.darkBlue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                ):Padding(
                  padding: const EdgeInsets.only(top: 4,bottom: 16),
                  child: Container(child: Row(
                    children: [
                      Expanded(
                        child: ProgressBar(
                                                                                                                          currentPosition: double.parse(course.completionPercentage),
                                                                                                                          duration: double.parse("100"), // Total video duration
                                                                                                                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Text("${course.completionPercentage} %")
                    ],
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
