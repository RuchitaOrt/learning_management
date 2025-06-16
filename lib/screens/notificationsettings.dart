import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class NotificationSettings extends StatefulWidget {
  static const String route = "/notificationSettings";
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  // Email notification switches
  bool accountActivityNotifications = true;
  bool courseUpdatesAndRecommendations = true;
  bool courseUpdates = true;

  // SMS notification switches
  bool paymentReminders = true;
  bool accountRecoveryAlerts = true;
  bool communityUpdates = true;

  // Push notification switches
  bool courseReminders = true;
  bool instructorMessages = true;
  bool rewardsAndAchievements = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            decoration: AppDecorations.gradientBackground,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: 0.0, maxHeight: double.infinity),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [simpleTransplantPlanWidget()],
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

  Widget simpleTransplantPlanWidget() {
    return Consumer<PersonalAccountProvider>(
        builder: (context, personalprovider, child) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.only(left: 4, top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 0),
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
                      "Notifications",
                      style:
                          LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Email Notifications Card
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        "Email Notifications",
                        style: LMSStyles.tsblackTileBold.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Choose which updates you want to receive via email.",
                        style: LMSStyles.tsblackNeutralbold.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Account activity notifications switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Account activity notifications",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: accountActivityNotifications,
                                onChanged: (value) {
                                  setState(() {
                                    accountActivityNotifications = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Course updates and recommendations switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Course updates and recommendations",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: courseUpdatesAndRecommendations,
                                onChanged: (value) {
                                  setState(() {
                                    courseUpdatesAndRecommendations = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Course updates switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Course updates",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: courseUpdates,
                                onChanged: (value) {
                                  setState(() {
                                    courseUpdates = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.blockSizeVertical * 2),

              // SMS Notifications Card
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        "SMS Notifications",
                        style: LMSStyles.tsblackTileBold.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Manage alerts sent to your phone via SMS.",
                        style: LMSStyles.tsblackNeutralbold.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Payment reminders switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Payment reminders",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: paymentReminders,
                                onChanged: (value) {
                                  setState(() {
                                    paymentReminders = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Account recovery alerts switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Account recovery alerts",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: accountRecoveryAlerts,
                                onChanged: (value) {
                                  setState(() {
                                    accountRecoveryAlerts = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Community updates switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Community updates",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: communityUpdates,
                                onChanged: (value) {
                                  setState(() {
                                    communityUpdates = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.blockSizeVertical * 2),

              // Push Notifications Card
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        "Push Notifications",
                        style: LMSStyles.tsblackTileBold.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Controls which notifications you receive on your mobile app.",
                        style: LMSStyles.tsblackNeutralbold.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Course reminders switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Course reminders",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: courseReminders,
                                onChanged: (value) {
                                  setState(() {
                                    courseReminders = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Instructor messages switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Instructor messages",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: instructorMessages,
                                onChanged: (value) {
                                  setState(() {
                                    instructorMessages = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey.shade200),
                      // Rewards and achievements switch
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Rewards and achievements",
                                style: LMSStyles.tsblackNeutralbold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: rewardsAndAchievements,
                                onChanged: (value) {
                                  setState(() {
                                    rewardsAndAchievements = value;
                                  });
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.orange,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.blockSizeVertical * 3),
            ],
          ),
        ),
      );
    });
  }

  Widget informationPlan(
      String title, TextEditingController controller, String suTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWidget(
          title: title,
          hintText: suTitle,
          onChange: (val) {},
          textEditingController: controller,
          autovalidateMode: AutovalidateMode.disabled,
        ),
      ],
    );
  }
}
