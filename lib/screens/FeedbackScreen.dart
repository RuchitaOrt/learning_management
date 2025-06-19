import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';


class FeedbackScreen extends StatefulWidget {
  static const String route = "/feedbackScreen";
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCategory;
  int currentCategoryIndex = 0;
  int currentPage = 0;
  int selectedRating = 0;
  TextEditingController feedbackController = TextEditingController();

  final List<Map<String, dynamic>> feedbackCategories = [
    {
      'title': 'Category 01',
      'questions': [
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
      ],
      'type': 'star',
    },
    {
      'title': 'Category 02',
      'questions': [
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
      ],
      'type': 'number',
    },
    {
      'title': 'Category 03',
      'questions': [
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
        'Est facilis natus perferendis cumque magnam nisi quia consequatur?',
      ],
      'type': 'emoji',
    },
  ];

  Map<String, Map<int, int>> starRatings = {};
  Map<String, Map<int, int>> numberRatings = {};
  Map<String, Map<int, int>> emojiRatings = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          isSearchClickVisible: () {},
          isSearchValueVisible: false,
          onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
        ),
      ),
      body: Container(
        decoration: AppDecorations.gradientBackground,
        child: _buildCurrentPage(),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (currentPage) {
      case 0:
        return _buildRatingCategoriesPage();
      case 1:
        return _buildTextInputPage();
      case 2:
        return _buildThankYouPage();
      default:
        return _buildRatingCategoriesPage();
    }
  }

  Widget _buildNavigationButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blue : Colors.white,
        side: isPrimary ? null : BorderSide(color: Colors.grey.shade300),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPrimary ? Colors.white : Colors.grey[600],
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRatingCategoriesPage() {
    return Column(
      children: [
        // Header Section
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Feedback",
                    style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => _showHistoryBottomSheet(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        "History",
                        style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Please give us your feedback",
                style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 8),
              Text(
                "We value your insights! Your feedback helps us enhance your learning experience and improve our services. You can submit feedback as many times as you like—there are no limits!",
                style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        
        // Feedback Content
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedbackCategories[currentCategoryIndex]['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 20),

                Expanded(
                  child: _buildFeedbackContent(),
                ),

                // Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentCategoryIndex > 0)
                      _buildNavigationButton(
                        text: "Previous",
                        onPressed: () {
                          setState(() {
                            currentCategoryIndex--;
                          });
                        },
                      )
                    else
                      SizedBox(),
                    
                    _buildNavigationButton(
                      text: currentCategoryIndex < feedbackCategories.length - 1 ? "Next" : "Next",
                      isPrimary: true,
                      onPressed: () {
                        if (currentCategoryIndex < feedbackCategories.length - 1) {
                          setState(() {
                            currentCategoryIndex++;
                          });
                        } else {
                          // Move to text input page after completing all categories
                          setState(() {
                            currentPage = 1;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextInputPage() {
    return Column(
      children: [
        // Header Section
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Feedback",
                style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Please give us your feedback",
                style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 8),
              Text(
                "We value your insights! Your feedback helps us enhance your learning experience and improve our services. You can submit feedback as many times as you like—there are no limits!",
                style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Text Input Content
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display selected rating with stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 30,
                      color: index < 4 ? Colors.orange : Colors.grey[300], // Show 4 stars as example
                    );
                  }),
                ),
                
                SizedBox(height: 16),
                
                Text(
                  "Kindly take a moment tell us what do you think",
                  style: LMSStyles.tsblackTileBold.copyWith(fontSize: 18),
                ),
                
                SizedBox(height: 16),
                
                // Fixed Text Input Field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 200, // Minimum height to prevent shrinking
                          ),
                          child: TextField(
                            controller: feedbackController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              hintText: "Add your feedback...",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              alignLabelWithHint: true,
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavigationButton(
                      text: "Previous",
                      onPressed: () {
                        setState(() {
                          currentPage = 0;
                          currentCategoryIndex = feedbackCategories.length - 1; 
                        });
                      },
                    ),
                    _buildNavigationButton(
                      text: "Submit",
                      isPrimary: true,
                      onPressed: () {
                        setState(() {
                          currentPage = 2;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildThankYouPage() {
    return Column(
      children: [
        // Header Section
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Feedback",
                style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),

        // Thank You Content
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Thank You for Your Feedback!",
                  style: LMSStyles.tsblackTileBold.copyWith(
                    fontSize: 24,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 20),
                
                Text(
                  "We appreciate your time and effort in sharing your thoughts. Your feedback helps us improve and enhance your learning experience. Feel free to submit feedback anytime—there are no limits! 😊",
                  style: LMSStyles.tsblackNeutralbold.copyWith(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 32),
                _buildNavigationButton(
                  text: "Home",
                  isPrimary: true,
                  onPressed: () {
                    setState(() {
                      currentPage = 0;
                      currentCategoryIndex = 0;
                      selectedRating = 0;
                      feedbackController.clear();
                      starRatings.clear();
                      numberRatings.clear();
                      emojiRatings.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFeedbackContent() {
    final category = feedbackCategories[currentCategoryIndex];
    final questions = category['questions'] as List<String>;
    final type = category['type'] as String;

    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Q.${index + 1} ${questions[index]}",
                style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
              ),
              SizedBox(height: 16),
              _buildRatingWidget(type, category['title'], index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingWidget(String type, String categoryTitle, int questionIndex) {
    switch (type) {
      case 'star':
        return _buildStarRating(categoryTitle, questionIndex);
      case 'number':
        return _buildNumberRating(categoryTitle, questionIndex);
      case 'emoji':
        return _buildEmojiRating(categoryTitle, questionIndex);
      default:
        return Container();
    }
  }

  Widget _buildStarRating(String category, int questionIndex) {
    int currentRating = starRatings[category]?[questionIndex] ?? 0;
    
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (starRatings[category] == null) {
                starRatings[category] = {};
              }
              starRatings[category]![questionIndex] = index + 1;
            });
          },
          child: Icon(
            Icons.star,
            size: 40,
            color: index < currentRating ? Colors.orange : Colors.grey[300],
          ),
        );
      }),
    );
  }

  Widget _buildNumberRating(String category, int questionIndex) {
    int currentRating = numberRatings[category]?[questionIndex] ?? 0;
    
    return Row(
      children: List.generate(5, (index) {
        bool isSelected = currentRating == index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (numberRatings[category] == null) {
                numberRatings[category] = {};
              }
              numberRatings[category]![questionIndex] = index + 1;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 16),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEmojiRating(String category, int questionIndex) {
    int currentRating = emojiRatings[category]?[questionIndex] ?? 0;
    List<String> emojis = ['😢', '😕', '😐', '😊', '😍'];
    
    return Row(
      children: List.generate(5, (index) {
        bool isSelected = currentRating == index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (emojiRatings[category] == null) {
                emojiRatings[category] = {};
              }
              emojiRatings[category]![questionIndex] = index + 1;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 16),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.withOpacity(0.2) : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: Colors.orange, width: 2) : null,
            ),
            child: Center(
              child: Text(
                emojis[index],
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showHistoryBottomSheet(BuildContext context) {
    final List<Map<String, dynamic>> feedbackHistory = [
      {
        'title': 'Sint culpa provident accusantium quaerat et. Quae et et aut in...',
        'date': '26 Jan, 2023 • 3:30 pm',
      },
      {
        'title': 'Sint culpa provident accusantium quaerat et. Quae et et aut in...',
        'date': '26 Jan, 2023 • 3:30 pm',
      },
      {
        'title': 'Sint culpa provident accusantium quaerat et. Quae et et aut in...',
        'date': '26 Jan, 2023 • 3:30 pm',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (context) => TapRegion(
        onTapOutside: (_) => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF8F9FA),
                    Color(0xFFE9ECEF),
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          "History",
                          style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: feedbackHistory.length,
                      itemBuilder: (context, index) {
                        final item = feedbackHistory[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: LMSStyles.tsSubHeading.copyWith(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                item['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
