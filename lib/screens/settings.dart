import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart'; // For SizeConfig

class Settings extends StatefulWidget {
  static const String route = "/setting";
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
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
                      children: [
                        
                        simpleTransplantPlanWidget()],
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
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  textAlign: TextAlign.center,
                  "General",
                  style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 16),
                ),
              ),
 Center(
   child: Stack(
     children: [
       CircleAvatar(
         radius: 50,
         backgroundColor: Colors.grey.shade800,
         backgroundImage:
             // _profileImage != null ? FileImage(_profileImage!) :provider.profileImageUrl!=""?  NetworkImage(provider.profileImageUrl)
             AssetImage(LMSImagePath.whiteCamera),
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
 SizedBox(height: SizeConfig.blockSizeVertical*2,),
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
                          "Full name",
                          personalprovider.firstNameController,
                          "Enter First Name"),
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
                          TextFormField(
                            style: LMSStyles.tsWhiteNeutral300W50012,
                            obscureText: personalprovider.isPasswordObscured,
                            controller:
                                personalprovider.confirmpasswordController,
                            validator: personalprovider.validateConfirmPassword,
                            decoration: CommonInputDecoration(
                              hint: LMSStrings.strEnterChangeassword,
                              label: LMSStrings.strEnterChangeassword,
                              isObscured: personalprovider.isPasswordObscured,
                              toggle: personalprovider.togglePasswordVisibility,
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
                          title: LMSStrings.strDepartment,
                          hintText: LMSStrings.strSelectDepartment,
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
                          title: LMSStrings.strDepartment,
                          hintText: LMSStrings.strSelectDepartment,
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
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(SizeConfig.blockSizeHorizontal * 25,
                        SizeConfig.blockSizeVertical * 5),
                    backgroundColor: LearningColors.primaryBlue550,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
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
