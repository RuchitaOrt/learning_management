import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/StepProvider.dart';
import 'package:learning_mgt/provider/sign_up_provider.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

final BorderRadius borderRadius = const BorderRadius.all(
  Radius.circular(8),
);
final BorderSide focusedBorder = const BorderSide(
  width: 1.0,
);
final BorderSide enableBorder = BorderSide(
  color: LearningColors.neutral300,
  width: 1.0,
);

class VerificationScreen extends StatelessWidget {
  static const String route = "/verificationScreens";
  final List<String> steps = ['Basic', 'Detail', 'Upload'];

  final List<Widget> forms = [
    BasicFormWidget(),
    DetailFormWidget(),
    UploadFormWidget(),
  ];
  Widget stepIndicator(
      BuildContext context, int currentStep, bool isSubmitted) {
    final steps = ['Basic', 'Detail', 'Upload'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isEven) {
          final stepIndex = index ~/ 2;
          final bool isCompleted = stepIndex < currentStep ||
              (isSubmitted && stepIndex == currentStep);
          final bool isCurrent = stepIndex == currentStep && !isSubmitted;

          Color bgColor;
          Widget childContent;

          if (isCompleted) {
            bgColor = Colors.green;
            childContent = Icon(Icons.check, color: Colors.white, size: 20);
          } else {
            bgColor = Colors.grey.shade400;
            childContent =
                Text('${stepIndex + 1}', style: TextStyle(color: Colors.white));
          }

          return Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: bgColor,
                child: childContent,
              ),
              SizedBox(height: 6),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: 12,
                  color: isCurrent ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ],
          );
        } else {
          final lineIndex = (index - 1) ~/ 2;
          final bool isLineActive = lineIndex < currentStep ||
              (isSubmitted && lineIndex == currentStep - 1);
          return Expanded(
            child: Container(
              height: 2,
              color: isLineActive ? Colors.green : Colors.grey.shade300,
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stepProvider = Provider.of<StepProvider>(context);
    final current = stepProvider.currentStep;
    final isSubmitted = stepProvider.isSubmitted;

    return Scaffold(
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        decoration: AppDecorations.gradientBackground,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    LMSImagePath.splashLogo,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 20),
                child: Text(
                  LMSStrings.strCreateAnAccount,
                  style: LMSStyles.tsblackTileBold,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  LMSStrings.strSignUpDetail,
                  style: LMSStyles.tsWhiteNeutral300W500,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
              stepIndicator(context, current, isSubmitted),
              // SizedBox(height: 30),
              Expanded(
                child: current == -1
                    ? BasicFormWidget()
                    : (!isSubmitted
                        ? forms[current]
                        : Center(
                            child: Text(
                                'Your registration has been successfully submitted! '))),
              ),

              if (isSubmitted)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
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
                    label: Text(
                      'Go to Home',
                      style: TextStyle(color: LearningColors.neutral100),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.primaryBlue500),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: current > 0 ? stepProvider.previousStep : null,
                      child: Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final signUpProvider =
                            Provider.of<SignUpProvider>(context, listen: false);
                        // Validate current step form before moving forward
                        final formKey = current == 0
                            ? signUpProvider.formKeyBasic
                            : current == 1
                                ? signUpProvider.formKeyDetail
                                : signUpProvider.formKeyUpload;

                        if (formKey.currentState?.validate() ?? false) {
                          if (current == 2) {
                            stepProvider.submit();
                          } else {
                            stepProvider.nextStep();
                          }
                        } else {
                          // Optionally show error message or scroll to first error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Please fix errors before proceeding')));
                        }
                      },
                      child: Text(current == 2 ? 'Submit' : 'Next'),
                    ),
                  ],
                ),
//
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration CommonInputDecoration(
    {required String hint,
    required bool isObscured,
    required VoidCallback toggle}) {
  return InputDecoration(
    hintText: hint,
    errorStyle: LMSStyles.tsWhiteNeutral300W50012,
    border: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: enableBorder),
    focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: focusedBorder),
    enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: enableBorder),
    disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: enableBorder),
    errorBorder: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: enableBorder),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius, borderSide: focusedBorder),
    suffixIcon: IconButton(
      color: LearningColors.neutral300,
      onPressed: toggle,
      icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
    ),
    filled: true,
    fillColor: LearningColors.white,
    hintStyle: LMSStyles.tsHintstyle,
  );
}

