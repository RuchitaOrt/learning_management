import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/screens/Videoscreen.dart';

import '../Utils/lms_styles.dart';

class CourseDetailPage extends StatefulWidget {
  static const String route = "/CourseDetailPage";

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSelected = false;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {},
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
      body: DefaultTabController(
        length: 5,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      LMSImagePath.coverbg,
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withOpacity(0.4)),
                    GestureDetector(
                      onTap: ()
                      {
                        // _navigateToVideoScreen("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4","","","",false,"","");
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
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                borderRadius: BorderRadius.circular(8),  // rounded square
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
                            Icon(Icons.play_circle_outline, size: 16, color: LearningColors.neutral300,),
                            SizedBox(width: 4),
                            Text("45 Lectures", style: LMSStyles.tsWhiteNeutral300W300),
                            SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16, color: LearningColors.neutral300,),
                            SizedBox(width: 4),
                            Text("160 Hours", style: LMSStyles.tsWhiteNeutral300W300),
                          ],
                        ),
                        //SizedBox(height: 16),
                      ],
                    ),
                  ),
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
                      Tab(text: "FAQs"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutTab(),
                  _buildInstituteTab(),
                  _buildModulesTab(),
                  _buildFAQsTab(),
                  _buildReviewsTab()
                ],
              ),
            ),
          ],
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
              Text("160 Hours of Lectures", style: LMSStyles.tsWhiteNeutral300W300),
              Text("1 Month at 5 hours a week", style: LMSStyles.tsblackTileBold),
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

  Widget _buildInstituteTab() {
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
  }

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
        children: modules.map<ExpansionPanelRadio>((module) {
          final index = modules.indexOf(module);
          return ExpansionPanelRadio(
            value: index,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(module['title'].toString(), style: LMSStyles.tsSubHeadingBold),
                subtitle: Text("4 lectures  |  4 min",
                    style: LMSStyles.tsWhiteNeutral300W500),
              );
            },
            body: Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: (module['lectures'] as List<String>).map((lecture) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.play_circle_fill, color: LearningColors.darkBlue),
                    title: Text(lecture, style: LMSStyles.tsWhiteNeutral300W500),
                    trailing: Text("4:24", style: LMSStyles.tsWhiteNeutral300W500),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
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
            final index = entry.key;
            final item = entry.value;

            return ExpansionPanelRadio(
              value: index,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(item['question']!, style: LMSStyles.tsSubHeadingBold),
                );
              },
              body: Container(
                color: Colors.blue.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: List.generate(4, (i) => Icon(Icons.star, color: Colors.amber, size: 16))),
                SizedBox(height: 8),
                Text(item['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item['date']!, style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 8),
                Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
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
