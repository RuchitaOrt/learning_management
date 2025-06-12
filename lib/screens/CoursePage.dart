import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/ShowDialog.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomDrawer.dart';

class CoursePage extends StatefulWidget {
  static const String route = "/CoursePage";
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    // Delay the initialization to avoid calling Provider before build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      if (courseProvider.coursesByCategory.isNotEmpty) {
        setState(() {
          selectedCategory = courseProvider.coursesByCategory.keys.first;
        });
      }
    });
  }

  void _showFilterDialog(BuildContext context) {
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter', style: TextStyle(
                    color: LearningColors.black18,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  )),
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
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: LearningColors.darkBlue,
                        fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Location', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: locations.map((location) {
                        final isSelected = selectedLocations.contains(location);
                        return FilterChip(
                          label: Text(location),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedLocations.add(location);
                              } else {
                                selectedLocations.remove(location);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    Text('Rank/Position', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: ranks.map((rank) {
                        final isSelected = selectedRanks.contains(rank);
                        return FilterChip(
                          label: Text(rank),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedRanks.add(rank);
                              } else {
                                selectedRanks.remove(rank);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Vessel Type', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: vesselTypes.map((vesselType) {
                        final isSelected = selectedVesselTypes.contains(vesselType);
                        return FilterChip(
                          label: Text(vesselType),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedVesselTypes.add(vesselType);
                              } else {
                                selectedVesselTypes.remove(vesselType);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Duration', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: durations.map((duration) {
                        final isSelected = selectedDurations.contains(duration);
                        return FilterChip(
                          label: Text(duration),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedDurations.add(duration);
                              } else {
                                selectedDurations.remove(duration);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Bridge Watch', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: bridgeWatch.map((bWatch) {
                        final isSelected = selectedBridgeWatch.contains(bWatch);
                        return FilterChip(
                          label: Text(bWatch),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedBridgeWatch.add(bWatch);
                              } else {
                                selectedBridgeWatch.remove(bWatch);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Engine Watch', style: LMSStyles.tsSubHeadingBold),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: engineWatch.map((eWatch) {
                        final isSelected = selectedEngineWatch.contains(eWatch);
                        return FilterChip(
                          label: Text(eWatch),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedEngineWatch.add(eWatch);
                              } else {
                                selectedEngineWatch.remove(eWatch);
                              }
                            });
                          },
                          selectedColor: LearningColors.darkBlue,
                          checkmarkColor: LearningColors.neutral100,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? LearningColors.neutral100
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: LearningColors.darkBlue),),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filters here
                    print('Selected Locations: $selectedLocations');
                    print('Selected Ranks: $selectedRanks');
                    print('Selected Vessel Types: $selectedVesselTypes');
                    print('Selected Durations: $selectedDurations');
                    print('Selected Bridge Watch: $selectedBridgeWatch');
                    print('Selected Engine Watch: $selectedEngineWatch');

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LearningColors.darkBlue,
                  ),
                  child: Text('Apply', style: TextStyle(color: LearningColors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
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
                            "Courses",
                            style:
                                LMSStyles.tsHeadingbold.copyWith(fontSize: 20),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showFilterDialog(context);
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
                              padding: const EdgeInsets.only(right: 8.0), // spacing between chips
                              child: ChoiceChip(
                                label: Text(category),
                                selected: selectedCategory == category,
                                showCheckmark: false,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCategory =
                                        selected ? category : null;
                                  });
                                },
                                selectedColor: LearningColors.darkBlue,
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
        ),
      );
    });
  }

  Widget _buildVerticalCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.of(routeGlobalKey.currentContext!)
            .pushNamed(CourseDetailPage.route)
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
                          image: course.imageUrl != null
                              ? DecorationImage(
                            image: NetworkImage(course.imageUrl!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: course.imageUrl == null
                            ? Center(
                          child: Icon(
                            Icons.school,
                            size: 40,
                            color: LearningColors.darkBlue,
                          ),
                        )
                            : null,
                      ),
                      SizedBox(height: 12),

                      // Course title and institute
                      Text(
                        course.institue.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: LearningColors.darkBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        course.title,
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
                        course.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),

                      // Course metadata (mode, duration)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(LMSImagePath.mode),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Text(course.mode, style: LMSStyles.tsHeading),
                            ],
                          ),
                          SizedBox(width: 24),
                          Row(
                            children: [
                              SvgPicture.asset(LMSImagePath.time),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              Text(course.courseDuration, style: LMSStyles.tsHeading),
                            ],
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
                              /*if (course.discountedAmount != course.amount)
                                Text(
                                  '\$${course.discountedAmount}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey[500],
                                  ),
                                ),*/
                              Text(
                                'INR ${course.amount}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: LearningColors.darkBlue,
                                ),
                              ),
                              /*if (course.discountedAmount != course.amount)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${course.offerPercentage}% OFF',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[800],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),*/
                            ],
                          ),

                          // Enroll button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(CoursePage.route)
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
                  top: 16,
                  right: 16,
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
            ],
          ),
        ),
      ),
    );
  }

// Helper widget for metadata items
  Widget _buildMetaItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: LearningColors.darkBlue,
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  /*Widget _buildVerticalCard(Course course) {
    return GestureDetector(
      onTap: ()
      {
          Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(CourseDetailPage.route)
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
              *//*Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(LMSImagePath.certificateLogo),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      child: Text(
                        course.institue,
                        style: LMSStyles.tsHeadingbold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),*//*
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
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
                    .copyWith(fontWeight: FontWeight.w200, fontSize: 14),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                  *//*Expanded(
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
                   
                  ),*//*
                  Padding(
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
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$ ${course.discountedAmount}',
                            overflow: TextOverflow.ellipsis,
                            style: LMSStyles.tsHeading.copyWith(decoration: TextDecoration.lineThrough, fontSize: LMSStyles.tsHeading.fontSize! + 2),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Text('\$ ${course.amount}',
                              overflow: TextOverflow.ellipsis,
                              style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: LMSStyles.tsSubHeadingBold.fontSize! + 2)),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 5,
                          ),
                          *//*SvgPicture.asset(LMSImagePath.offer),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Text("${course.offerPercentage} off",
                              overflow: TextOverflow.ellipsis,
                              style: LMSStyles.tsSubHeadingBold
                                  .copyWith(color: Colors.green)),*//*
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushNamed(Settings.route)
                        //     .then((value) {});
                        Navigator.of(context)
                            .pushNamed(CoursePage.route)
                            .then((value) {});
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(SizeConfig.blockSizeHorizontal * 40,
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
                        LMSStrings.strEnrollNow,
                        style: LMSStyles.tsWhiteNeutral50W60016,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