// BasicFormWidget: Step 1
class BasicFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Form(
      key: signUpProvider.formKeyBasic,
      child: ListView(
        padding: EdgeInsets.zero, // removes default padding
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              Expanded(
                child: CustomTextFieldWidget(
                  title: LMSStrings.strFirstName,
                  hintText: LMSStrings.strEnterFirstName,
                  onChange: (val) {},
                  textEditingController: signUpProvider.firstNameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: signUpProvider.validateFirstName,
                ),
              ),
              SizedBox(width: 10), // Space between fields

              // Last Name
              Expanded(
                child: CustomTextFieldWidget(
                  title: LMSStrings.strLastName,
                  hintText: LMSStrings.strEnterLastName,
                  onChange: (val) {},
                  textEditingController: signUpProvider.lastNameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: signUpProvider.validateLastName,
                ),
              ),
            ],
          ),

          // Email
          CustomTextFieldWidget(
            title: LMSStrings.strEmail,
            hintText: LMSStrings.strEnterEmail,
            onChange: (val) {},
            textEditingController: signUpProvider.emailController,
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validateEmailField,
            suffixIcon: TextButton(
              onPressed: () {
                // Add logic to send OTP to email
                // signUpProvider.sendEmailOtp();
              },
              child: Text(
                "Send OTP",
                style: TextStyle(
                    color: LearningColors.primaryBlue500,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),

          // Phone Number
          CustomTextFieldWidget(
            title: LMSStrings.strPhoneNo,
            hintText: LMSStrings.strEnterPhoneNo,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.number,
            onChange: (val) {},
            textEditingController: signUpProvider.phoneNumberController,
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validatePhoneNumber,
            // suffixIcon: TextButton(
            //   onPressed: () {
            //     // Call your send OTP logic here
            //     // signUpProvider.sendOtp(); // Example method
            //   },
            //   child: Text(
            //     "Send OTP",
            //     style: TextStyle(
            //         color: LearningColors.primaryBlue500,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 12),
            //   ),
            // ),
          ),

          SizedBox(height: 12),
          Text(LMSStrings.strpassword,
              style: LMSStyles.tsWhiteNeutral100W50014),
          SizedBox(height: 8),
          TextFormField(
            style: LMSStyles.tsWhiteNeutral300W50012,
            obscureText: signUpProvider.isPasswordObscured,
            controller: signUpProvider.passwordController,
            validator: signUpProvider.validatePassword,
            decoration: CommonInputDecoration(
              hint: LMSStrings.strEnterpassword,
              isObscured: signUpProvider.isPasswordObscured,
              toggle: signUpProvider.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: 12),
          Text(LMSStrings.strConfirmpassword,
              style: LMSStyles.tsWhiteNeutral100W50014),
          SizedBox(height: 8),
          TextFormField(
            style: LMSStyles.tsWhiteNeutral300W50012,
            obscureText: signUpProvider.isconfirmPasswordObscured,
            controller: signUpProvider.confirmpasswordController,
            validator: signUpProvider.validateConfirmPassword,
            decoration: CommonInputDecoration(
              hint: LMSStrings.strEnterConfirmpassword,
              isObscured: signUpProvider.isconfirmPasswordObscured,
              toggle: signUpProvider.toggleConfirmPasswordVisibility,
            ),
          ),
        ],
      ),
    );
  }
}

