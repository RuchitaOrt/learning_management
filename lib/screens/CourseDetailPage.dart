// // import 'package:flutter/material.dart';
// // import 'package:learning_mgt/Utils/lms_images.dart';

// // class CourseDetailPage extends StatefulWidget {
// //    static const String route = "/CourseDetailPage";
// //   const CourseDetailPage({super.key});

// //   @override
// //   State<CourseDetailPage> createState() => _CourseDetailPageState();
// // }

// // class _CourseDetailPageState extends State<CourseDetailPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           CustomScrollView(
// //             slivers: [
// //               SliverAppBar(
// //                 expandedHeight: 240,
// //                 pinned: true,
// //                 flexibleSpace: FlexibleSpaceBar(
// //                   background: Stack(
// //                     fit: StackFit.expand,
// //                     children: [
// //                       Image.asset(LMSImagePath.coverbg, fit: BoxFit.cover),
// //                       Container(
// //                         decoration: BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: [Colors.black87, Colors.transparent],
// //                             begin: Alignment.bottomCenter,
// //                             end: Alignment.topCenter,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               SliverToBoxAdapter(child: _buildCourseInfo()),
// //               SliverToBoxAdapter(child: _buildSections()),
// //             ],
// //           ),
// //           _buildBottomCTA(context),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCourseInfo() {
// //     return Padding(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text("Master Flutter in 30 Days", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// //           Text("By John Doe", style: TextStyle(color: Colors.grey)),
// //           SizedBox(height: 8),
// //           Row(
// //             children: [
// //               Icon(Icons.star, color: Colors.amber, size: 20),
// //               Text("4.8 (2k reviews)", style: TextStyle(fontWeight: FontWeight.w500)),
// //               SizedBox(width: 10),
// //               Text("25k+ enrolled"),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSections() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         children: [
// //           ExpansionTile(title: Text("What You'll Learn"), children: [
// //             ListTile(title: Text("Build real-world apps")),
// //             ListTile(title: Text("Master Flutter widgets")),
// //           ]),
// //           ExpansionTile(title: Text("Requirements"), children: [
// //             ListTile(title: Text("Basic programming knowledge")),
// //           ]),
// //           ExpansionTile(title: Text("Description"), children: [
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Text("This course is designed to teach you Flutter from scratch..."),
// //             )
// //           ]),
// //           ExpansionTile(title: Text("About Institute"), children: [
// //             ListTile(title: Text("Tech Institute - A reputed online academy")),
// //           ]),
// //           ExpansionTile(title: Text("FAQ"), children: [
// //             ListTile(title: Text("Can I access offline?")),
// //             ListTile(title: Text("Yes, download is available.")),
// //           ]),
// //           ExpansionTile(title: Text("Reviews"), children: [
// //             ListTile(title: Text("⭐️⭐️⭐️⭐️⭐️ John: Excellent content")),
// //           ]),
// //           SizedBox(height: 80),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildBottomCTA(BuildContext context) {
// //     return Positioned(
// //       bottom: 0,
// //       left: 0,
// //       right: 0,
// //       child: Container(
// //         color: Colors.white,
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //         child: ElevatedButton(
// //           onPressed: () {},
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: Colors.blueAccent,
// //             minimumSize: Size(double.infinity, 50),
// //           ),
// //           child: Text("Enroll Now"),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:learning_mgt/Utils/learning_colors.dart';
// import 'package:learning_mgt/Utils/lms_images.dart';
// import 'package:learning_mgt/Utils/sizeConfig.dart';

// class CourseDetailPage extends StatefulWidget {
//   static const String route = "/CourseDetailPage";
//   const CourseDetailPage({super.key});

//   @override
//   _CourseDetailPageState createState() => _CourseDetailPageState();
// }

// class _CourseDetailPageState extends State<CourseDetailPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 5,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//             SliverAppBar(
//               expandedHeight: 220,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.asset(
//                       LMSImagePath.coverbg,
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       bottom: 50,
//                       left: 16,
//                       right: 16,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(
//                                   SizeConfig.blockSizeHorizontal * 25,
//                                   SizeConfig.blockSizeVertical * 5),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: const Text('Watch Demo'),
//                           ),
//                           SizedBox(
//                             width: SizeConfig.blockSizeHorizontal * 5,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(
//                                   SizeConfig.blockSizeHorizontal * 25,
//                                   SizeConfig.blockSizeVertical * 5),
//                               backgroundColor: LearningColors.primaryBlue550,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: const Text(
//                               'Enroll Now',
//                               style:
//                                   TextStyle(color: LearningColors.neutral100),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               bottom: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 labelColor: LearningColors.white,
//                 unselectedLabelColor: Colors.white60,
//                 indicatorColor: LearningColors.primaryBlue550,
//                 tabs: const [
//                   Tab(text: 'Overview'),
//                   Tab(text: 'Institute'),
//                   Tab(text: 'Recommendation'),
//                   Tab(text: 'FAQ'),
//                   Tab(text: 'Review'),
//                 ],
//               ),
//             ),
//           ],
//           body: TabBarView(
//             controller: _tabController,
//             children: [
//               _buildOverviewTab(),
//               _buildInstituteTab(),
//               _buildRecommendationTab(),
//               _buildFAQTab(),
//               _buildReviewTab(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOverviewTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildCard("What you'll learn", "Course learning outcomes."),
//         _buildCard("Requirements", "What you need before starting."),
//         _buildCard("Description", "Detailed course description."),
//       ],
//     );
//   }

//   Widget _buildInstituteTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildCard("Institute Name", "Institute XYZ"),
//         _buildCard("About Institute", "Top-rated learning provider."),
//       ],
//     );
//   }

//   Widget _buildRecommendationTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: List.generate(
//         3,
//         (index) => _buildCard("Recommended Course ${index + 1}",
//             "Explore this course to improve your skills."),
//       ),
//     );
//   }

//   Widget _buildFAQTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildCard("Is this course beginner-friendly?",
//             "Yes, no prior experience required."),
//         _buildCard("Can I access it offline?", "Yes, download available."),
//       ],
//     );
//   }

//   Widget _buildReviewTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildCard("John Doe", "⭐️⭐️⭐️⭐️⭐️ - Very informative!"),
//         _buildCard("Jane Smith", "⭐️⭐️⭐️⭐️ - Good content and clear."),
//       ],
//     );
//   }

//   Widget _buildCard(String title, String subtitle) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 3,
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(subtitle),
//         leading: const Icon(Icons.school),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';

class CourseDetailPage extends StatefulWidget {
   static const String route = "/CourseDetailPage";
  @override
  _CollapsingAppBarDemoState createState() => _CollapsingAppBarDemoState();
}

class _CollapsingAppBarDemoState extends State<CourseDetailPage> {
  ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        // Change 150 based on your expandedHeight
        if (_scrollController.offset > 160 && !_isCollapsed) {
          setState(() => _isCollapsed = true);
        } else if (_scrollController.offset <= 160 && _isCollapsed) {
          setState(() => _isCollapsed = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: LearningColors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: _isCollapsed ? Text("Courses",style: TextStyle(color: LearningColors.black),) : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      LMSImagePath.coverbg, // Replace with your image
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 50,
                      left: 16,
                      right: 16,
                      child: Visibility(
                        visible: !_isCollapsed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Watch Demo'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                              ),
                              child: Text('Enroll Now'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: 20,
          itemBuilder: (_, index) => Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text('Content $index'),
              subtitle: Text('More details about content item $index'),
            ),
          ),
        ),
      ),
    );
  }
}
