import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetCourseInstitueResponse.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
import 'package:learning_mgt/screens/Videoscreen.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

import '../Utils/lms_styles.dart';
import '../model/GetCourseDetailListResponse.dart';
import '../widgets/CustomDropdown.dart';
import 'OrderSummary.dart';
import 'TabScreen.dart';

class CourseDetailPage extends StatefulWidget {
  final String? courseID;
  static const String route = "/CourseDetailPage";

  const CourseDetailPage({super.key, this.courseID});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSelected = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      if (!courseProvider.isLoading) {
        courseProvider.courseDetailAPI(widget.courseID!);
      }

      if (!courseProvider.isResourceLoading) {
        courseProvider.courseResouceAPI(widget.courseID!, "All", "All");
      }
      print("INSITUTUE");
      print(courseProvider.isInstituteLoading);
      if (!courseProvider.isInstituteLoading) {
        print("INSITUTUE");
        courseProvider.courseInstituteAPI(widget.courseID!, "All");
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Consumer<CourseProvider>(builder: (context, courseProvider, _) {
      if (courseProvider.isLoading) {
        return Scaffold(
          backgroundColor: LearningColors.white,
          body: const Center(
            child: CircularProgressIndicator(
              color: LearningColors.darkBlue,
            ),
          ),
        );
      }
      return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {},
            isSearchValueVisible: false,
            onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ),
        endDrawer: CustomDrawer(),
        backgroundColor: LearningColors.white,
        body: CustomScrollView(
          slivers: [
            // Fixed Header Section
            SliverToBoxAdapter(
              child: Container(
                height: 250, // Fixed height for header
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      LMSImagePath.coverbg,
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withOpacity(0.4)),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(routeGlobalKey.currentContext!).pushNamed(
                            TabScreen.route,
                            arguments: {
                              'selectedPos': 0,
                              'isSignUp': false,
                            },
                          );
                        },
                        // onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Video navigation logic
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_fill,
                                size: 64, color: Colors.white),
                            SizedBox(height: 8),
                            Text(
                              "Watch Demo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Course Info Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Course Name", style: LMSStyles.tsblackTileBold),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isSelected
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: LearningColors.darkBlue,
                            ),
                            onPressed: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 16,
                          color: LearningColors.neutral300,
                        ),
                        SizedBox(width: 4),
                        Text("45 Lectures",
                            style: LMSStyles.tsWhiteNeutral300W300),
                        SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: LearningColors.neutral300,
                        ),
                        SizedBox(width: 4),
                        Text("160 Hours",
                            style: LMSStyles.tsWhiteNeutral300W300),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // TabBar (pinned to stay visible while scrolling)
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabBarDelegate(
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: LearningColors.darkBlue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: LearningColors.darkBlue,
                  labelStyle: LMSStyles.tsSubHeadingBold,
                  unselectedLabelStyle: LMSStyles.tsWhiteNeutral300W300,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: "About"),
                    Tab(text: "Institute"),
                    Tab(text: "Modules"),
                    Tab(text: "Resources"),
                    Tab(text: "FAQs"),
                    Tab(text: "Reviews"),
                  ],
                ),
              ),
            ),

            // Tab Content
            SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutTab(),
                  _buildInstituteTab(courseProvider),
                  _buildModulesTab(),
                  _buildResourcesTab(courseProvider),
                  _buildFAQsTab(),
                  _buildReviewsTab()
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(OrderSummaryScreen.route)
                    .then((value) {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LearningColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Enroll for ₹499/mo',
                style: LMSStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
              ),
            ),
          ),
        ),
      );
    });
  }

  /*Widget _buildAboutTab() {
    String aboutText =
        "Foundations of User Experience (UX) Design is the first of a series of seven courses that will equip you with the skills needed to apply to entry-level jobs in user experience design. Through a mix of videos, readings, and hands-on activities, you’ll learn how to describe common job responsibilities of entry-level UX designers and explore job opportunities in the field of UX design...";

    bool isExpanded = false; // declare outside

    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About this Course", style: LMSStyles.tsSubHeadingBold),
              SizedBox(height: 8),
              Text(
                isExpanded || aboutText.length <= 100
                    ? aboutText
                    : aboutText.substring(0, 100) + "...",
                style: LMSStyles.tsWhiteNeutral300W500,
              ),
              SizedBox(height: 4),
              if (aboutText.length > 100)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? "Read less" : "Read more",
                    style: TextStyle(color: LearningColors.darkBlue),
                  ),
                ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 8),
              Text("Course Level", style: LMSStyles.tsWhiteNeutral300W300),
              Text("Beginner", style: LMSStyles.tsblackTileBold),
              SizedBox(height: 12),
              Text("160 Hours of Lectures",
                  style: LMSStyles.tsWhiteNeutral300W300),
              Text("1 Month at 5 hours a week",
                  style: LMSStyles.tsblackTileBold),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              Text("Skills you'll learn", style: LMSStyles.tsSubHeadingBold),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _skillChip("User Experience"),
                  _skillChip("UX Research"),
                  _skillChip("Wireframes"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }*/

  Widget _buildAboutTab() {
    // Use the course description from the API response
    final provider = Provider.of<CourseProvider>(context, listen: false);
    final courseDetail = provider.courseDetail;
    String aboutText = courseDetail.description ?? "No description available";

    bool isExpanded = false; // declare outside

    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About this Course", style: LMSStyles.tsSubHeadingBold),
              SizedBox(height: 8),
              Text(
                isExpanded || aboutText.length <= 100
                    ? aboutText
                    : aboutText.substring(0, 100) + "...",
                style: LMSStyles.tsWhiteNeutral300W500,
              ),
              SizedBox(height: 4),
              if (aboutText.length > 100)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? "Read less" : "Read more",
                    style: TextStyle(color: LearningColors.darkBlue),
                  ),
                ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 8),
              /*Text("Course Level", style: LMSStyles.tsWhiteNeutral300W300),
              Text("Beginner", style: LMSStyles.tsblackTileBold),*/
              Text("Training mode", style: LMSStyles.tsWhiteNeutral300W300),
              Text("${courseDetail.trainingMode}", style: LMSStyles.tsblackTileBold),
              SizedBox(height: 12),
              // Use duration from API response with "Hours" suffix
              Text("Duration",
                  style: LMSStyles.tsWhiteNeutral300W300),
              Text("${courseDetail.duration ?? '0'} Hours of Lectures", style: LMSStyles.tsblackTileBold),
              // Text("1 Month at 5 hours a week", style: LMSStyles.tsblackTileBold),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              Text("Skills you'll learn", style: LMSStyles.tsSubHeadingBold),
              SizedBox(height: 8),
              if (courseDetail.topicsList != null && courseDetail.topicsList!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: courseDetail.topicsList!
                      .where((topic) => topic.isNotEmpty) // Filter out empty strings
                      .map((topic) => _skillChip(topic))
                      .toList(),
                )
              else
                Text("No skills listed", style: LMSStyles.tsWhiteNeutral300W300),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              if (courseDetail.languagesList != null && courseDetail.languagesList!.isNotEmpty)
              Text("Languages", style: LMSStyles.tsSubHeadingBold),
              SizedBox(height: 8),
              if (courseDetail.languagesList != null && courseDetail.languagesList!.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: courseDetail.languagesList!
                      .map((language) => _languageChip(language.languagesName ?? "Unknown"))
                      .toList(),
                )
            ],
          ),
        );
      },
    );
  }

  Widget _languageChip(String language) {
    return Chip(
      label: Text(language),
      backgroundColor: Colors.blue[50],  // Different color to distinguish from skills
      labelStyle: TextStyle(color: Colors.blue[800]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _skillChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blue[50], // Light blue background
      labelStyle: TextStyle(color: Colors.blue[800]), // Dark blue text
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildInstituteTab(CourseProvider courseProvider) {
    // final List<Map<String, dynamic>> institutes = [
    //   {
    //     'logo': 'assets/images/aims.png',
    //     'name':
    //         'AIMS Institute of Maritime Studies (Sucursal De Seafarers Training Center, Inc. - PANAMÁ)',
    //     'address':
    //         '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
    //     'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
    //     'email': 'training@aimsmaritime.com',
    //     'start_date': '12-06-2023',
    //     'end_date': '12-12-2023',
    //     'duration': '6 Months',
    //     'daily_timings': [
    //       '09:00 AM - 11:00 AM',
    //       '11:30 AM - 01:30 PM',
    //       '02:30 PM - 04:30 PM'
    //     ],
    //   },
    //   {
    //     'logo': 'assets/images/maritime.png',
    //     'name': 'Centre for Maritime Education and Training (CMET)',
    //     'address': 'Bakshi, Ka Talab, Lucknow, India',
    //     'phone': '+915222735015',
    //     'email': 'cmetlucknow@gmail.com',
    //     'start_date': '01-08-2023',
    //     'end_date': '01-11-2023',
    //     'duration': '3 Months',
    //     'daily_timings': [
    //       '08:00 AM - 10:00 AM',
    //       '10:30 AM - 12:30 PM',
    //       '01:30 PM - 03:30 PM'
    //     ],
    //   },
    // ];

    final List<String> countries = ['India', 'USA', 'UK', 'Australia'];
    final List<String> states = ['Kerala', 'Tamil Nadu', 'Karnataka', 'Maharashtra'];

    // State variables for dropdown values
    String? selectedCountry;
    String? selectedState;

 if (courseProvider.isInstituteLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: LearningColors.darkBlue,
      ));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              // Country dropdown
              Expanded(
                child: CustomDropdown<String>(
                  value: selectedCountry,
                  hintText: "Select Country",
                  items: countries,
                  onChanged: (value) {
                    selectedCountry = value;
                  },
                ),
              ),
              const SizedBox(width: 12),
              // State dropdown
              Expanded(
                child: CustomDropdown<String>(
                  value: selectedState,
                  hintText: "Select State",
                  items: states,
                  onChanged: (value) {
                    selectedState = value;
                    // You can add filtering logic here if needed
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: _buildInstituteList(courseProvider.instituteDetail),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInstituteList( List<InstituteData> instituteDetail) {
    return instituteDetail.map((institute) {
      return Card(
        color: LearningColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Institute Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo (only for the main info)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                       'assets/images/maritime.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institute.name ?? "",
                          style:
                              LMSStyles.tsblackTileBold2.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 8),

                        // Address
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${institute.addressLineOne} ${institute.addressLineTwo} ${institute.city} ${institute.country}",
                                style: LMSStyles.tsWhiteNeutral300W500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Phone
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${institute.mobilenumber.toString()}" ,
                                style: LMSStyles.tsWhiteNeutral300W500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Email
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${institute.email}",
                                style: LMSStyles.tsWhiteNeutral300W500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Start Date & Duration
                        // Row(
                        //   children: [
                        //     Icon(Icons.calendar_today,
                        //         color: Colors.orange, size: 16),
                        //     const SizedBox(width: 8),
                        //     Text(
                        //       'Start: ${institute.joiningDate}',
                        //       style: LMSStyles.tsWhiteNeutral300W500
                        //           .copyWith(fontWeight: FontWeight.bold),
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Icon(Icons.timer, color: Colors.orange, size: 16),
                        //     const SizedBox(width: 8),
                        //     Text(
                        //       // institute['duration'] as String,
                        //       "duration",
                        //       style: LMSStyles.tsWhiteNeutral300W500
                        //           .copyWith(fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Timings Section with logo
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const SizedBox(width: 12),

                  // Timings chips (2 per row)
                  Expanded(
                    child: Wrap(
                      spacing: 0,
                      runSpacing: 0,
                      children: (institute.batches as List<BatchData>)
                          .map((batchData) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width ), // Calculate half width minus padding
                          child: Chip(
                            label: Text(
                              "${batchData.startDate.toString()} to ${batchData.endDate.toString()}",
                              style: LMSStyles.tsWhiteNeutral300W500
                                  .copyWith(fontSize: 12),
                            ),
                            backgroundColor: Colors.orange.withOpacity(0.2),
                            labelStyle: TextStyle(color: Colors.orange),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  /*Widget _buildModulesTab() {
    final modules = [
      {
        'title': 'What is User Experience Design?',
        'lectures': [
          'Introduction: a UXD Parable.',
          'What UXD Isn\'t?',
          'What UXD is?',
          'Why should we care about UXD',
        ],
      },
      {
        'title': 'Understanding the elements of user experience?',
        'lectures': [
          'Lecture 1',
          'Lecture 2',
          'Lecture 3',
          'Lecture 4',
        ],
      },
      {
        'title': 'Using the elements - Strategy',
        'lectures': ['Lecture 1', 'Lecture 2', 'Lecture 3', 'Lecture 4'],
      },
      {
        'title': 'Using the elements - Scope',
        'lectures': ['Lecture 1', 'Lecture 2', 'Lecture 3', 'Lecture 4'],
      },
      {
        'title': 'Using the elements - Structure',
        'lectures': ['Lecture 1', 'Lecture 2', 'Lecture 3', 'Lecture 4'],
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
        children: modules.asMap().entries.map<ExpansionPanelRadio>((entry) {
          final index = entry.key + 1; // 1-based index
          final module = entry.value;

          return ExpansionPanelRadio(
            backgroundColor: LearningColors.white,
            value: index,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  '$index. ${module['title']}',
                  style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 15),
                ),
                subtitle: Text("4 lectures  |  4 min",
                    style: LMSStyles.tsWhiteNeutral300W500),
              );
            },
            body: Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: List.generate(
                  (module['lectures'] as List<String>).length * 2 - 1,
                  (i) {
                    final isDivider = i.isOdd;
                    if (isDivider) return Divider(color: Colors.grey.shade300);
                    final index = i ~/ 2;
                    final lecture = (module['lectures'] as List<String>)[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.play_circle_fill,
                          color: LearningColors.darkBlue),
                      title:
                          Text(lecture, style: LMSStyles.tsWhiteNeutral300W500),
                      trailing:
                          Text("4:24", style: LMSStyles.tsWhiteNeutral300W500),
                    );
                  },
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }*/

  Widget _buildModulesTab() {
    final provider = Provider.of<CourseProvider>(context, listen: false);
    final courseDetail = provider.courseDetail;
    final modules = courseDetail.modulesList ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: modules.isEmpty
          ? Center(
        child: Text(
          "No modules available",
          style: LMSStyles.tsWhiteNeutral300W500,
        ),
      )
          : ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
        children: modules.asMap().entries.map<ExpansionPanelRadio>((entry) {
          final index = entry.key + 1; // 1-based index
          final module = entry.value;

          return ExpansionPanelRadio(
            backgroundColor: LearningColors.white,
            value: index,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  '$index. ${module.moduleName ?? "Untitled Module"}',
                  style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 15),
                ),
                /*subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    module.moduleDescription!,
                    style: LMSStyles.tsWhiteNeutral300W500,
                  ),
                ),*/
              );
            },
            body: Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.play_circle_fill,
                        color: LearningColors.darkBlue),
                    title: Text(
                      "Module Content",
                      style: LMSStyles.tsWhiteNeutral300W500,
                    ),
                    trailing: Text(
                      "${module.moduleHours ?? '0'}:00:00",
                      style: LMSStyles.tsWhiteNeutral300W500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      module.moduleDescription!,
                      style: LMSStyles.tsWhiteNeutral300W500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResourcesTab(CourseProvider courseProvider) {
    // Initialize with the first language if available
    String? selectedLanguage = courseProvider.courseDetail.languagesList?.isNotEmpty ?? false
        ? courseProvider.courseDetail.languagesList!.first.languagesName
        : null;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            // Language dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomDropdown<String>(
                value: selectedLanguage,
                hintText: "Select Language",
                items: courseProvider.courseDetail.languagesList
                    ?.map((lang) => lang.languagesName ?? "Unknown")
                    .toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });

                  // Call API to get resources for selected language
                  final selectedLang = courseProvider.courseDetail.languagesList
                      ?.firstWhere((lang) => lang.languagesName == value);

                  if (selectedLang != null) {
                    courseProvider.courseResouceAPI(
                      courseProvider.courseDetail.id.toString(),
                      "", // moduleid - adjust if needed
                      selectedLang.id.toString(),
                    );
                  }
                },
              ),
            ),

            // Show loading or resources list
            if (courseProvider.isResourceLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: LearningColors.darkBlue,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  itemCount: courseProvider.resourceDetail.length,
                  itemBuilder: (context, index) {
                    final resource = courseProvider.resourceDetail[index];
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        color: LearningColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  resource.modulename!,
                                  style: TextStyle(
                                    color: Colors.orange.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                resource.materialLabel!,
                                style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _handleResourceAction(
                                        resource.materialType!, resource.materialLink!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LearningColors.darkBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _getResourceIcon(resource.materialType!),
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      _getResourceText(resource.materialType!),
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
                ),
              ),
          ],
        );
      },
    );
  }

  /*Widget _buildResourcesTab(CourseProvider courseProvider) {
    String? selectedLanguage;

    if (courseProvider.isResourceLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: LearningColors.darkBlue,
      ));
    }
    return Column(
      children: [Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: CustomDropdown<String>(
          value: selectedLanguage,
          hintText: "Select Language",
          items: courseProvider.courseDetail.languagesList
              ?.map((lang) => lang.languagesName ?? "Unknown")
              .toList() ?? [],
          onChanged: (value) {
            selectedLanguage = value;
            // Call API to get resources for selected language
            final selectedLangId = courseProvider.courseDetail.languagesList
                ?.firstWhere((lang) => lang.languagesName == value)
                .id
                .toString();

            if (selectedLangId != null) {
              courseProvider.courseResouceAPI(
                courseProvider.courseDetail.id.toString(),
                "", // moduleid - adjust if needed
                selectedLangId,
              );
            }
          },
        ),
      ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            itemCount: courseProvider.resourceDetail.length,
            itemBuilder: (context, index) {
              final resource = courseProvider.resourceDetail[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                child: Card(
                  color: LearningColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            resource.modulename!,
                            style: TextStyle(
                              color: Colors.orange.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          resource.materialLabel!,
                          style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                        ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   resource.description!,
                        //   style: LMSStyles.tsWhiteNeutral300W500,
                        // ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _handleResourceAction(
                                  resource.materialType!, resource.materialLink!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LearningColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _getResourceIcon(resource.materialType!),
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                _getResourceText(resource.materialType!),
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
          ),
        ),
      ],
    );
  }*/

  IconData _getResourceIcon(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'image':
        return Icons.image;
      case 'link':
        return Icons.open_in_new;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'zip':
        return Icons.archive;
      default:
        return Icons.description;
    }
  }

  Text textOnButton(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _getResourceText(String type) {
    switch (type) {
      case 'video':
        return textOnButton('Watch Video');
      case 'image':
        return textOnButton('View Image');
      case 'link':
        return textOnButton('Open Link');
      case 'pdf':
        return textOnButton('Open PDF');
      case 'zip':
        return textOnButton('Open zip');
      default:
        return textOnButton('Open');
    }
  }

  void _handleResourceAction(String type, String resourcelink) {
    switch (type) {
      case 'video':
        // Navigate to video screen
        print('Playing video: ${resourcelink}');
        break;
      case 'link':
        // Open external link
        print('Opening link: ${resourcelink}');
        break;
      case 'pdf':
        // Download PDF
        print('Downloading PDF: ${resourcelink}');
        break;
      case 'zip':
        // Download ZIP
        print('Downloading ZIP: ${resourcelink}');
        break;
    }
  }

  Widget _buildFAQsTab() {
    final faqs = [
      {
        "question": "What is User Experience Design?",
        "answer":
            "Designed for seafarers, crew members, and maritime professionals, this program emphasizes leadership, teamwork, and effective risk management. Participants will engage in real-world simulations and case studies..."
      },
      {
        "question": "Understanding the elements of user experience?",
        "answer":
            "This section covers key concepts around user needs, research techniques, and evaluation."
      },
      {
        "question": "Using the elements - Strategy",
        "answer":
            "Strategy layer helps you define your user needs and business goals."
      },
      {
        "question": "Using the elements - Scope",
        "answer": "Scope includes defining functional and content requirements."
      },
      {
        "question": "Using the elements - Structure",
        "answer":
            "Structure focuses on interaction design and information architecture."
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ExpansionPanelList.radio(
          expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 4),
          elevation: 2,
          children: faqs.asMap().entries.map<ExpansionPanelRadio>((entry) {
            final index = entry.key + 1;
            final item = entry.value;

            return ExpansionPanelRadio(
              backgroundColor: LearningColors.white,
              value: index,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text('$index. ${item['question']!}',
                      style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 15)),
                );
              },
              body: Container(
                color: Colors.blue.shade50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  item['answer']!,
                  style: LMSStyles.tsWhiteNeutral300W500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewsTab() {
    final reviews = [
      {
        "name": "Ethel King",
        "date": "Jan 15, 25",
        "title": "Great course! smooth content",
        "content":
            "Designed for seafarers, crew members, and maritime professionals, this program emphasizes leadership, teamwork..."
      },
      {
        "name": "Ricky Cole",
        "date": "Jan 15, 25",
        "title": "Great course! smooth content",
        "content":
            "Designed for seafarers, crew members, and maritime professionals, this program emphasizes leadership, teamwork..."
      },
      {
        "name": "Michael Rolfson",
        "date": "Jan 12, 25",
        "title": "Great course! smooth content",
        "content":
            "Designed for seafarers, crew members, and maritime professionals, this program emphasizes leadership, teamwork..."
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final item = reviews[index];
        return Card(
          color: LearningColors.white,
          margin: EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: List.generate(
                        4,
                        (i) =>
                            Icon(Icons.star, color: Colors.amber, size: 16))),
                SizedBox(height: 8),
                Text(item['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item['date']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 8),
                Text(item['title']!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item['content']!),
              ],
            ),
          ),
        );
      },
    );
  }

  /*Widget _skillChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey.shade200,
    );
  }*/

  //  void _navigateToVideoScreen(
  //     String video,
  //     String videoTopicSlug,
  //     String videoCourseSlug,
  //     String videoWatchTime,
  //     bool isTrailer,
  //     String courseID,
  //     String topicID,
  //    ) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => VideoScreen(
  //               videoCategory: "",
  //               video: video,
  //               videoCourseSlug: videoCourseSlug,
  //               videoTopicSlug: videoTopicSlug,
  //               videoWatchTime: videoWatchTime,
  //               isTrailer: isTrailer,
  //               courseID: courseID,
  //               topicID: topicID,

  //             )),
  //   );

  //   // If the result is true, trigger the refresh logic for the previous page
  //   if (result == true) {
  //     Navigator.pushReplacementNamed(
  //       routeGlobalKey.currentContext!,
  //       CourseDetailPage.route,

  //     );
  //   }
  // }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: LearningColors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
