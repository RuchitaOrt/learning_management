import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/screens/Videoscreen.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';

import '../Utils/lms_styles.dart';
import 'OrderSummary.dart';

class CourseDetailPage extends StatefulWidget {
  static const String route = "/CourseDetailPage";

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
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: scaffoldKey,
  //     appBar: PreferredSize(
  //       preferredSize: const Size.fromHeight(kToolbarHeight),
  //       child: CustomAppBar(
  //         isSearchClickVisible: () {},
  //         isSearchValueVisible: false,
  //         onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
  //       ),
  //     ),
  //     endDrawer: CustomDrawer(),
  //     bottomNavigationBar: SafeArea(
  //       child: Container(
  //         padding: EdgeInsets.all(12),
  //         color: Colors.white,
  //         child: ElevatedButton(
  //           onPressed: () {
  //             Navigator.of(context)
  //                 .pushNamed(OrderSummaryScreen.route)
  //                 .then((value) {});
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: LearningColors.darkBlue,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             padding: EdgeInsets.symmetric(vertical: 14),
  //           ),
  //           child: Text(
  //             'Enroll for ₹499/mo',
  //             style: LMSStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
  //           ),
  //         ),
  //       ),
  //     ),
  //     body: DefaultTabController(
  //       length: 5,
  //       child: CustomScrollView(
  //         slivers: [
  //           SliverAppBar(
  //             pinned: true,
  //             expandedHeight: 250,
  //             leading: IconButton(
  //               icon: Icon(Icons.arrow_back_ios, color: Colors.white),
  //               onPressed: () => Navigator.pop(context),
  //             ),
  //             flexibleSpace: FlexibleSpaceBar(
  //               background: Stack(
  //                 fit: StackFit.expand,
  //                 children: [
  //                   Image.asset(
  //                     LMSImagePath.coverbg,
  //                     fit: BoxFit.cover,
  //                   ),
  //                   Container(color: Colors.black.withOpacity(0.4)),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // _navigateToVideoScreen("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4","","","",false,"","");
  //                     },
  //                     child: Center(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(Icons.play_circle_fill,
  //                               size: 64, color: Colors.white),
  //                           SizedBox(height: 8),
  //                           Text(
  //                             "Watch Demo",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 16),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SliverToBoxAdapter(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text("Course Name",
  //                               style: LMSStyles.tsblackTileBold),
  //                           Container(
  //                             decoration: BoxDecoration(
  //                               color: Colors.blue.shade50,
  //                               borderRadius:
  //                                   BorderRadius.circular(8), // rounded square
  //                             ),
  //                             child: IconButton(
  //                               icon: Icon(
  //                                 isSelected
  //                                     ? Icons.bookmark
  //                                     : Icons.bookmark_border,
  //                                 color: LearningColors.darkBlue,
  //                               ),
  //                               onPressed: () {
  //                                 setState(() {
  //                                   isSelected = !isSelected;
  //                                 });
  //                               },
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(height: 8),
  //                       Row(
  //                         children: [
  //                           Icon(
  //                             Icons.play_circle_outline,
  //                             size: 16,
  //                             color: LearningColors.neutral300,
  //                           ),
  //                           SizedBox(width: 4),
  //                           Text("45 Lectures",
  //                               style: LMSStyles.tsWhiteNeutral300W300),
  //                           SizedBox(width: 16),
  //                           Icon(
  //                             Icons.access_time,
  //                             size: 16,
  //                             color: LearningColors.neutral300,
  //                           ),
  //                           SizedBox(width: 4),
  //                           Text("160 Hours",
  //                               style: LMSStyles.tsWhiteNeutral300W300),
  //                         ],
  //                       ),
  //                       //SizedBox(height: 16),
  //                     ],
  //                   ),
  //                 ),
  //                 TabBar(
  //                   tabAlignment: TabAlignment.start,
  //                   controller: _tabController,
  //                   isScrollable: true,
  //                   labelColor: LearningColors.darkBlue,
  //                   unselectedLabelColor: Colors.grey,
  //                   indicatorColor: LearningColors.darkBlue,
  //                   labelStyle: LMSStyles.tsSubHeadingBold,
  //                   unselectedLabelStyle: LMSStyles.tsWhiteNeutral300W300,
  //                   padding: EdgeInsets.symmetric(horizontal: 16),
  //                   tabs: const [
  //                     Tab(text: "About"),
  //                     Tab(text: "Institute"),
  //                     Tab(text: "Modules"),
  //                     Tab(text: "FAQs"),
  //                     Tab(text: "Reviews"),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SliverFillRemaining(
  //             hasScrollBody: true,
  //             child: TabBarView(
  //               controller: _tabController,
  //               children: [
  //                 _buildAboutTab(),
  //                 _buildInstituteTab(),
  //                 _buildModulesTab(),
  //                 _buildFAQsTab(),
  //                 _buildReviewsTab()
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  /*Widget build(BuildContext context) {
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
      // backgroundColor: LearningColors.white,
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
      body: Column(
        // Changed from CustomScrollView to Column
        children: [
          // Fixed Header Section
          Container(
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
                    onPressed: () => Navigator.pop(context),
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
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Fixed Course Info Section
          Padding(
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
                    Text("45 Lectures", style: LMSStyles.tsWhiteNeutral300W300),
                    SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: LearningColors.neutral300,
                    ),
                    SizedBox(width: 4),
                    Text("160 Hours", style: LMSStyles.tsWhiteNeutral300W300),
                  ],
                ),
              ],
            ),
          ),

          // Fixed TabBar
          TabBar(
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

          // Scrollable Tab Content
          Expanded(
            // This makes only the tab content scrollable
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildInstituteTab(),
                _buildModulesTab(),
                _buildResourcesTab(),
                _buildFAQsTab(),
                _buildReviewsTab()
              ],
            ),
          ),
        ],
      ),
    );
  }*/
  Widget build(BuildContext context) {
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
                      onPressed: () => Navigator.pop(context),
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                      Text("45 Lectures", style: LMSStyles.tsWhiteNeutral300W300),
                      SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: LearningColors.neutral300,
                      ),
                      SizedBox(width: 4),
                      Text("160 Hours", style: LMSStyles.tsWhiteNeutral300W300),
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
                _buildInstituteTab(),
                _buildModulesTab(),
                _buildResourcesTab(),
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
  }

  Widget _buildAboutTab() {
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
  }

  /*Widget _buildInstituteTab() {
    final institutes = [
      {
        'logo': 'assets/images/aims.png',
        'name': 'AIMS Institute of Maritime Studies (Sucursal De Seafarers Training Center, Inc. - PANAMÁ)',
        'address': '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
        'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
        'email': 'training@aimsmaritime.com',
        'start_date': '12-06-2023',
        'duration': '6 Months',
      },
      {
        'logo': 'assets/images/maritime.png',
        'name': 'Centre for Maritime Education and Training (CMET)',
        'address': 'Bakshi, Ka Talab, Lucknow, India',
        'phone': '+915222735015',
        'email': 'cmetlucknow@gmail.com',
        'start_date': '01-08-2023',
        'duration': '3 Months',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: institutes.length,
      itemBuilder: (context, index) {
        final institute = institutes[index];
        return Card(
          color: LearningColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    institute['logo']!,
                    width: 50,
                    height: 50,
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
                        institute['name']!,
                        style: LMSStyles.tsblackTileBold2.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 8),

                      // Address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Colors.orange, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              institute['address']!,
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
                              institute['phone']!,
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
                              institute['email']!,
                              style: LMSStyles.tsWhiteNeutral300W500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Start Date & Duration
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.orange, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Start: ${institute['start_date']}',
                            style: LMSStyles.tsWhiteNeutral300W500.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.timer, color: Colors.orange, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            institute['duration']!,
                            style: LMSStyles.tsWhiteNeutral300W500.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/

  Widget _buildInstituteTab() {
    final List<Map<String, dynamic>> institutes = [
      {
        'logo': 'assets/images/aims.png',
        'name': 'AIMS Institute of Maritime Studies (Sucursal De Seafarers Training Center, Inc. - PANAMÁ)',
        'address': '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
        'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
        'email': 'training@aimsmaritime.com',
        'start_date': '12-06-2023',
        'end_date': '12-12-2023',
        'duration': '6 Months',
        'daily_timings': ['09:00 AM - 11:00 AM', '11:30 AM - 01:30 PM', '02:30 PM - 04:30 PM'],
      },
      {
        'logo': 'assets/images/maritime.png',
        'name': 'Centre for Maritime Education and Training (CMET)',
        'address': 'Bakshi, Ka Talab, Lucknow, India',
        'phone': '+915222735015',
        'email': 'cmetlucknow@gmail.com',
        'start_date': '01-08-2023',
        'end_date': '01-11-2023',
        'duration': '3 Months',
        'daily_timings': ['08:00 AM - 10:00 AM', '10:30 AM - 12:30 PM', '01:30 PM - 03:30 PM'],
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: _buildInstituteList(institutes),
    );
  }

  List<Widget> _buildInstituteList(List<Map<String, dynamic>> institutes) {
    return institutes.map((institute) {
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
                      institute['logo'] as String,
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
                          institute['name'] as String,
                          style: LMSStyles.tsblackTileBold2.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 8),

                        // Address
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                institute['address'] as String,
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
                                institute['phone'] as String,
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
                                institute['email'] as String,
                                style: LMSStyles.tsWhiteNeutral300W500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Start Date & Duration
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'Start: ${institute['start_date'] as String}',
                              style: LMSStyles.tsWhiteNeutral300W500.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.timer, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              institute['duration'] as String,
                              style: LMSStyles.tsWhiteNeutral300W500.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
                      children: (institute['daily_timings'] as List<String>).map((timing) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 65) / 2, // Calculate half width minus padding
                          child: Chip(
                            label: Text(timing,   style: LMSStyles.tsWhiteNeutral300W500.copyWith(fontSize: 13),),
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

  /*Widget _buildInstituteTab() {
    final institutes = [
      {
        'logo': 'assets/images/aims.png',
        'name': 'AIMS Institute of Maritime Studies',
        'subtitle': 'Sucursal De Seafarers Training Center, Inc. - PANAMÁ',
        'address': '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
        'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
        'email': 'training@aimsmaritime.com',
        'start_date': '12-06-2023',
        'duration': '6 Months',
        'status': 'Ongoing', // Added status
      },
      {
        'logo': 'assets/images/maritime.png',
        'name': 'Centre for Maritime Education and Training',
        'subtitle': '(CMET)',
        'address': 'Bakshi, Ka Talab, Lucknow, India',
        'phone': '+915222735015',
        'email': 'cmetlucknow@gmail.com',
        'start_date': '01-08-2023',
        'duration': '3 Months',
        'status': 'Upcoming', // Added status
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: institutes.length,
      itemBuilder: (context, index) {
        final institute = institutes[index];
        return Card(
          color: LearningColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with logo and name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        institute['logo']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Name and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            institute['name']!,
                            style: LMSStyles.tsblackTileBold2.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (institute['subtitle'] != null)
                            Text(
                              institute['subtitle']!,
                              style: LMSStyles.tsblackTileBold2.copyWith(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Status chip
                    Chip(
                      backgroundColor: institute['status'] == 'Ongoing'
                          ? Colors.green[100]
                          : Colors.blue[100],
                      label: Text(
                        institute['status']!,
                        style: TextStyle(
                          color: institute['status'] == 'Ongoing'
                              ? Colors.green[800]
                              : Colors.blue[800],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Course timeline
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            institute['start_date']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Duration',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            institute['duration']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Expected Completion',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            _calculateEndDate(
                                institute['start_date']!,
                                institute['duration']!
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Contact information
                _buildInfoRow(Icons.location_on, institute['address']!),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.phone, institute['phone']!),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.email, institute['email']!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: LMSStyles.tsWhiteNeutral300W500,
          ),
        ),
      ],
    );
  }*/

  String _calculateEndDate(String startDate, String duration) {
    // This is a simplified version - you should implement proper date calculation
    try {
      final parts = startDate.split('-');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final monthsToAdd = int.parse(duration.split(' ')[0]);

      final newMonth = month + monthsToAdd;
      final newYear = year + (newMonth ~/ 12);
      final finalMonth = newMonth % 12;

      return '$day-${finalMonth.toString().padLeft(2, '0')}-$newYear';
    } catch (e) {
      return 'N/A';
    }
  }

  /*Widget _buildInstituteTab() {
    final institutes = [
      {
        'logo': 'assets/images/aims.png',
        'name': 'AIMS Institute of Maritime Studies',
        'subtitle': 'Sucursal De Seafarers Training Center, Inc. - PANAMÁ',
        'address': '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
        'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
        'email': 'training@aimsmaritime.com',
        'start_date': '12-06-2023',
        'duration': '6 Months',
      },
      {
        'logo': 'assets/images/maritime.png',
        'name': 'Centre for Maritime Education and Training',
        'subtitle': 'CMET',
        'address': 'Bakshi, Ka Talab, Lucknow, India',
        'phone': '+915222735015',
        'email': 'cmetlucknow@gmail.com',
        'start_date': '01-08-2023',
        'duration': '3 Months',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: institutes.length,
      itemBuilder: (context, index) {
        final institute = institutes[index];
        return Card(
          color: LearningColors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with logo and name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo with container for better framing
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          institute['logo']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Name and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            institute['name']!,
                            style: LMSStyles.tsblackTileBold2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (institute['subtitle'] != null)
                            Text(
                              institute['subtitle']!,
                              style: LMSStyles.tsblackTileBold2.copyWith(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                const SizedBox(height: 16),

                // Info items in a compact grid
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    // Address
                    _buildInfoItem(
                      icon: Icons.location_on,
                      color: Colors.blue,
                      title: 'Address',
                      value: institute['address']!,
                    ),

                    // Phone
                    _buildInfoItem(
                      icon: Icons.phone,
                      color: Colors.green,
                      title: 'Phone',
                      value: institute['phone']!,
                    ),

                    // Email
                    _buildInfoItem(
                      icon: Icons.email,
                      color: Colors.orange,
                      title: 'Email',
                      value: institute['email']!,
                    ),

                    // Start Date
                    _buildInfoItem(
                      icon: Icons.calendar_today,
                      color: Colors.purple,
                      title: 'Start Date',
                      value: institute['start_date']!,
                    ),

                    // Duration
                    _buildInfoItem(
                      icon: Icons.timer,
                      color: Colors.red,
                      title: 'Duration',
                      value: institute['duration']!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return SizedBox(
      width: 160, // Fixed width for consistent grid
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  /*Widget _buildInstituteTab() {
    final institutes = [
      {
        'logo': 'assets/images/aims.png',
        'name':
            'AIMS Institute of Maritime Studies (Sucursal De Seafarers Training Center, Inc. - PANAMÁ)',
        'address':
            '216–B wing, Plot No–44, Sai Chambers, Sector 11, Opp Railway Station, C.B.D. Belapur (East), Navi Mumbai 400 614, India.',
        'phone': '+91-(0)22–41277001 / +91-(0)22–65263121',
        'email': 'training@aimsmaritime.com',
      },
      {
        'logo': 'assets/images/maritime.png',
        'name': 'Centre for Maritime Education and Training (CMET)',
        'address': 'Bakshi, Ka Talab, Lucknow, India',
        'phone': '+915222735015',
        'email': 'cmetlucknow@gmail.com',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: institutes.length,
      itemBuilder: (context, index) {
        final institute = institutes[index];
        return Card(
          color: LearningColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      institute['logo']!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        institute['name']!,
                        style: LMSStyles.tsblackTileBold2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        institute['address']!,
                        style: LMSStyles.tsWhiteNeutral300W500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        institute['phone']!,
                        style: LMSStyles.tsWhiteNeutral300W500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        institute['email']!,
                        style: LMSStyles.tsWhiteNeutral300W500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/

  Widget _buildModulesTab() {
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
                      leading: Icon(Icons.play_circle_fill, color: LearningColors.darkBlue),
                      title: Text(lecture, style: LMSStyles.tsWhiteNeutral300W500),
                      trailing: Text("4:24", style: LMSStyles.tsWhiteNeutral300W500),
                    );
                  },
                ),
              ),
            ),

          );
        }).toList(),
      ),
    );
  }

  Widget _buildResourcesTab() {
  final resources = [
    {
      'module': 'Module 01',
      'title': 'Chapter 03: Introduction to Basics',
      'description': 'Duration: 15 min. Learn the fundamentals.',
      'type': 'video',
      'action': 'Watch Video'
    },
    {
      'module': 'Module 03',
      'title': 'Chapter 04: Additional Reading',
      'description': 'External link for detailed study.',
      'type': 'link',
      'action': 'Open Link'
    },
    {
      'module': 'Module 05',
      'title': 'Chapter 06: Study Guide',
      'description': 'Comprehensive guide for beginners.',
      'type': 'pdf',
      'action': 'Download PDF'
    },
    {
      'module': 'Module 08',
      'title': 'Chapter 05: Feedback Survey Form',
      'description': 'Give us your valuable feedback for betterment.',
      'type': 'zip',
      'action': 'Download ZIP'
    },
  ];

  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(8,8,8,0),
    itemCount: resources.length,
    itemBuilder: (context, index) {
      final resource = resources[index];
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    resource['module']!,
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                Text(
                  resource['title']!,
                  style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                
                Text(
                  resource['description']!,
                  style: LMSStyles.tsWhiteNeutral300W500,
                ),
                const SizedBox(height: 16),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleResourceAction(resource['type']!, resource);
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
                          _getResourceIcon(resource['type']!),
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          resource['action']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
    },
  );
}

IconData _getResourceIcon(String type) {
  switch (type) {
    case 'video':
      return Icons.play_circle_outline;
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

void _handleResourceAction(String type, Map<String, String> resource) {
  switch (type) {
    case 'video':
      // Navigate to video screen
      print('Playing video: ${resource['title']}');
      break;
    case 'link':
      // Open external link
      print('Opening link: ${resource['title']}');
      break;
    case 'pdf':
      // Download PDF
      print('Downloading PDF: ${resource['title']}');
      break;
    case 'zip':
      // Download ZIP
      print('Downloading ZIP: ${resource['title']}');
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
                  title: Text('$index. ${item['question']!}', style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 15)),
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

  Widget _skillChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey.shade200,
    );
  }

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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
