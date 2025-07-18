import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/provider/sign_up_provider.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart'; // For SizeConfig

class Settings extends StatefulWidget {
  static const String route = "/setting";
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
    return Consumer<PersonalAccountProvider>(builder: (context, provider, _) {
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
            child: Stack(
              children: [
                // Container(child: Text("data"),),
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
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

Widget _buildProfileImage() {
  
 return Consumer<PersonalAccountProvider>(
    builder: (context, provider, _) {
      print("profileImageUrl");
      print(provider.generalList.profilePic);
       ImageProvider? imageProvider;

      if (_profileImage != null) {
         print("profileImageUrl1");
        imageProvider = FileImage(_profileImage!);
      } else if (provider.generalList.profilePic!=null) {
         print("profileImageUrl2");
        imageProvider = NetworkImage(provider.generalList.profilePic!);
      }
  return  GestureDetector(
    onTap: _pickProfileImage,
    child: Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade800,
            backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) :provider.generalList.profilePic!=null?  NetworkImage(provider.generalList.profilePic!)
                :AssetImage(LMSImagePath.whiteCamera),
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
  Widget simpleTransplantPlanWidget() {
    return Consumer<PersonalAccountProvider>(
        builder: (context, personalprovider, child) {
      if (personalprovider.isGeneralLoading) {
        return Center(
            child: CircularProgressIndicator(
          color: LearningColors.darkBlue,
        ));
      }
      personalprovider.firstNameController.text =
          personalprovider.generalList.firstName!;
      personalprovider.middleNameController.text =
          personalprovider.generalList.middleName!;
      personalprovider.lastNameController.text =
          personalprovider.generalList.lastName!;

      personalprovider.dobController.text = personalprovider.generalList.dob!;
      personalprovider.phoneNumberController.text =
          personalprovider.generalList.mobilenumber.toString();
      personalprovider.emailController.text =
          personalprovider.generalList.email!;
      personalprovider.confirmpasswordController.text =
          personalprovider.generalList.password!;

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
                      "General",
                      style:
                          LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              _buildProfileImage(),
              // Center(
              //   child: Stack(
              //     children: [
              //       CircleAvatar(
              //         radius: 50,
              //         backgroundColor: Colors.grey.shade800,
              //         backgroundImage:
              //              (personalprovider.generalList.profilePic != null ||personalprovider.generalList.profilePic != "") ?
              //              NetworkImage(personalprovider.generalList.profilePic! ):
              //              AssetImage(LMSImagePath.whiteCamera),
              //               // FileImage(_profileImage!) :provider.profileImageUrl!=""?  
                            
              //             // AssetImage(LMSImagePath.whiteCamera),
              //         // child: imageProvider == null
              //         //     ? Icon(
              //         //         Icons.person,
              //         //         size: 50,
              //         //         color: Colors.white70,
              //         //       )
              //         //     : Image.network(provider.profileImageUrl),
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         right: 0,
              //         child: Container(
              //           padding: EdgeInsets.all(4),
              //           decoration: BoxDecoration(
              //             color: Colors.blue,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.edit,
              //             size: 18,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Personal",
                              style: LMSStyles.tsblackTileBold
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      informationPlan(
                          "First Name",
                          personalprovider.firstNameController,
                          "Enter First Name"),
                      informationPlan(
                          "Middle Name",
                          personalprovider.middleNameController,
                          "Enter Middle Name"),
                      informationPlan(
                          "Last Name",
                          personalprovider.lastNameController,
                          "Enter Last Name"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFieldWidget(
                            title: LMSStrings.strDOB,
                            hintText: LMSStrings.strDOBHint,
                            textEditingController:
                                personalprovider.dobController,
                            isFieldReadOnly:
                                true, // Prevent keyboard from opening
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: personalprovider.validateDOB,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(
                                    2000, 1, 1), // default initial date
                                firstDate:
                                    DateTime(1900), // earliest allowed date
                                lastDate: DateTime.now(), // no future dates
                              );

                              if (pickedDate != null) {
                                // Format the picked date as needed
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                personalprovider.dobController.text =
                                    formattedDate;
                              }
                            },
                            onChange:
                                (val) {}, // Keep for consistency, though not used
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Account",
                              style: LMSStyles.tsblackNeutralbold
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      informationPlan(
                          "Phone number",
                          personalprovider.phoneNumberController,
                          "Enter Phone Number"),
                      informationPlan("Email", personalprovider.emailController,
                          "Enter First Name"),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            LMSStrings.strEnterChangeassword,
                            style: LMSStyles.tsHeading,
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor:
                                    LearningColors.darkBlue, // blinking cursor
                                selectionColor: Colors.blue
                                    .withOpacity(0.3), // text highlight
                                selectionHandleColor: LearningColors
                                    .darkBlue, // balloon/handle color
                              ),
                            ),
                            child: TextFormField(
                              cursorColor: LearningColors.darkBlue,
                              style: LMSStyles.tsWhiteNeutral300W50012,
                              obscureText: personalprovider.isPasswordObscured,
                              controller:
                                  personalprovider.confirmpasswordController,
                              validator:
                                  personalprovider.validateConfirmPassword,
                              decoration: InputDecoration(
                                hintText: LMSStrings.strEnterChangeassword,
                                labelText: LMSStrings.strEnterChangeassword,
                                hintStyle: LMSStyles.tsHintstyle.copyWith(
                                  fontSize: LMSStyles.tsHintstyle.fontSize! + 4,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: LearningColors.neutral300,
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: LearningColors.neutral300,
                                      width: 1.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16.0,
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    Navigator.of(routeGlobalKey.currentContext!)
                                        .pushNamed(ChangePasswordScreen.route,
                                            arguments: {
                                          'email': personalprovider
                                              .emailController.text,
                                          'comingFrom': "2"
                                        });
                                    //
                                    // Add logic to send OTP to email
                                    //                      final signUpProvider =
                                    // Provider.of<SignUpProvider>(context, listen: false);
                                    // personalprovider.chnagePasswordAPI(personalprovider.emailController.text);
                                    //  signUpProvider.forgetPasswordOTPVerification(personalprovider.emailController.text);
                                  },
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                        color: LearningColors.darkBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              // decoration: CommonInputDecoration(
                              //   hint: LMSStrings.strEnterChangeassword,
                              //   label: LMSStrings.strEnterChangeassword,
                              //   isObscured: personalprovider.isPasswordObscured,
                              //   toggle:
                              //       personalprovider.togglePasswordVisibility,
                              // ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Card(
                elevation: 1.0,
                color: LearningColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Language & Region",
                            style: LMSStyles.tsblackNeutralbold
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        CustomTextFieldWidget(
                          textEditingController:
                              personalprovider.languageController,
                          title: LMSStrings.strLanguage,
                          hintText: LMSStrings.strSelectLanguage,
                          autovalidateMode: AutovalidateMode.disabled,
                          isFieldReadOnly: true, // Make text field read-only
                          onTap: () async {
                            final selected = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                String? tempSelected =
                                    personalprovider.languageController.text;
                                final departments = [
                                  'English',
                                  'French',
                                  'Spanish',
                                ];

                                return AlertDialog(
                                  title: Text('Select Language'),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: departments.map((dept) {
                                          return RadioListTile<String>(
                                            title: Text(dept),
                                            value: dept,
                                            groupValue: tempSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                tempSelected = value;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, tempSelected),
                                      child: Text('Select'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (selected != null && selected.isNotEmpty) {
                              personalprovider.languageController.text =
                                  selected;
                              // If you want, also notify listeners if needed
                            }
                          },
                          validator: personalprovider.validateLanguage,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        CustomTextFieldWidget(
                          textEditingController:
                              personalprovider.timeZoneController,
                          title: LMSStrings.strTimeZone,
                          hintText: LMSStrings.strSelectTimezone,
                          autovalidateMode: AutovalidateMode.disabled,
                          isFieldReadOnly: true, // Make text field read-only
                          onTap: () async {
                            final selected = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                String? tempSelected =
                                    personalprovider.timeZoneController.text;
                                final departments = [
                                  'UTC+05:30',
                                  'UTC+06:30',
                                  'UTC+07:30',
                                ];

                                return AlertDialog(
                                  title: Text('Select Time Zone'),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: departments.map((dept) {
                                          return RadioListTile<String>(
                                            title: Text(dept),
                                            value: dept,
                                            groupValue: tempSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                tempSelected = value;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, tempSelected),
                                      child: Text('Select'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (selected != null && selected.isNotEmpty) {
                              personalprovider.timeZoneController.text =
                                  selected;
                              // If you want, also notify listeners if needed
                            }
                          },
                          validator: personalprovider.validateTimeZone,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0), // optional horizontal padding
                child: ElevatedButton(
                  onPressed: () {
                    String path=_profileImage!=null?_profileImage!.path:"";
                    personalprovider.uploadDocuments(routeGlobalKey.currentContext!,path);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // full width button
                    backgroundColor: LearningColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child:personalprovider.isSavingDetails?CircularProgressIndicator(color: LearningColors.neutral100,): Text(
                    LMSStrings.strSaveChanges,
                    style: LMSStyles.tsWhiteNeutral50W60016,
                  ),
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

  Widget informationPlan(
      String title, TextEditingController controller, String suTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   textAlign: TextAlign.center,
        //   title,
        //   style: LMSStyles.tsHeading,
        // ),
        // SizedBox(
        //   height: SizeConfig.blockSizeVertical * 0.5,
        // ),
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
