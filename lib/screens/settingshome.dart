import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/screens/documentsettings.dart';
import 'package:learning_mgt/screens/institutesettings.dart';
import 'package:learning_mgt/screens/notificationsettings.dart';
import 'package:learning_mgt/screens/seafarerssettings.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/screens/settings.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart'; // For SizeConfig


class SettingsHome extends StatefulWidget {
  static const String route = "/settinghome";
  const SettingsHome({Key? key}) : super(key: key);

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<PersonalAccountProvider>(context, listen: false);

      if (!provider.isGeneralLoading) {
        provider.getGeneralList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          key: scaffoldKey,
          endDrawer: CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isSearchClickVisible: () {
                // provider.toggleSearchIconCategory();
                
              },
               onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(), 
              isSearchValueVisible: provider.isSearchIconVisible,
            ),
          ),
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

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: Colors.grey.shade700),
                SizedBox(width: 16),
                Text(
                  title,
                  style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    // IconButton(
                    //   icon: Icon(Icons.arrow_back_ios), 
                    //   onPressed: () {
                    //     Navigator.pop(context); 
                    //   },
                    //   padding: EdgeInsets.zero, 
                    //   constraints: BoxConstraints(),
                    // ),
                    Text(
                      "Settings",
                      style:
                          LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              buildprofile(personalprovider)
,
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),

              // Consolidated settings section
              Container(
                decoration: BoxDecoration(
                  color: LearningColors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingsOption(
                      icon: Icons.settings,
                      title: "General",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                      },
                    ),
                    Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Colors.grey.shade200), // Divider for separation
                    _buildSettingsOption(
                      icon: Icons.person,
                      title: "Seafarers",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeafarerSettings(),
                          ),
                        );
                      },
                    ),
                    Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Colors.grey.shade200),
                    _buildSettingsOption(
                      icon: Icons.document_scanner,
                      title: "Documents",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DocumentSetting(),
                          ),
                        );
                      },
                    ),
                    Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Colors.grey.shade200),
                    _buildSettingsOption(
                      icon: Icons.school,
                      title: "Institute",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstituteScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Colors.grey.shade200),
                    _buildSettingsOption(
                      icon: Icons.notifications,
                      title: "Notifications",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationSettings(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      );
    });
  }

   File? _profileImage;
    Future<void> _pickProfileImage() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null && result.files.isNotEmpty) {
    setState(() {
       final provider =
          Provider.of<PersonalAccountProvider>(context, listen: false);
      _profileImage = File(result.files.first.path!);
      provider.uploadProfileDocuments(routeGlobalKey.currentContext!,_profileImage!.path);
    });
  }
}
Widget buildprofile(PersonalAccountProvider personalprovider)
{
   if (personalprovider.isGeneralLoading) {
        return Center(
            child: CircularProgressIndicator(
          color: LearningColors.darkBlue,
        ));
      }
  return Center(
                child: Card(
                  elevation: 1.0,
                  color: LearningColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
                        _buildProfileImage(),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal*48,
                              child: Text(
                                                         "${personalprovider.generalList.firstName!} ${personalprovider.generalList.middleName} ${personalprovider.generalList.lastName}",
                                                         maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                                style: LMSStyles.tsblackTileBold
                                    .copyWith(fontSize: 18),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal*48,
                              
                              child: Text("${personalprovider.generalList.email}"
                              ,maxLines: 2,
                              overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
}
Widget _buildProfileImage() {
  
 return Consumer<PersonalAccountProvider>(
    builder: (context, provider, _) {
      print("profileImageUrl");
      print(provider.generalList.profilePic);
      //  ImageProvider? imageProvider;

      // if (_profileImage != null) {
      //    print("profileImageUrl1");
      //   imageProvider = FileImage(_profileImage!);
      // } else if (provider.generalList.profilePic!=null ) {
      //    print("profileImageUrl2");
      //   imageProvider = NetworkImage(provider.generalList.profilePic!);
      // }
      ImageProvider<Object> imageProvider = 
  _profileImage != null
    ? FileImage(_profileImage!)
    : (provider.generalList.profilePic != null
        ? NetworkImage(provider.generalList.profilePic!)
        : AssetImage(LMSImagePath.whiteCamera) as ImageProvider<Object>);

  return  GestureDetector(
    onTap: _pickProfileImage,
    child: Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade800,
            backgroundImage:
               imageProvider,
            // child: imageProvider == null
            //     ? Icon(
            //         Icons.person,
            //         size: 50,
            //         color: Colors.white70,
            //       )
            //     : Image.network(provider.profileImageUrl),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
    });
}
}
