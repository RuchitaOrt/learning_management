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
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/faq_screen.dart';
import 'package:learning_mgt/screens/FeedbackScreen.dart';
import 'package:learning_mgt/screens/settingshome.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/GlobalLists.dart';
import 'package:provider/provider.dart';

import '../provider/LandingScreenProvider.dart';

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
          _buildDrawerItem(
            context: context,
            icon: Icons.person,
            label: 'Certification',
            onTap: () {
              Navigator.of(
                routeGlobalKey.currentContext!,
              ).pushNamed(
                Ceritification.route,
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
          Divider(),
          _buildDrawerItem(
            context: context,
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              _showLogoutDialog(context);
            },
          ),

          const Spacer(),

          // Footer
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'App version ${GlobalLists.versionNumber}',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
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
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: LearningColors.darkBlue, size: 24),
              SizedBox(width: 8),
              Text('Confirm Logout'),
            ],
          ),
          content: Text('Are you sure you want to logout from your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext); // Close dialog
                final provider = Provider.of<LandingScreenProvider>(
                    context, // Use original context here
                    listen: false
                );
                await provider.logout(context);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
