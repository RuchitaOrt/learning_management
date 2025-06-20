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
  Radius.circular(12),
);
final BorderSide focusedBorder = const BorderSide(
  width: 1.0,
);
final BorderSide enableBorder = BorderSide(
  color: LearningColors.neutral300,
  width: 1.0,
);

class VerificationScreen extends StatefulWidget {
  static const String route = "/verificationScreens";

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SignUpProvider>(context, listen: false)
        .loadDocumentsFromAPI());
  }

  final List<String> steps = ['Basic', 'Detail', 'Upload'];

  final List<Widget> forms = [
    BasicFormWidget(),
    DetailFormWidget(),
    UploadFormWidget(),
  ];

/*  Widget stepIndicator(
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
  }*/

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
            bgColor = Colors.green; // Keep completed steps green
            childContent = Icon(Icons.check, color: Colors.white, size: 20);
          } else if (isCurrent) {
            bgColor = LearningColors.darkBlue; // Current step uses darkBlue
            childContent =
                Text('${stepIndex + 1}', style: TextStyle(color: Colors.white));
          } else {
            bgColor = Colors.grey.shade400; // Inactive steps remain grey
            childContent =
                Text('${stepIndex + 1}', style: TextStyle(color: Colors.white));
          }

          return Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: bgColor,
                child: childContent,
              ),
              SizedBox(height: 6),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: 12,
                  color: isCurrent
                      ? LearningColors.darkBlue
                      : Colors.grey.shade600,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
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
              SizedBox(height: 10),
              Expanded(
                  child: current == -1
                      ? BasicFormWidget()
                      : (!isSubmitted
                          ? forms[current]
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // GIF animation
                                Container(
                                  height: 120,
                                  width: 120,
                                  child: Image.asset(
                                    'assets/images/successful.gif', // Add your GIF path here
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 24),

                                Text(
                                  'Application no: #268-136-734',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // Registration success message
                                Text(
                                  'Your registration has been successfully submitted!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Kindly visit the training center with a printed copy of your documents for validation.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                // SizedBox(height: 32),
                              ],
                            ))),
              if (isSubmitted)
                Center(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
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
                      SizedBox(height: 8),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                              TabScreen.route,
                              arguments: {
                                'selectedPos': 0,
                                'isSignUp': false,
                              },
                            );
                          },
                          child: Text(
                            'Browse Courses',
                            style: TextStyle(
                              fontSize: 16,
                              color: LearningColors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: LearningColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  children: [
                    // Back Button (50% width)
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          /*backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(color: LearningColors.neutral300),
                          padding: EdgeInsets.symmetric(vertical: 16),*/
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              vertical: 16), // internal padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed:
                            current > 0 ? stepProvider.previousStep : null,
                        child: Text('Back'),
                      ),
                    ),
                    SizedBox(width: 8), // Add some spacing between buttons

                    // Next/Submit Button (50% width)
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          /*backgroundColor: LearningColors.darkBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),*/
                          backgroundColor: LearningColors.darkBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16), // internal padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          final signUpProvider = Provider.of<SignUpProvider>(
                              context,
                              listen: false);
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Please fix errors before proceeding')));
                          }
                        },
                        child: Text(current == 2 ? 'Submit' : 'Next'),
                      ),
                    ),
                  ],
                ),
              /*Row(
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
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}

/*InputDecoration CommonInputDecoration(
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
}*/

