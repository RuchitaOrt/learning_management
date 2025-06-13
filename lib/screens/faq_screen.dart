import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/faqprovider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  static const String route = "/faqScreen";
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCategory = "My Account";
  String searchQuery = "";

  final List<String> categories = [
    "My Account",
    "Trading",
    "Charges / Plans",
    "Training",
    "Payments",
    "Privacy & Security",
    "Courses"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isSearchClickVisible: () {},
              isSearchValueVisible: false,
              onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          drawer: CustomDrawer(),
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "FAQ",
                        style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1565C0),
                            Color(0xFF0D47A1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main Heading
                            Text(
                              "Hey, how can we help you?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Category Chips
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: categories.map((category) {
                                  bool isSelected =
                                      selectedCategory == category;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategory = category;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Color(0xFF1565C0)
                                                : Colors.white,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: AppDecorations.gradientBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<FAQProvider>(
                        builder: (context, faqProvider, child) {
                          final filteredFAQs = faqProvider.faqData
                              .where((faq) => faq['title'] == selectedCategory)
                              .toList();

                          if (filteredFAQs.isEmpty) {
                            return Center(
                              child: Text(
                                "No FAQs found for this category",
                                style: LMSStyles.tsblackNeutralbold
                                    .copyWith(fontSize: 16),
                              ),
                            );
                          }

                          final questions = filteredFAQs[0]['questions']
                              as List<Map<String, dynamic>>;
                          final filteredQuestions = questions.where((question) {
                            if (searchQuery.isEmpty) return true;
                            return question['question']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                question['answer']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchQuery);
                          }).toList();

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: filteredQuestions.length,
                            itemBuilder: (context, index) {
                              final question = filteredQuestions[index];

                              return _buildFAQCard(
                                title: selectedCategory,
                                question: question,
                                onTap: () {
                                  _showFAQDetails(context, {
                                    'title': selectedCategory,
                                    'icon': Icons.help_outline,
                                    'questions': [question]
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFAQCard({
    required String title,
    required Map<String, dynamic> question,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: LearningColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: LMSStyles.tsblackTileBold.copyWith(fontSize: 18),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['question'],
                      style: LMSStyles.tsblackNeutralbold.copyWith(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "View more",
                    style: LMSStyles.tsblackNeutralbold.copyWith(
                      fontSize: 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.orange,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFAQDetails(BuildContext context, Map<String, dynamic> faqCategory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FAQDetailScreen(
          selectedCategory: faqCategory,
          allCategories:
              Provider.of<FAQProvider>(context, listen: false).faqData,
        ),
      ),
    );
  }
}

class FAQDetailScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCategory;
  final List<Map<String, dynamic>> allCategories;

  const FAQDetailScreen({
    Key? key,
    required this.selectedCategory,
    required this.allCategories,
  }) : super(key: key);

  @override
  _FAQDetailScreenState createState() => _FAQDetailScreenState();
}

class _FAQDetailScreenState extends State<FAQDetailScreen> {
  Map<String, dynamic>? currentCategory;
  int? expandedQuestionIndex;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.allCategories.firstWhere(
      (category) => category['title'] == widget.selectedCategory['title'],
      orElse: () => widget.selectedCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(kToolbarHeight),
        //   child: CustomAppBar(
        //     isSearchClickVisible: () {
        //       // provider.toggleSearchIconCategory();
        //     },
        //     isSearchValueVisible: provider.isSearchIconVisible,
        //   ),
        // ),
        body: Container(
          decoration: AppDecorations.gradientBackground,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
            // EdgeInsetsGeometry.fromLTRB(0.0, 32.0, 0.0, 0.0),
            child: Column(
              children: [
                // Custom Header
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 0, top: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text(
                        "FAQs",
                        style:
                            LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),

                // SizedBox(height: 16),

                // Tab-style Category Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        children: widget.allCategories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // spacing between chips
                            child: ChoiceChip(
                              label: Text(category['title']),
                              selected: currentCategory!['title'] ==
                                  category['title'],
                              showCheckmark: false,
                              onSelected: (selected) {
                                setState(() {
                                  currentCategory =
                                      selected ? category : currentCategory;
                                  expandedQuestionIndex =
                                      null; // Reset expanded question
                                });
                              },
                              selectedColor: LearningColors.primaryBlue550,
                              backgroundColor: Colors.white60,
                              labelStyle: TextStyle(
                                color: currentCategory!['title'] ==
                                        category['title']
                                    ? LearningColors.neutral100
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Questions List
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: LearningColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: currentCategory!['questions'].length,
                        itemBuilder: (context, index) {
                          final question = currentCategory!['questions'][index];
                          bool isExpanded = expandedQuestionIndex == index;

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      expandedQuestionIndex =
                                          isExpanded ? null : index;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            question['question'],
                                            style: LMSStyles.tsblackTileBold
                                                .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: Colors.grey[600],
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isExpanded)
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                    child: Text(
                                      question['answer'],
                                      style:
                                          LMSStyles.tsblackNeutralbold.copyWith(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
