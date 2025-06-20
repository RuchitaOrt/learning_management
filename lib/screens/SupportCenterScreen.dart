import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/SupportCenterProvider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class SupportCenterScreen extends StatefulWidget {
  static const String route = "/SupportCenterScreen";
  const SupportCenterScreen({Key? key}) : super(key: key);

  @override
  _SupportCenterScreenState createState() => _SupportCenterScreenState();
}

class _SupportCenterScreenState extends State<SupportCenterScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SupportCenterProvider()),
        ChangeNotifierProvider(create: (_) => LandingScreenProvider()),
      ],
      child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
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
                onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
            endDrawer: CustomDrawer(),
            body: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 100,
              decoration: AppDecorations.gradientBackground,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Support Center",
                            style:
                                LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                          ),
                          // Text(
                          //   "View Ticket History",
                          //   style:
                          //       LMSStyles.tsHeadingbold.copyWith(fontSize: 12),
                          // ),
                          GestureDetector(
                            onTap: () => _showHistoryBottomSheet(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                "Ticket History",
                                style: LMSStyles.tsblackNeutralbold
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Raise Ticket",
                            style:
                                LMSStyles.tsHeadingbold.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      Expanded(
                        child: _buildForm(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Consumer<SupportCenterProvider>(
      builder: (context, supportProvider, child) {
        return Form(
          key: supportProvider.formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    CustomTextFieldWidget(
                      title: LMSStrings.strTicketSubject,
                      hintText: LMSStrings.strTicketSubjectHint,
                      onChange: (val) {},
                      textEditingController:
                          supportProvider.ticketSubjectController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: supportProvider.validateTicketSubject,
                    ),
                    CustomTextFieldWidget(
                      textEditingController: supportProvider.priorityController,
                      title: LMSStrings.strTicketPriority,
                      hintText: LMSStrings.strTicketPriorityHint,
                      autovalidateMode: AutovalidateMode.disabled,
                      isFieldReadOnly: true,
                      onTap: () =>
                          _showPriorityDialog(context, supportProvider),
                      validator: supportProvider.validatePriority,
                    ),
                    CustomTextFieldWidget(
                      textEditingController: supportProvider.categoryController,
                      title: LMSStrings.strTicketCategory,
                      hintText: LMSStrings.strTicketCategoryHint,
                      autovalidateMode: AutovalidateMode.disabled,
                      isFieldReadOnly: true,
                      onTap: () =>
                          _showCategoryDialog(context, supportProvider),
                      validator: supportProvider.validateCategory,
                    ),
                    CustomTextFieldWidget(
                      title: "Choose File",
                      isFieldReadOnly: true,
                      hintText: "Choose Upload File",
                      textEditingController:
                          supportProvider.attachmentController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => supportProvider
                          .validateFile(supportProvider.selectedFilePath),
                      onChange: (val) {},
                      suffixIcon: GestureDetector(
                        onTap: () => _pickFile(supportProvider),
                        child: Icon(
                          supportProvider.selectedFilePath == null
                              ? Icons.upload
                              : Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    CustomTextFieldWidget(
                      title: LMSStrings.strTicketDescription,
                      hintText: LMSStrings.strTicketDescriptionHint,
                      onChange: (val) {},
                      textEditingController:
                          supportProvider.descriptionController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: supportProvider.validateDescription,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: LearningColors.darkBlue,
                            width: 0.5,
                          ),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: LMSStyles.tsblackNeutralbold.copyWith(
                            color: LearningColors.darkBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            supportProvider.isSubmitting ? null : () => {},
                        // : () => _submitForm(context, supportProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.darkBlue,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: supportProvider.isSubmitting
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Submit",
                                style: LMSStyles.tsWhiteNeutral50W60016,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPriorityDialog(
      BuildContext context, SupportCenterProvider provider) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Priority'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: provider.priorities.map((priority) {
              return RadioListTile<String>(
                title: Text(priority),
                value: priority,
                groupValue: provider.selectedPriority,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selected != null) {
      provider.setSelectedPriority(selected);
    }
  }

  Future<void> _showCategoryDialog(
      BuildContext context, SupportCenterProvider provider) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: provider.categories.map((category) {
              return RadioListTile<String>(
                title: Text(category),
                value: category,
                groupValue: provider.selectedCategory,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selected != null) {
      provider.setSelectedCategory(selected);
    }
  }

  Future<void> _pickFile(SupportCenterProvider provider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      provider.setSelectedFile(
          result.files.single.path, result.files.single.name);
    }
  }

void _showHistoryBottomSheet(BuildContext context) {
  final List<Map<String, dynamic>> ticketHistory = [
    {
      'subject': 'Login Issue',
      'priority': 'High',
      'category': 'Technical',
      'description': 'User unable to login due to password reset failure.',
      'date': '26 Jan, 2023 • 3:30 pm',
    },
    {
      'subject': 'Payment Problem',
      'priority': 'Medium',
      'category': 'Billing',
      'description': 'Payment gateway timeout during transaction.',
      'date': '25 Jan, 2023 • 1:15 pm',
    },
    {
      'subject': 'Course Access',
      'priority': 'Low',
      'category': 'General',
      'description': 'Unable to access purchased course content.',
      'date': '24 Jan, 2023 • 11:00 am',
    },
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    builder: (context) => TapRegion(
      onTapOutside: (_) => Navigator.of(context).pop(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7, // Fixed height
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
                    "Ticket History",
                    style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: ticketHistory.length,
                itemBuilder: (context, index) {
                  final item = ticketHistory[index];
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
                          item['subject'],
                          style: LMSStyles.tsSubHeading.copyWith(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Priority: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              item['priority'],
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Category: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              item['category'],
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          item['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 3,
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
      ),
    ),
  );
}



  // Future<void> _submitForm(BuildContext context, SupportCenterProvider provider) async {
  //   final success = await provider.submitTicket();

  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Ticket submitted successfully!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     Navigator.pop(context);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to submit ticket. Please try again.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }
}