// DetailFormWidget: Step 2
class DetailFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Form(
      key: signUpProvider.formKeyDetail,
      child: ListView(
        padding: EdgeInsets.zero, // removes default padding
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              Expanded(
                child: CustomTextFieldWidget(
                  title: LMSStrings.strSeafarerNo,
                  hintText: LMSStrings.strSeafarerNoHint,
                  onChange: (val) {},
                  textEditingController: signUpProvider.seafarerController,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: signUpProvider.validateSeafaer,
                ),
              ),
              SizedBox(width: 10), // Space between fields

              // Last Name
              Expanded(
                child: CustomTextFieldWidget(
                  title: LMSStrings.strPassportNo,
                  hintText: LMSStrings.strPassportNoHint,
                  onChange: (val) {},
                  textEditingController: signUpProvider.passportController,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: signUpProvider.validatePassport,
                ),
              ),
            ],
          ),
          CustomTextFieldWidget(
            textEditingController: signUpProvider.departmentController,
            title: LMSStrings.strDepartment,
            hintText: LMSStrings.strSelectDepartment,
            autovalidateMode: AutovalidateMode.disabled,
            isFieldReadOnly: true, // Make text field read-only
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) {
                  String? tempSelected =
                      signUpProvider.departmentController.text;
                  final departments = [
                    'HR',
                    'Finance',
                    'Engineering',
                    'Marketing'
                  ];

                  return AlertDialog(
                    title: Text('Select Department'),
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
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: Text('Select'),
                      ),
                    ],
                  );
                },
              );

              if (selected != null && selected.isNotEmpty) {
                signUpProvider.departmentController.text = selected;
                // If you want, also notify listeners if needed
              }
            },
            validator: signUpProvider.validateDepartment,
          ),
          CustomTextFieldWidget(
            textEditingController: signUpProvider.rankController,
            title: LMSStrings.strRank,
            hintText: LMSStrings.strRankHint,

            autovalidateMode: AutovalidateMode.disabled,
            isFieldReadOnly: true, // Make text field read-only
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) {
                  String? tempSelected = signUpProvider.rankController.text;
                  final departments = ['One', 'Two', 'Three'];

                  return AlertDialog(
                    title: Text('Select Rank'),
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
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: Text('Select'),
                      ),
                    ],
                  );
                },
              );

              if (selected != null && selected.isNotEmpty) {
                signUpProvider.rankController.text = selected;
                // If you want, also notify listeners if needed
              }
            },
            validator: signUpProvider.validateRank,
          ),
          CustomTextFieldWidget(
            textEditingController: signUpProvider.countryController,
            title: LMSStrings.strCountry,

            autovalidateMode: AutovalidateMode.disabled,
            hintText: LMSStrings.strCountryHint,
            isFieldReadOnly: true, // Make text field read-only
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) {
                  String? tempSelected = signUpProvider.countryController.text;
                  final departments = ['India', 'USA', 'England'];

                  return AlertDialog(
                    title: Text('Select Country'),
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
                        onPressed: () => Navigator.pop(context, tempSelected),
                        child: Text('Select'),
                      ),
                    ],
                  );
                },
              );

              if (selected != null && selected.isNotEmpty) {
                signUpProvider.countryController.text = selected;
                // If you want, also notify listeners if needed
              }
            },
            validator: signUpProvider.validateCountry,
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strDOB,
            hintText: LMSStrings.strDOBHint,
            textEditingController: signUpProvider.dobController,
            isFieldReadOnly: true, // Prevent keyboard from opening
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validateDOB,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2000, 1, 1), // default initial date
                firstDate: DateTime(1900), // earliest allowed date
                lastDate: DateTime.now(), // no future dates
              );

              if (pickedDate != null) {
                // Format the picked date as needed
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                signUpProvider.dobController.text = formattedDate;
              }
            },
            onChange: (val) {}, // Keep for consistency, though not used
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strPincode,
            hintText: LMSStrings.strPincodeHint,
            onChange: (val) {},
            textEditingController: signUpProvider.pincodeController,
            // autovalidateMode: AutovalidateMode.disabled,
            // validator: signUpProvider.validatePincodet,
          ),
        ],
      ),
    );
  }
}

