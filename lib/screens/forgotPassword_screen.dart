import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/sign_In_provider.dart';
import 'package:learning_mgt/provider/sign_up_provider.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/screens/signIn_screen.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String route = "/forgotPassword";
  ForgotPasswordScreen({super.key});
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

  // Widget buildForgotPasswordCard({
  //   required String title,
  //   required String subtitle,
  //   required Color color,
  //   required TextStyle titleStyle,
  //   required TextStyle subtitleStyle,
  // }) {
  //   return Container(
  //     width: SizeConfig.blockSizeHorizontal * 100,
  //     // height: SizeConfig.blockSizeVertical * 100,
  //     decoration: AppDecorations.gradientBackground,
  //     child: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 SvgPicture.asset(
  //                   LMSImagePath.splashLogo,
  //                   height: 40,
  //                   width: 40,
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 30),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: titleStyle,
  //                 ),
  //                 SizedBox(height: 12),
  //                 Text(
  //                   subtitle,
  //                   style: subtitleStyle,
  //                 ),
  //                 SizedBox(height: 30),
  //                 Consumer<SignInProvider>(
  //                   builder: (context, signInProvider, _) {
  //                     return Form(
  //                       key: signInProvider.formKey,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           CustomTextFieldWidget(
  //                             title: LMSStrings.strEmail,
  //                             hintText: LMSStrings.strEnterEmail,
  //                             onChange: (val) {},
  //                             textEditingController:
  //                                 signInProvider.emailController,
  //                             autovalidateMode: AutovalidateMode.disabled,
  //                             validator: signInProvider.validateEmailField,
  //                           ),
  //                           // Add more form fields here if needed
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //             Spacer(),
  //             Consumer<SignInProvider>(
  //               builder: (context, signInProvider, _) {
  //                 return SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: LearningColors.darkBlue,
  //                       foregroundColor: Colors.white,
  //                       padding: EdgeInsets.symmetric(vertical: 16),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       elevation: 5,
  //                     ),
  //                     onPressed: () {
  //                       if (signInProvider.formKey.currentState?.validate() ??
  //                           false) {
  //                         Navigator.of(routeGlobalKey.currentContext!)
  //                             .pushNamed(
  //                           ResetLinkSentScreen.route,
  //                           arguments: {
  //                             'selectedPos': -1,
  //                             'isSignUp': false,
  //                           },
  //                         );
  //                       }
  //                     },
  //                     child: Text(
  //                       LMSStrings.strResetLink,
  //                       style: LMSStyles.tsWhiteNeutral50W600162,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //             SizedBox(height: 16),
  //             Center(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.of(routeGlobalKey.currentContext!).pop();
  //                 },
  //                 child: Text(
  //                   'Go Back',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: LearningColors.black,
  //                     decoration: TextDecoration.underline,
  //                     decorationColor: LearningColors.black,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 16), // Bottom padding
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
Widget buildForgotPasswordCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required Color color,
  required TextStyle titleStyle,
  required TextStyle subtitleStyle,
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: AppDecorations.gradientBackground,
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          LMSImagePath.splashLogo,
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(title, style: titleStyle),
                    SizedBox(height: 12),
                    Text(subtitle, style: subtitleStyle),
                    SizedBox(height: 30),
                    Consumer<SignInProvider>(
                      builder: (context, signInProvider, _) {
                        return Form(
                          key: signInProvider.formKey,
                          child: CustomTextFieldWidget(
                            title: LMSStrings.strEmail,
                            hintText: LMSStrings.strEnterEmail,
                            onChange: (val) {},
                            textEditingController: signInProvider.emailController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: signInProvider.validateEmailField,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40), // Fixed spacing instead of Spacer
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<SignInProvider>(
                  builder: (context, signInProvider, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.darkBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (signInProvider.formKey.currentState?.validate() ?? false) {
                            Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                              ResetLinkSentScreen.route,
                              arguments: {
                                'selectedPos': -1,
                                'isSignUp': false,
                              },
                            );
                          }
                        },
                        child: Text(
                          LMSStrings.strResetLink,
                          style: LMSStyles.tsWhiteNeutral50W600162,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(routeGlobalKey.currentContext!).pop();
                    },
                    child: Text(
                      'Go Back',
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
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider(
        create: (_) => SignInProvider(),
        child: buildForgotPasswordCard(
          context: context,
          title: LMSStrings.strForgetYourPassword,
          subtitle: LMSStrings.strForgetPasswordDetail,
          color: LearningColors.white,
          titleStyle: LMSStyles.tsblackTileBold,
          subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
        ),
      ),
    );
  }
}

class ResetLinkSentScreen extends StatelessWidget {
  static const String route = "/resetLinkSent";

  const ResetLinkSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
        child: buildResetLinkSent(
          title: LMSStrings.strResetLinkSent,
          subtitle: LMSStrings.strResetLinkDetail,
          color: LearningColors.white,
          titleStyle: LMSStyles.tsblackTileBold,
          subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
        ),
      ),
    );
  }

  Widget buildResetLinkSent({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 100,
      decoration: AppDecorations.gradientBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    LMSImagePath.splashLogo,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                title,
                style: titleStyle,
              ),
              SizedBox(height: 12),
              Text(
                subtitle,
                style: subtitleStyle,
              ),
              SizedBox(height: 30),
              Consumer<SignUpProvider>(
                builder: (context, signUpProvider, _) {
                  return Form(
                    key: signUpProvider.formKeyOTP,
                    child: CustomTextFieldWidget(
                      title: 'Enter OTP',
                      hintText: 'Enter 6-digit OTP',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputType: TextInputType.number,
                      onChange: (val) {},
                      textEditingController: signUpProvider.otpController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: signUpProvider.validateOTP,
                    ),
                  );
                },
              ),
              Spacer(),
              Consumer<SignUpProvider>(
                builder: (context, signUpProvider, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.darkBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        if (signUpProvider.formKeyOTP.currentState
                                ?.validate() ??
                            false) {
                          Navigator.of(routeGlobalKey.currentContext!)
                              .pushNamed(
                            ChangePasswordScreen.route,
                            arguments: {
                              'selectedPos': -1,
                              'isSignUp': false,
                            },
                          );
                        }
                      },
                      child: Text(
                        LMSStrings.strEnterChangeassword,
                        style: LMSStyles.tsWhiteNeutral50W600162,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(routeGlobalKey.currentContext!).pop();
                  },
                  child: Text(
                    'Go Back',
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
              // SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  static const String route = "/changePassword";
  ChangePasswordScreen({super.key});
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

  Widget buildChangePasswordCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required Color color,
  required TextStyle titleStyle,
  required TextStyle subtitleStyle,
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: AppDecorations.gradientBackground,
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          LMSImagePath.splashLogo,
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(title, style: titleStyle),
                    SizedBox(height: 12),
                    Text(subtitle, style: subtitleStyle),
                    SizedBox(height: 30),
                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        return Form(
                          key: signUpProvider.formKeyBasic,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                      },
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<SignUpProvider>(
                  builder: (context, signUpProvider, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.darkBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (signUpProvider.formKeyBasic.currentState?.validate() ?? false) {
                            Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                              PasswordResetSuccessScreen.route,
                              arguments: {
                                'selectedPos': -1,
                                'isSignUp': false,
                              },
                            );
                          }
                        },
                        child: Text(
                          LMSStrings.strResetPassword,
                          style: LMSStyles.tsWhiteNeutral50W600162,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(routeGlobalKey.currentContext!).pushNamed(
                        SignInScreen.route,
                        arguments: {
                          'SelectedPos': -1,
                          'isSignUp': false,
                        },
                      );
                    },
                    child: Text(
                      'Sign In',
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
          ),
        ],
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  SizeConfig().init(context);

  return WillPopScope(
    onWillPop: () async {
      Navigator.of(context).pushReplacementNamed(
        ForgotPasswordScreen.route,
        arguments: {
          'selectedPos': -1,
          'isSignUp': false,
        },
      );
      return false; // Prevent default back behavior
    },
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
        child: buildChangePasswordCard(
          context: context, // Pass context here
          title: LMSStrings.strCreateANewPassword,
          subtitle: LMSStrings.strCreateNewPasswordDetail,
          color: LearningColors.white,
          titleStyle: LMSStyles.tsblackTileBold,
          subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
        ),
      ),
    ),
  );
}

}

class PasswordResetSuccessScreen extends StatelessWidget {
  static const String route = "/passwordResetSuccess";

  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
        child: buildPasswordResetSuccessCard(
          title: 'Password Reset Successfully!',
          subtitle:
              'Your password has been updated. You can now log in with your new credentials and continue exploring premium courses.',
          color: LearningColors.white,
          titleStyle: LMSStyles.tsblackTileBold,
          subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
        ),
      ),
    );
  }

  Widget buildPasswordResetSuccessCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 100,
      decoration: AppDecorations.gradientBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    LMSImagePath.splashLogo,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              SizedBox(height: 30),

              Text(
                title,
                style: titleStyle,
              ),
              SizedBox(height: 12),

              Text(
                subtitle,
                style: subtitleStyle,
              ),
              SizedBox(height: 40),

              // Success content section
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          'assets/images/successful.gif', // Add your GIF path here
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Password Reset Complete',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'You can now sign in with your new password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(routeGlobalKey.currentContext!)
                            .pushNamedAndRemoveUntil(
                          SignInScreen.route,
                          (route) => false,
                        );
                      },
                      label: Text(
                        LMSStrings.strSignIn,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.darkBlue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
