import 'package:flutter/material.dart';

import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/screens/Ceritification.dart';
import 'package:learning_mgt/screens/Recommendation.dart';
import 'package:learning_mgt/screens/ResultScreen.dart';

import 'package:learning_mgt/screens/settings.dart';
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
                      'assets/images/user_profile.png'), // Replace with your asset
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome, User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
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
            icon: Icons.home,
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
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.question_mark,
            label: 'FAQ',
            onTap: () {
            }
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              Navigator.of(
                routeGlobalKey.currentContext!,
              ).pushNamed(
                Settings.route,
                arguments: {
                  'selectedPos': -1,
                  'isSignUp': false,
                },
              );
            },
          ),
          Divider(),
          _buildDrawerItem(
            context: context,
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              Navigator.pop(context);
              // Handle logout
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
}
