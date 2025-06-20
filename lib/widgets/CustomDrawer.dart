import 'package:flutter/material.dart';

import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/screens/Ceritification.dart';
import 'package:learning_mgt/screens/CoursePage.dart';
import 'package:learning_mgt/screens/HomePage.dart';
import 'package:learning_mgt/screens/Recommendation.dart';
import 'package:learning_mgt/screens/ResultScreen.dart';
import 'package:learning_mgt/screens/SavedCoursesScreen.dart';
import 'package:learning_mgt/screens/SupportCenterScreen.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/faq_screen.dart';
import 'package:learning_mgt/screens/FeedbackScreen.dart';
import 'package:learning_mgt/screens/settingshome.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/GlobalLists.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔷 Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: LearningColors.darkBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      LMSImagePath.whiteCamera), // Replace with your asset
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome, Ruchita!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ruchita@gmail.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Menu Items
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.home,
                    label: 'Home',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        TabScreen.route,
                        arguments: {
                          'selectedPos': -1,
                          'isSignUp': false,
                        },
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.recommend,
                    label: 'Recommendation',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        Recommendation.route,
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.book,
                    label: 'Result',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        ResultScreen.route,
                      );
                    },
                  ),

                  // _buildDrawerItem(
                  //   context: context,
                  //   icon: Icons.person,
                  //   label: 'Certification',
                  //   onTap: () {
                  //     Navigator.of(
                  //       routeGlobalKey.currentContext!,
                  //     ).pushNamed(
                  //       Ceritification.route,
                  //     );
                  //   },
                  // ),

                  _buildDrawerItem(
                    context: context,
                    icon: Icons.bookmark,
                    label: 'Saved Courses',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        SavedCoursesScreen.route,
                      );
                    },
                  ),

                  _buildDrawerItem(
                    context: context,
                    icon: Icons.feedback,
                    label: 'FeedBack',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        FeedbackScreen.route,
                        arguments: {
                          'selectedPos': -1,
                          'isSignUp': false,
                        },
                      );
                    },
                  ),

                  _buildDrawerItem(
                    context: context,
                    icon: Icons.question_mark,
                    label: 'FAQ',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        FAQScreen.route,
                        arguments: {
                          'selectedPos': -1,
                          'isSignUp': false,
                        },
                      );
                    },
                  ),

                  _buildDrawerItem(
                    context: context,
                    icon: Icons.support_agent,
                    label: 'Support Center',
                    onTap: () {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        SupportCenterScreen.route,
                        arguments: {
                          'selectedPos': -1,
                          'isSignUp': false,
                        },
                      );
                    },
                  ),

                  _buildDrawerItem(
                    context: context,
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SettingsHome.route)
                          .then((value) {});
                      /*Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        SettingsHome.route,
                        arguments: {
                          'selectedPos': -1,
                          'isSignUp': false,
                        },
                      );*/
                    },
                  ),
                ],
              ),
            ),
          ),

          // const Spacer(),

          // Footer
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(
              children: [
                Divider(),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                Text(
                  'App version ${GlobalLists.versionNumber}',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: LearningColors.darkBlue),
      title: Text(label),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: LearningColors.darkBlue,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Confirm Logout',
                style: TextStyle(
                  color: LearningColors.darkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout from your account?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(routeGlobalKey.currentContext!)
                    .pushNamedAndRemoveUntil(
                  SignInScreen.route,
                  (route) => false,
                  arguments: {
                    'selectedPos': -1,
                    'isSignUp': false,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LearningColors.darkBlue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