InputDecoration CommonInputDecoration({
  required String hint,
  required String label,
  required bool isObscured,
  required VoidCallback toggle,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: LearningColors.darkBlue, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: LearningColors.neutral300, width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red.shade400, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red.shade400, width: 1.0),
    ),
    filled: true,
    fillColor: LearningColors.transparent,
    errorStyle: LMSStyles.tsWhiteNeutral300W50012.copyWith(
      fontSize: LMSStyles.tsWhiteNeutral300W50012.fontSize! + 2,
    ),
    suffixIcon: IconButton(
      color: isObscured
          ? LearningColors.neutral300
          : const Color.fromARGB(169, 3, 89, 159),
      onPressed: toggle,
      icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
    ),
    // suffixIcon: IconButton(
    //   color: isObscured ? LearningColors.neutral300 : LearningColors.darkBlue,
    //   onPressed: toggle,
    //   icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
    // ),
    hintStyle: LMSStyles.tsHintstyle.copyWith(
      fontSize: LMSStyles.tsHintstyle.fontSize! + 4,
    ),
    labelStyle: LMSStyles.tsHintstyle.copyWith(
      fontSize: LMSStyles.tsHintstyle.fontSize! + 5,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 16.0,
    ),
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
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 8),
          // First Name and Last Name in a Row
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  title: LMSStrings.strFirstName,
                  hintText: LMSStrings.strEnterFirstName,
                  onChange: (val) {},
                  textEditingController: signUpProvider.firstNameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: signUpProvider.validateFirstName,
                ),
              ), // Space between fields
            ],
          ),

          SizedBox(height: 0), // Add vertical spacing
          Row(
            children: [
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
          SizedBox(height: 0), // Add vertical spacing

          // Email (full width)
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
              },
              child: Text(
                "Send OTP",
                style: TextStyle(
                    color: LearningColors.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 0),

          // Phone Number (full width)
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
          ),
          SizedBox(height: 8),

          // Password field
          TextFormField(
            style: LMSStyles.tsWhiteNeutral300W50012,
            obscureText: signUpProvider.isPasswordObscured,
            controller: signUpProvider.passwordController,
            validator: signUpProvider.validatePassword,
            decoration: CommonInputDecoration(
              hint: LMSStrings.strEnterpassword,
              label: LMSStrings.strpassword,
              isObscured: signUpProvider.isPasswordObscured,
              toggle: signUpProvider.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: 16),

          // Confirm Password field
          TextFormField(
            style: LMSStyles.tsWhiteNeutral300W50012,
            obscureText: signUpProvider.isconfirmPasswordObscured,
            controller: signUpProvider.confirmpasswordController,
            validator: signUpProvider.validateConfirmPassword,
            decoration: CommonInputDecoration(
              hint: LMSStrings.strEnterConfirmpassword,
              label: LMSStrings.strConfirmpassword,
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
          SizedBox(height: 8),
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
                                Navigator.pop(context, value);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                    // Remove the actions section entirely since we don't need the Select button
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
                                Navigator.pop(context, value);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
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
                                Navigator.pop(context, value);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
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
            isFieldReadOnly: true,
            autovalidateMode: AutovalidateMode.disabled,
            validator: signUpProvider.validateDOB,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light(
                        primary: LearningColors
                            .darkBlue, // Header background and selected date circle
                        onPrimary:
                            Colors.white, // Text color on primary (header text)
                        onSurface: Colors.black, // Default text color for dates
                        surface: Colors.white, // Background color of the picker
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: LearningColors
                              .darkBlue, // OK/Cancel button text color
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      dialogBackgroundColor: Colors.white, // Overall background
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                signUpProvider.dobController.text = formattedDate;
              }
            },
            onChange: (val) {},
          ),
          CustomTextFieldWidget(
            title: LMSStrings.strPincode,
            hintText: LMSStrings.strPincodeHint,
            onChange: (val) {},
            textEditingController: signUpProvider.pincodeController,
            suffixIcon: TextButton(
              onPressed: () {
                // Add logic to send OTP to email
              },
              child: Text(
                "Locate Me",
                style: TextStyle(
                    color: LearningColors.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            // autovalidateMode: AutovalidateMode.disabled,
            // validator: signUpProvider.validatePincodet,
          ),
        ],
      ),
    );
  }
}

class UploadFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Form(
      key: provider.formKeyUpload,
      child: provider.documentFields.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: provider.documentFields.length,
                    itemBuilder: (context, index) {
                      final doc = provider.documentFields[index];
                      return CustomTextFieldWidget(
                        title: doc.name,
                        isFieldReadOnly: true,
                        hintText: doc.hint,
                        textEditingController: provider.controllers[doc.name]!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (_) => provider
                            .validateFile(provider.selectedFilePaths[doc.name]),
                        onChange: (val) {}, // optional
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (provider.selectedFilePaths[doc.name] == null) {
                              provider.pickFile(doc.name);
                            } else {
                              showImageDialog(
                                provider.selectedFilePaths[doc.name],
                                doc.name,
                              );
                            }
                          },
                          child: Icon(
                            provider.selectedFilePaths[doc.name] == null
                                ? Icons.upload
                                : Icons.remove_red_eye,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Note text after all fields
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 8, bottom: 16),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                      children: [
                        TextSpan(
                          text: 'Note',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: ': Allowed file types: ',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: 'PDF',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: 'JPG',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: ', ',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: 'PNG',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: '. Maximum file size: ',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: '2 MB',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: ' per file.',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
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
