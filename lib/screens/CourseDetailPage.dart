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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Header Section
                Container(
                  height: 250,
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

                // Course Info Section
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

                // TabBar
                Container(
                  color: Colors.white,
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
                      Tab(text: "FAQs"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                ),
              ],
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
                _buildFAQsTab(),
                _buildReviewsTab()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    String aboutText =
        "Foundations of User Experience (UX) Design is the first of a series of seven courses that will equip you with the skills needed to apply to entry-level jobs in user experience design. Through a mix of videos, readings, and hands-on activities, you'll learn how to describe common job responsibilities of entry-level UX designers and explore job opportunities in the field of UX design...";

    bool isExpanded = false;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About this Course", style: LMSStyles.tsSubHeadingBold),
          SizedBox(height: 8),
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isExpanded || aboutText.length <= 100
                        ? aboutText
                        : aboutText.substring(0, 100) + "...",
                    style: LMSStyles.tsWhiteNeutral300W500,
                  ),
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
                ],
              );
            },
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
  }

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

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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

                // Timings Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo for timings
                    /*ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        institute['logo'] as String,
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),*/

                    // Timings chips (2 per row)
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (institute['daily_timings'] as List<String>).map((timing) {
                          return SizedBox(
                            width: (MediaQuery.of(context).size.width - 120) / 2,
                            child: Chip(
                              label: Text(timing),
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
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
        children: modules.asMap().entries.map<ExpansionPanelRadio>((entry) {
          final index = entry.key + 1;
          final module = entry.value;

          return ExpansionPanelRadio(
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

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final item = faqs[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text('${index + 1}. ${item['question']!}',
                style: LMSStyles.tsSubHeadingBold.copyWith(fontSize: 15)),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  item['answer']!,
                  style: LMSStyles.tsWhiteNeutral300W500,
                ),
              ),
            ],
          ),
        );
      },
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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final item = reviews[index];
        return Card(
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
}