// UploadFormWidget: Step 3 (dummy example)
class UploadFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Form(
      key: signUpProvider.formKeyUpload,
      child: ListView(
        padding: EdgeInsets.zero, // removes default padding
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          CustomTextFieldWidget(
            title: LMSStrings.strBithCertificate,
            hintText: LMSStrings.strBithCertificateHint,
            onChange: (val) async {},
            textEditingController: signUpProvider.birhtCertificateController,
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validateBirthCertificate,
            suffixIcon: GestureDetector(
                onTap: () {
                  //  signUpProvider.pickBirthCertificateFile();
                  if (signUpProvider.selectedBirthCertificateFilePath == null) {
                    signUpProvider.pickBirthCertificateFile("BirthCertificate");
                  } else {
                    showImageDialog(
                        signUpProvider.selectedBirthCertificateFilePath,
                        "BirthCertificate");
                  }
                },
                child: Icon(
                    signUpProvider.selectedBirthCertificateFilePath == null
                        ? Icons.upload
                        : Icons.remove_red_eye)),
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strPassportCertificate,
            hintText: LMSStrings.strPassportCertificateHint,
            onChange: (val) {},
            textEditingController: signUpProvider.passportCerticateController,
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validatePassportCertificate,
            suffixIcon: GestureDetector(
                onTap: () {
                  if (signUpProvider.selectedPassport == null) {
                    signUpProvider
                        .pickBirthCertificateFile("PassportCertificate");
                  } else {
                    showImageDialog(
                        signUpProvider.selectedPassport, "PassportCertificate");
                  }
                },
                child: Icon(signUpProvider.selectedPassport == null
                    ? Icons.upload
                    : Icons.remove_red_eye)),
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strCDC,
            hintText: LMSStrings.strCDCHint,
            onChange: (val) {},
            textEditingController: signUpProvider.CDCCertificateontroller,
             suffixIcon: GestureDetector(
                onTap: () {
                 
                  if (signUpProvider.selectedCDC == null) {
                    signUpProvider.pickBirthCertificateFile("CDCCertificate");
                  } else {
                    showImageDialog(
                        signUpProvider.selectedCDC,
                        "CDCCertificate");
                  }
                },
                child: Icon(
                    signUpProvider.selectedCDC == null
                        ? Icons.upload
                        : Icons.remove_red_eye)),
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strCourseCompletionCertificate,
            hintText: LMSStrings.strCourseCompletionCertificateHint,
            onChange: (val) {},
            textEditingController:
                signUpProvider.CourseCompletionCertController,
            suffixIcon: GestureDetector(
                onTap: () {
                 
                  if (signUpProvider.selectedCompletionCertificate == null) {
                    signUpProvider.pickBirthCertificateFile("CourseCompletionCertificate");
                  } else {
                    showImageDialog(
                        signUpProvider.selectedCompletionCertificate,
                        "CourseCompletionCertificate");
                  }
                },
                child: Icon(
                    signUpProvider.selectedCompletionCertificate == null
                        ? Icons.upload
                        : Icons.remove_red_eye)),
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strCOC,
            hintText: LMSStrings.strCOCHint,
            onChange: (val) {},
            textEditingController: signUpProvider.COCCertificateController,
             suffixIcon: GestureDetector(
                onTap: () {
                 
                  if (signUpProvider.selectedCOC == null) {
                    signUpProvider.pickBirthCertificateFile("COCCertificate");
                  } else {
                    showImageDialog(
                        signUpProvider.selectedCOC,
                        "COCCertificate");
                  }
                },
                child: Icon(
                    signUpProvider.selectedCOC == null
                        ? Icons.upload
                        : Icons.remove_red_eye)),
          ),
        ],
      ),
    );
  }

  void showImageDialog(String? selectedPath, String pickedValue) {
    if (selectedPath == null) return;

    showDialog(
      context: routeGlobalKey.currentContext!,
      builder: (_) => AlertDialog(
        title: Text("Selected Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(selectedPath)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final signUpProvider = Provider.of<SignUpProvider>(
                    routeGlobalKey.currentContext!,
                    listen: false);
                Navigator.of(routeGlobalKey.currentContext!)
                    .pop(); // close dialog
                signUpProvider
                    .pickBirthCertificateFile(pickedValue); // re-trigger picker
              },
              child: const Text("Change Image"),
            )
          ],
        ),
      ),
    );
  }
}
