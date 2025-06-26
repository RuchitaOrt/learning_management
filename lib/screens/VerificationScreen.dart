import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
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

import '../Utils/APIManager.dart';
import '../model/LoginResponse.dart';
import '../model/RegistrationResponse.dart';
import '../widgets/ShowDialog.dart';

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
                      child: Consumer<SignUpProvider>(
                        builder: (context, signUpProvider, _) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: signUpProvider.isEmailVerified &&
                                  !signUpProvider.isRegistering &&
                                  !signUpProvider.isSavingDetails
                                  ? LearningColors.darkBlue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              if (!signUpProvider.isEmailVerified) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please verify your email first')));
                                return;
                              }

                              final formKey = current == 0
                                  ? signUpProvider.formKeyBasic
                                  : current == 1
                                  ? signUpProvider.formKeyDetail
                                  : signUpProvider.formKeyUpload;

                              if (formKey.currentState?.validate() ?? false) {
                                try {
                                  if (current == 0) {
                                    await signUpProvider.registerCandidate(context);
                                  } else if (current == 1) {
                                    await signUpProvider.saveCandidateDetails(context);
                                    await signUpProvider.fetchDocuments();
                                  } else if (current == 2) {
                                    // This is the submit button for the upload step
                                    await signUpProvider.uploadDocuments(context);
                                  }

                                  // Only proceed if API call succeeds
                                  Provider.of<StepProvider>(context, listen: false).nextStep();
                                } catch (e) {
                                  // Error is already shown by the provider methods
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please fix errors before proceeding')));
                              }
                            },
                            child: signUpProvider.isRegistering || signUpProvider.isSavingDetails
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(current == 2 ? 'Submit' : 'Next'),
                          );
                        },
                      ),
                    ),
                    /*Expanded(
                      flex: 1,
                      child: Consumer<SignUpProvider>(
                        builder: (context, signUpProvider, _) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: signUpProvider.isEmailVerified &&
                                  !signUpProvider.isRegistering &&
                                  !signUpProvider.isSavingDetails
                                  ? LearningColors.darkBlue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              if (!signUpProvider.isEmailVerified) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please verify your email first')));
                                return;
                              }

                              final formKey = current == 0
                                  ? signUpProvider.formKeyBasic
                                  : signUpProvider.formKeyDetail;

                              if (formKey.currentState?.validate() ?? false) {
                                try {
                                  if (current == 0) {
                                    await signUpProvider.registerCandidate(context);
                                  } else if (current == 1) {
                                    await signUpProvider.saveCandidateDetails(context);
                                    await signUpProvider.fetchDocuments();
                                  }

                                  // Only proceed if API call succeeds
                                  Provider.of<StepProvider>(context, listen: false).nextStep();
                                } catch (e) {
                                  // Error is already shown by the provider methods
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please fix errors before proceeding')));
                              }
                            },
                            child: signUpProvider.isRegistering || signUpProvider.isSavingDetails
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(current == 2 ? 'Submit' : 'Next'),
                          );
                        },
                      ),
                    ),*/
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            suffixIcon: Consumer<SignUpProvider>(
              builder: (context, provider, _) {
                if (provider.isSendingOtp) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 80, // Give enough space for the loader
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(LearningColors.darkBlue),
                        ),
                      ),
                    ),
                  );
                }

                return TextButton(
                  onPressed: provider.isOtpCooldownActive
                      ? null
                      : () {
                    final email = provider.emailController.text.trim();
                    if (email.isNotEmpty) {
                      provider.sendEmailOtp(context, email);
                    }
                  },
                  child: Text(
                    provider.isOtpCooldownActive
                        ? 'Resend OTP (${provider.otpCountdown})'
                        : 'Send OTP',
                    style: TextStyle(
                      color: provider.isOtpCooldownActive
                          ? Colors.grey
                          : LearningColors.darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
            /*suffixIcon: Consumer<SignUpProvider>(
              builder: (context, provider, _) {
                return TextButton(
                  onPressed: provider.isOtpCooldownActive
                      ? null
                      : () {
                    final email = provider.emailController.text.trim();
                    if (email.isNotEmpty) {
                      provider.sendEmailOtp(context, email);
                    }
                  },
                  child: Text(
                    provider.isOtpCooldownActive
                        ? 'Resend OTP (${provider.otpCountdown})'
                        : 'Send OTP',
                    style: TextStyle(
                      color: provider.isOtpCooldownActive
                          ? Colors.grey
                          : LearningColors.darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),*/
          ),

          SizedBox(height: 0),
          // otp verification field
          if (signUpProvider.isOtpSent) ...[
            /*CustomTextFieldWidget(
              title: 'OTP',
              hintText: 'Enter 4-digit OTP',
              textEditingController: signUpProvider.otpController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: (value) {
                if (!signUpProvider.isEmailVerified) {
                  return 'Please verify your email';
                }
                return signUpProvider.validateOtp(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputType: TextInputType.number,
              suffixIcon: signUpProvider.isEmailVerified
                  ? Icon(Icons.verified, color: Colors.green)
                  : TextButton(
                onPressed: () {
                  final email = signUpProvider.emailController.text.trim();
                  if (email.isNotEmpty &&
                      signUpProvider.validateEmailField(email) == null &&
                      signUpProvider.otpController.text.isNotEmpty) {
                    signUpProvider.verifyEmailOtp(context, email);
                  }
                },
                child: Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: LearningColors.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),*/
            CustomTextFieldWidget(
              title: 'OTP',
              hintText: 'Enter 4-digit OTP',
              textEditingController: signUpProvider.otpController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: (value) {
                if (!signUpProvider.isEmailVerified) {
                  return 'Please verify your email';
                }
                return signUpProvider.validateOtp(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputType: TextInputType.number,
              suffixIcon: signUpProvider.isEmailVerified
                  ? Icon(Icons.verified, color: Colors.green)
                  : Consumer<SignUpProvider>(
                builder: (context, provider, _) {
                  if (provider.isVerifyingOtp) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 80,
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(LearningColors.darkBlue),
                          ),
                        ),
                      ),
                    );
                  }

                  return TextButton(
                    onPressed: () {
                      final email = provider.emailController.text.trim();
                      if (email.isNotEmpty &&
                          provider.validateEmailField(email) == null &&
                          provider.otpController.text.isNotEmpty) {
                        provider.verifyEmailOtp(context, email);
                      }
                    },
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: LearningColors.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 0),
          ],

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
class DetailFormWidget extends StatefulWidget {
  @override
  _DetailFormWidgetState createState() => _DetailFormWidgetState();
}

class _DetailFormWidgetState extends State<DetailFormWidget> {
  List<Department> departments = [];
  bool isLoading = false;
  String? errorMessage;
  List<Country> countries = [];
  bool isLoadingDepartments = false;
  bool isLoadingCountries = false;
  String? departmentErrorMessage;
  String? countryErrorMessage;
  List<Rank> ranks = [];
  bool isLoadingRanks = false;
  String? rankErrorMessage;
  int? selectedDepartmentId;

  @override
  void initState() {
    super.initState();
    /*fetchDepartments();
    fetchCountries();*/
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    signUpProvider.fetchDepartments();
    signUpProvider.fetchCountries();
    signUpProvider.fetchQualifications();
  }

  /*Future<void> fetchDepartments() async {
    if (mounted) setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await APIManager().apiRequest(
        context,
        API.departmentlist,
            (response) {
          print('Department list response: $response');

          if (response is DepartmentListResponse) {
            if (mounted) setState(() {
              departments = response.data;
              print('Loaded ${departments.length} departments: ${departments.map((d) => d.departmentName).toList()}');
            });
          } else {
            print('Unexpected response type: ${response.runtimeType}');
            if (mounted) setState(() {
              errorMessage = 'Unexpected response format';
            });
          }
        },
            (error) {
          print('Department list error: $error');
          if (mounted) setState(() {
            errorMessage = 'Failed to load departments: ${error.toString()}';
          });
        },
      );
    } catch (e) {
      print('Exception in fetchDepartments: $e');
      if (mounted) setState(() {
        errorMessage = 'Failed to load departments';
      });
    } finally {
      if (mounted) setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchCountries() async {
    if (mounted) setState(() {
      isLoadingCountries = true;
      countryErrorMessage = null;
    });

    try {
      await APIManager().apiRequest(
        context,
        API.countrylist,
            (response) {
          print('Country list response: $response');

          if (response is CountryListResponse) {
            if (mounted) setState(() {
              countries = response.data.where((c) => c.isActive).toList();
              print('Loaded ${countries.length} countries: ${countries.map((c) => c.name).toList()}');
            });
          } else {
            print('Unexpected country response type: ${response.runtimeType}');
            if (mounted) setState(() {
              countryErrorMessage = 'Unexpected country response format';
            });
          }
        },
            (error) {
          print('Country list error: $error');
          if (mounted) setState(() {
            countryErrorMessage = 'Failed to load countries: ${error.toString()}';
          });
        },
      );
    } catch (e) {
      print('Exception in fetchCountries: $e');
      if (mounted) setState(() {
        countryErrorMessage = 'Failed to load countries';
      });
    } finally {
      if (mounted) setState(() {
        isLoadingCountries = false;
      });
    }
  }

  Future<void> fetchRanks(int departmentId) async {
    if (mounted) setState(() {
      isLoadingRanks = true;
      rankErrorMessage = null;
      ranks.clear();
    });

    try {
      final requestBody = json.encode({"departmentid": departmentId.toString()});

      await APIManager().apiRequest(
        context,
        API.getdeptwiseranklist,
            (response) {
          print('Raw rank response: ${response.toString()}'); // Debug print

          if (response is RankListResponse) {
            print('Parsed ranks: ${response.data.length} items'); // Debug print
            if (mounted) setState(() {
              ranks = response.data.where((r) => r.isActive).toList();
              print('Filtered active ranks: ${ranks.length}'); // Debug print
            });
          }
        },
            (error) {
          print('Rank list error: $error');
          if (mounted) setState(() {
            rankErrorMessage = 'Failed to load ranks. Please try again.';
          });
        },
        jsonval: requestBody,
      );
    } catch (e) {
      print('Exception in fetchRanks: $e');
      if (mounted) setState(() {
        rankErrorMessage = 'Failed to load ranks. Please try again later.';
      });
    } finally {
      if (mounted) setState(() {
        isLoadingRanks = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Form(
      key: signUpProvider.formKeyDetail,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(width: 10),
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

          _buildDepartmentField(signUpProvider),
          _buildRankField(signUpProvider),

          _buildCountryField(signUpProvider),
          _buildQualificationField(signUpProvider),
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
                        primary: LearningColors.darkBlue,
                        onPrimary: Colors.white,
                        onSurface: Colors.black,
                        surface: Colors.white,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: LearningColors.darkBlue,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentField(SignUpProvider signUpProvider) {
    if (signUpProvider.isLoadingDepartments) {
      return Center(child: CircularProgressIndicator());
    }

    if (signUpProvider.departmentError != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          signUpProvider.departmentError!,
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (signUpProvider.departments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No departments available'),
      );
    }

    return CustomTextFieldWidget(
      textEditingController: signUpProvider.departmentController,
      title: LMSStrings.strDepartment,
      hintText: LMSStrings.strSelectDepartment,
      autovalidateMode: AutovalidateMode.disabled,
      isFieldReadOnly: true,
      onTap: () => _showDepartmentDialog(signUpProvider),
      validator: signUpProvider.validateDepartment,
    );
  }

  Widget _buildCountryField(SignUpProvider signUpProvider) {
    if (signUpProvider.isLoadingCountries) {
      return Center(child: CircularProgressIndicator());
    }

    if (signUpProvider.countryError != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          signUpProvider.countryError!,
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (signUpProvider.countries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No countries available'),
      );
    }

    return CustomTextFieldWidget(
      textEditingController: signUpProvider.countryController,
      title: LMSStrings.strCountry,
      hintText: LMSStrings.strCountryHint,
      autovalidateMode: AutovalidateMode.disabled,
      isFieldReadOnly: true,
      onTap: () => _showCountryDialog(signUpProvider),
      validator: signUpProvider.validateCountry,
    );
  }

  Widget _buildRankField(SignUpProvider signUpProvider) {
    if (signUpProvider.isLoadingRanks) {
      return Center(child: CircularProgressIndicator());
    }

    if (signUpProvider.rankError != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          signUpProvider.rankError!,
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (signUpProvider.selectedDepartmentId == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Please select a department first',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (signUpProvider.ranks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No ranks available for selected department',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return CustomTextFieldWidget(
      textEditingController: signUpProvider.rankController,
      title: LMSStrings.strRank,
      hintText: LMSStrings.strRank,
      autovalidateMode: AutovalidateMode.disabled,
      isFieldReadOnly: true,
      onTap: () => _showRankDialog(signUpProvider),
      validator: signUpProvider.validateRank,
    );
  }

  Future<void> _showDepartmentDialog(SignUpProvider signUpProvider) async {
    final selected = await showDialog<Department>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Department'),
        content: SingleChildScrollView(
          child: Column(
            children: signUpProvider.departments.map((dept) {
              return RadioListTile<Department>(
                title: Text(dept.departmentName),
                value: dept,
                groupValue: signUpProvider.departments.firstWhere(
                      (d) => d.id == signUpProvider.selectedDepartmentId,
                  orElse: () => Department(id: -1, departmentName: '', status: false),
                ),
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selected != null) {
      signUpProvider.setSelectedDepartment(selected);
      signUpProvider.fetchRanks(selected.id);
    }
  }

  Future<void> _showCountryDialog(SignUpProvider signUpProvider) async {
    final selected = await showDialog<Country>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Country'),
        content: SingleChildScrollView(
          child: Column(
            children: signUpProvider.countries.map((country) {
              return RadioListTile<Country>(
                title: Text(country.name),
                value: country,
                groupValue: signUpProvider.countries.firstWhere(
                      (c) => c.id == signUpProvider.selectedCountryId,
                  orElse: () => Country(id: -1, name: '', isActive: false),
                ),
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selected != null) {
      signUpProvider.setSelectedCountry(selected);
    }
  }

  Future<void> _showRankDialog(SignUpProvider signUpProvider) async {
    final selected = await showDialog<Rank>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Rank'),
        content: SingleChildScrollView(
          child: Column(
            children: signUpProvider.ranks.map((rank) {
              return RadioListTile<Rank>(
                title: Text(rank.rank),
                value: rank,
                groupValue: signUpProvider.ranks.firstWhere(
                      (r) => r.id == signUpProvider.selectedRankId,
                  orElse: () => Rank(id: -1, rank: '', tags: '', isActive: false),
                ),
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selected != null) {
      signUpProvider.setSelectedRank(selected);
    }
  }

  Widget _buildQualificationField(SignUpProvider signUpProvider) {
    if (signUpProvider.isLoadingQualifications) {
      return Center(child: CircularProgressIndicator());
    }

    if (signUpProvider.qualificationError != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          signUpProvider.qualificationError!,
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (signUpProvider.qualifications.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No qualifications available'),
      );
    }

    return CustomTextFieldWidget(
      textEditingController: signUpProvider.qualificationController,
      title: 'Qualification',
      hintText: 'Select your qualification',
      autovalidateMode: AutovalidateMode.disabled,
      isFieldReadOnly: true,
      onTap: () => _showQualificationDialog(signUpProvider),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your qualification';
        }
        return null;
      },
    );
  }

  Future<void> _showQualificationDialog(SignUpProvider signUpProvider) async {
    final selected = await showDialog<Qualification>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Qualification'),
        content: SingleChildScrollView(
          child: Column(
            children: signUpProvider.qualifications.map((qualification) {
              return RadioListTile<Qualification>(
                title: Text(qualification.qualificationName),
                value: qualification,
                groupValue: signUpProvider.qualifications.firstWhere(
                      (q) => q.id == signUpProvider.selectedQualificationId,
                  orElse: () => Qualification(id: -1, qualificationName: '', isActive: false),
                ),
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selected != null) {
      signUpProvider.setSelectedQualification(selected);
    }
  }
}

class UploadFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    print('Current documents count: ${provider.documents.length}');
    provider.documents.forEach((doc) {
      print('Document: ${doc.documentName}, Uploaded: ${doc.uploadedProof ?? "Not uploaded"}');
    });

    return Form(
      key: provider.formKeyUpload,
      child: provider.isLoadingDocuments
          ? Center(child: CircularProgressIndicator())
          : provider.documents.isEmpty
          ? Center(child: Text('No documents required'))
          : Column(
        children: [
          /*Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemCount: provider.documents.length,
              itemBuilder: (context, index) {
                final doc = provider.documents[index];
                return CustomTextFieldWidget(
                  title: doc.documentName,
                  isFieldReadOnly: true,
                  hintText: 'Upload ${doc.documentName}',
                  textEditingController: provider.controllers[doc.documentName] ?? TextEditingController(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_) => provider.validateFile(provider.selectedFilePaths[doc.documentName]),
                  onChange: (val) {}, // optional
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (provider.selectedFilePaths[doc.documentName] == null ||
                          provider.selectedFilePaths[doc.documentName]!.isEmpty) {
                        provider.pickFile(doc.documentName);
                      } else {
                        showImageDialog(
                          context,
                          provider.selectedFilePaths[doc.documentName]!,
                          doc.documentName,
                        );
                      }
                    },
                    child: Icon(
                      provider.selectedFilePaths[doc.documentName] == null ||
                      provider.selectedFilePaths[doc.documentName]!.isEmpty
                          ? Icons.upload
                          : Icons.remove_red_eye,
                    ),
                  ),
                );
              },
            ),
          ),*/

          Expanded(
            child: ListView.builder(
              itemCount: provider.documents.length,
              itemBuilder: (context, index) {
                final doc = provider.documents[index];
                return _buildDocumentField(provider, doc);
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

  Widget _buildDocumentField(SignUpProvider provider, Document doc) {
    return CustomTextFieldWidget(
      title: doc.documentName,
      isFieldReadOnly: true,
      hintText: doc.isEducationDocument
          ? 'Upload ${doc.documentName} Certificate'
          : 'Upload ${doc.documentName}',
      textEditingController: provider.controllers[doc.documentName] ?? TextEditingController(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_) => provider.validateFile(provider.selectedFilePaths[doc.documentName]),
      suffixIcon: GestureDetector(
        onTap: () {
          if (provider.selectedFilePaths[doc.documentName] == null ||
              provider.selectedFilePaths[doc.documentName]!.isEmpty) {
            provider.pickFile(doc.documentName);
          } else {
            showImageDialog(
              routeGlobalKey.currentContext!,
              provider.selectedFilePaths[doc.documentName]!,
              doc.documentName,
            );
          }
        },
        child: Icon(
          provider.selectedFilePaths[doc.documentName] == null ||
              provider.selectedFilePaths[doc.documentName]!.isEmpty
              ? Icons.upload
              : Icons.remove_red_eye,
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context, String filePath, String docName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(docName),
        content: filePath.endsWith('.pdf')
            ? Text('PDF file: $filePath') // You might want to use a PDF viewer here
            : Image.file(File(filePath)),
        actions: [
          TextButton(
            onPressed: () {
              print('doc name: ${File(filePath)}');
              Navigator.pop(context);
          },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<SignUpProvider>(context, listen: false)
                  .removeFile(docName);
              Navigator.pop(context);
            },
            child: Text('Remove'),
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
