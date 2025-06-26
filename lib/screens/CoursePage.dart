import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetCourseListResponse.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'OrderSummary.dart';

class CoursePage extends StatefulWidget {
  static const String route = "/CoursePage";
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCategory;
  String? selectedModule;
  bool isSelected = false;

  // @override
  // void initState() {
  //   super.initState();

  //   // Delay the initialization to avoid calling Provider before build
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final courseProvider =
  //         Provider.of<CourseProvider>(context, listen: false);
  //     if (courseProvider.coursesByCategory.isNotEmpty) {
  //       setState(() {
  //         selectedCategory = courseProvider.coursesByCategory.keys.first;
  //       });
  //     }
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);

      // if (!provider.isSubscriptionLoading) {
      provider.getCategoryList();

       final courseProvider = Provider.of<CourseProvider>(context, listen: false);
      courseProvider.courseListAPI("all");
      // }
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          // maxChildSize: 0.9,
          // minChildSize: 0.4,
          // initialChildSize: 0.85,
          initialChildSize: 0.55, // Start at 30% of screen height
          minChildSize: 0.55, // Can't shrink below 30%
          maxChildSize: 0.55,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 500), // Fixed width
                      child: Column(
                        children: [
                          // Content Scrollable
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Header row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Filter',
                                            style: TextStyle(
                                                color: LearningColors.black18,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20)),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedLocations.clear();
                                              selectedRanks.clear();
                                              selectedVesselTypes.clear();
                                              selectedDurations.clear();
                                              selectedBridgeWatch.clear();
                                              selectedEngineWatch.clear();
                                            });
                                          },
                                          child: Text('Reset',
                                              style: TextStyle(
                                                  color:
                                                      LearningColors.darkBlue,
                                                  fontSize: 18)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    // Filter sections
                                    _buildFilterSection(
                                      title: 'Location',
                                      options: locations,
                                      selectedOptions: selectedLocations,
                                      setState: setState,
                                    ),
                                    _buildFilterSection(
                                      title: 'Vessel Type',
                                      options: vesselTypes,
                                      selectedOptions: selectedVesselTypes,
                                      setState: setState,
                                    ),
                                    _buildFilterSection(
                                      title: 'Duration',
                                      options: durations,
                                      selectedOptions: selectedDurations,
                                      setState: setState,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// Fixed Action Buttons
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, -5),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        side: BorderSide(
                                          color: LearningColors.darkBlue,
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: LearningColors.darkBlue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print(
                                            'Selected Locations: $selectedLocations');
                                        print(
                                            'Selected Vessel Types: $selectedVesselTypes');
                                        print(
                                            'Selected Durations: $selectedDurations');
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            LearningColors.darkBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: LearningColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required List<String> selectedOptions,
    required void Function(void Function()) setState,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: LMSStyles.tsSubHeadingBold),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              showCheckmark: false, // ✅ Hides the tick mark
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedOptions.add(option);
                  } else {
                    selectedOptions.remove(option);
                  }
                });
              },
              selectedColor: LearningColors.darkBlue,
              labelStyle: TextStyle(
                color: isSelected ? LearningColors.neutral100 : Colors.black,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  final List<String> locations = [
    'Asia',
    'Africa',
    'Europe',
  ];
  final List<String> ranks = [
    'Captains/Masters (50)',
    'Officers (50)',
  ];
  final List<String> vesselTypes = [
    'Containers (50)',
    'Tankers (50)',
  ];
  final List<String> durations = [
    '1-10 Days',
    '10-20 Days',
    '20-30 Days',
  ];
  final List<String> bridgeWatch = [
    'Level 1',
    'Level 2',
    'Level 3',
  ];
  final List<String> engineWatch = [
    'Level 1',
    'Level 2',
    'Level 3',
  ];

  String? selectedRank;
  String? selectedVesselType;
  String? selectedDuration;
  List<String> selectedLocations = [];
  List<String> selectedRanks = [];
  List<String> selectedVesselTypes = [];
  List<String> selectedDurations = [];
  List<String> selectedBridgeWatch = [];
  List<String> selectedEngineWatch = [];

  @override
  Widget build(BuildContext context) {
    // final courseProvider = Provider.of<CourseProvider>(context);
    return Consumer<CourseProvider>(builder: (context, courseProvider, _) {
      // Show loading spinner while fetching data

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
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Ongoing Course",
                        style: LMSStyles.tsblackTileBold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CurrentCourseCard(
                        courseTitle: "Fundamental: Marine Navigation",
                        progress: 0.65,
                        currentModule: "Module 3: Navigation Techniques",
                        onModuleChanged: (value) {
                          setState(() {
                            selectedModule = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Explore Courses",
                            style: LMSStyles.tsblackTileBold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showFilterBottomSheet(context);
                          },
                          child: SvgPicture.asset(
                            LMSImagePath.filter,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                  

                    courseChips(),
                    SizedBox(height: 8),

                     listing(courseProvider)
                      
                    // ]
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
Widget listing(CourseProvider courseProvider)
{
      final courseProvider = Provider.of<CourseProvider>(context);
   
    if (courseProvider.isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: LearningColors.darkBlue,
      ));
    }
   return Column(
      children: courseProvider.courseList
          .map((course) => _buildVerticalCard(course))
          .toList(),
    );
}
  Widget courseChips() {
    final landingProvider = Provider.of<LandingScreenProvider>(context);
     final courseProvider = Provider.of<CourseProvider>(context);
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
                selected: selectedCategory == "all",
                showCheckmark: false,
               onSelected: (selected) {
                  courseProvider.selectCategory("all");
                },
                selectedColor: LearningColors.darkBlue,
                backgroundColor: courseProvider.selectedCategory == "all"? LearningColors.darkBlue:Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: courseProvider.selectedCategory == "all"
                      ? LearningColors.neutral100
                      : Colors.black
                ),
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
                    color:courseProvider.selectedCategory == categoryId
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

  Widget _buildVerticalCard(CourseData course,) {
    //   final courseProvider = Provider.of<CourseProvider>(context);
    // // final categories = courseProvider.coursesByCategory.keys.toList();
    

    // if (courseProvider.isLoading) {
    //   return Center(
    //       child: CircularProgressIndicator(
    //     color: LearningColors.darkBlue,
    //   ));
    // }
    return GestureDetector(
      onTap: () {
        Navigator.of(routeGlobalKey.currentContext!)
            .pushNamed(CourseDetailPage.route,
            arguments: {
                "courseID": course.id.toString()
              })
            .then((value) {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Card background with gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.grey[50]!,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course image placeholder
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: LearningColors.darkBlue.withOpacity(0.1),
                          // image:
                          //  course.imageUrl != null
                          //     ? DecorationImage(
                          //         image: NetworkImage(course.imageUrl!),
                          //         fit: BoxFit.cover,
                          //       )
                          //     : null,
                        ),
                        // child: course.imageUrl == null
                        //     ? Center(
                        //         child: Icon(
                        //           Icons.school,
                        //           size: 40,
                        //           color: LearningColors.darkBlue,
                        //         ),
                        //       )
                        //     : null,
                      ),
                      SizedBox(height: 12),

                      // Course title and institute
                      Text(
                        course.centerName!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: LearningColors.darkBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        course.courseName!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),

                      // Course description
                      Text(
                        course.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),

                      // Course metadata (mode, duration) with category badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Changed to spaceEvenly for full width distribution
                        children: [
                          // Mode section
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(LMSImagePath.mode),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1),
                                Text(course.trainingMode!, style: LMSStyles.tsHeading),
                              ],
                            ),
                          ),

                          // Duration section
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(LMSImagePath.time),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1),
                                Text(course.duration!,
                                    style: LMSStyles.tsHeading),
                              ],
                            ),
                          ),

                          // Category section
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 14,
                                  color: LearningColors.darkBlue,
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1),
                                Text(
                                 "General",
                                  style: LMSStyles.tsHeading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Price and enroll button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price information
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'INR ${course.pricing!}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: LearningColors.darkBlue,
                                ),
                              ),
                            ],
                          ),

                          // Enroll button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(OrderSummaryScreen.route)
                                  .then((value) {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LearningColors.darkBlue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              LMSStrings.strEnrollNow,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Popular badge
              //if (course.isPopular)
              Positioned(
                top: 24,
                left: 24,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Popular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8), // rounded square
                    // border: Border.all(width: 1)
                  ),
                  child: IconButton(
                    icon: Icon(
                      isSelected ? Icons.bookmark : Icons.bookmark_border,
                      color: LearningColors.darkBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getDisplayCategory(String selectedCategory) {
    return selectedCategory == 'All' ? 'General' : selectedCategory;
  }
}
