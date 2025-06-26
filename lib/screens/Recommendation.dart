import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';

import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/RecommendedCourseProvider.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';


class Recommendation extends StatefulWidget {
  static const String route = "/Recommendation";
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    // Delay the initialization to avoid calling Provider before build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
          Provider.of<RecommendedCourseProvider>(context, listen: false);
      if (courseProvider.coursesByCategory.isNotEmpty) {
        setState(() {
          selectedCategory = courseProvider.coursesByCategory.keys.first;
        });
      }
    });
  }

  // void _showFilterDialog(BuildContext context) {
  //   final List<String> locations = [
  //     'Asia',
  //     'Africa',
  //     'Europe',
  //   ];
  //   final List<String> ranks = [
  //     'Captains/Masters (50)',
  //     'Officers (50)',
  //   ];
  //   final List<String> vesselTypes = [
  //     'Containers (50)',
  //     'Tankers (50)',
  //   ];
  //   final List<String> durations = [
  //     '1-10 Days',
  //     '10-20 Days',
  //     '20-30 Days',
  //   ];
  //   final List<String> bridgeWatch = [
  //     'Level 1',
  //     'Level 2',
  //     'Level 3',
  //   ];
  //   final List<String> engineWatch = [
  //     'Level 1',
  //     'Level 2',
  //     'Level 3',
  //   ];

  //   String? selectedRank;
  //   String? selectedVesselType;
  //   String? selectedDuration;
  //   List<String> selectedLocations = [];
  //   List<String> selectedRanks = [];
  //   List<String> selectedVesselTypes = [];
  //   List<String> selectedDurations = [];
  //   List<String> selectedBridgeWatch = [];
  //   List<String> selectedEngineWatch = [];

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Filter',
  //                     style: TextStyle(
  //                       color: LearningColors.black18,
  //                       fontWeight: FontWeight.w800,
  //                       fontSize: 20,
  //                     )),
  //                 TextButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       selectedLocations.clear();
  //                       selectedRanks.clear();
  //                       selectedVesselTypes.clear();
  //                       selectedDurations.clear();
  //                       selectedBridgeWatch.clear();
  //                       selectedEngineWatch.clear();
  //                     });
  //                   },
  //                   child: Text(
  //                     'Reset',
  //                     style: TextStyle(
  //                         color: LearningColors.darkBlue, fontSize: 18),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text('Location', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: locations.map((location) {
  //                       final isSelected = selectedLocations.contains(location);
  //                       return FilterChip(
  //                         label: Text(location),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedLocations.add(location);
  //                             } else {
  //                               selectedLocations.remove(location);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text('Rank/Position', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: ranks.map((rank) {
  //                       final isSelected = selectedRanks.contains(rank);
  //                       return FilterChip(
  //                         label: Text(rank),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedRanks.add(rank);
  //                             } else {
  //                               selectedRanks.remove(rank);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Vessel Type', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: vesselTypes.map((vesselType) {
  //                       final isSelected =
  //                           selectedVesselTypes.contains(vesselType);
  //                       return FilterChip(
  //                         label: Text(vesselType),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedVesselTypes.add(vesselType);
  //                             } else {
  //                               selectedVesselTypes.remove(vesselType);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Duration', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: durations.map((duration) {
  //                       final isSelected = selectedDurations.contains(duration);
  //                       return FilterChip(
  //                         label: Text(duration),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedDurations.add(duration);
  //                             } else {
  //                               selectedDurations.remove(duration);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Bridge Watch', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: bridgeWatch.map((bWatch) {
  //                       final isSelected = selectedBridgeWatch.contains(bWatch);
  //                       return FilterChip(
  //                         label: Text(bWatch),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedBridgeWatch.add(bWatch);
  //                             } else {
  //                               selectedBridgeWatch.remove(bWatch);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Engine Watch', style: LMSStyles.tsSubHeadingBold),
  //                   SizedBox(height: 8),
  //                   Wrap(
  //                     spacing: 8.0,
  //                     runSpacing: 4.0,
  //                     children: engineWatch.map((eWatch) {
  //                       final isSelected = selectedEngineWatch.contains(eWatch);
  //                       return FilterChip(
  //                         label: Text(eWatch),
  //                         selected: isSelected,
  //                         onSelected: (selected) {
  //                           setState(() {
  //                             if (selected) {
  //                               selectedEngineWatch.add(eWatch);
  //                             } else {
  //                               selectedEngineWatch.remove(eWatch);
  //                             }
  //                           });
  //                         },
  //                         selectedColor: LearningColors.darkBlue,
  //                         checkmarkColor: LearningColors.neutral100,
  //                         labelStyle: TextStyle(
  //                           color: isSelected
  //                               ? LearningColors.neutral100
  //                               : Colors.black,
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   'Cancel',
  //                   style: TextStyle(color: LearningColors.darkBlue),
  //                 ),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   // Apply filters here
  //                   print('Selected Locations: $selectedLocations');
  //                   print('Selected Ranks: $selectedRanks');
  //                   print('Selected Vessel Types: $selectedVesselTypes');
  //                   print('Selected Durations: $selectedDurations');
  //                   print('Selected Bridge Watch: $selectedBridgeWatch');
  //                   print('Selected Engine Watch: $selectedEngineWatch');

  //                   // Close the dialog
  //                   Navigator.of(context).pop();
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: LearningColors.darkBlue,
  //                 ),
  //                 child: Text('Apply',
  //                     style: TextStyle(color: LearningColors.white)),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

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
    final courseProvider = Provider.of<RecommendedCourseProvider>(context);
    final categories = courseProvider.coursesByCategory.keys.toList();

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      // Show loading spinner while fetching data

      return Scaffold(
        endDrawer: CustomDrawer(),
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {
              // provider.toggleSearchIconCategory();
            },
            isSearchValueVisible: provider.isSearchIconVisible,
            onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
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
                          "Recommendation",
                          style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // spacing between chips
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
      );
    });
  }

  Widget _buildVerticalCard(RecommendedCourse course) {
    final Color baseColor = getButtonColorByStatus(course.courseStatus);
    return GestureDetector(
      onTap: () {
        Navigator.of(routeGlobalKey.currentContext!)
            .pushNamed(CourseDetailPage.route,
            
            arguments: {
                "courseID":"1"
              })
            .then((value) {});
      },
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 75,
                      child: Text(
                        course.institue,
                        style: LMSStyles.tsHeadingbold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(course.title, style: LMSStyles.tsSubHeadingBold),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: SizeConfig.blockSizeVertical * 4.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor.withOpacity(0.1),
                      foregroundColor: baseColor, // 🔵
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: baseColor),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      getButtonTextByStatus(course.courseStatus),
                      style: LMSStyles.tsWhiteNeutral50W60016
                          .copyWith(color: baseColor), // 🔵 text
                    ),
                  ),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (course.status == LMSStrings.strRequested)
                                ? LearningColors.primaryBlue550
                                : (course.status == LMSStrings.strPending)
                                    ? LearningColors.neutral300
                                    : (course.status == LMSStrings.strReappy)
                                        ? LearningColors.red
                                        : LearningColors.darkBlue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        (course.status == LMSStrings.strRequested)
                            ? LMSStrings.strRequested
                            : (course.status == LMSStrings.strPending)
                                ? LMSStrings.strDecline
                                : (course.status == LMSStrings.strReappy)
                                    ? LMSStrings.strDeclined
                                    : LMSStrings.strEnrollNow,
                        style: LMSStyles.tsWhiteNeutral50W60016,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  (course.status == LMSStrings.strRequested)
                      ? Container()
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LearningColors.darkBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              (course.status == LMSStrings.strRequested)
                                  ? LMSStrings.strRequested
                                  : (course.status == LMSStrings.strPending)
                                      ? LMSStrings.strAccept
                                      : (course.status == LMSStrings.strReappy)
                                          ? LMSStrings.strReappy
                                          : LMSStrings.strEnrollNow,
                              style: LMSStyles.tsWhiteNeutral50W60016,
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color getButtonColorByStatus(String status) {
  if (status == LMSStrings.strRecommended) {
    return LearningColors.purple;
  } else if (status == LMSStrings.strMandatory) {
    return LearningColors.darkOrange;
  } else {
    return LearningColors.darkBlue;
  }
}

String getButtonTextByStatus(String status) {
  if (status == LMSStrings.strRecommended) {
    return LMSStrings.strRecommended;
  } else if (status == LMSStrings.strMandatory) {
    return LMSStrings.strMandatory;
  } else {
    return LMSStrings.strEnrollNow;
  }
}
