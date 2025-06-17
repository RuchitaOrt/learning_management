import 'package:flutter/material.dart';
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

  Widget buildForgotPasswordCard({
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
          padding: const EdgeInsets.all(20.0),
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

              Expanded(
                child: Consumer<SignInProvider>(
                  builder: (context, signInProvider, _) {
                    return Form(
                      key: signInProvider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFieldWidget(
                            title: LMSStrings.strEmail,
                            hintText: LMSStrings.strEnterEmail,
                            onChange: (val) {},
                            textEditingController:
                                signInProvider.emailController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: signInProvider.validateEmailField,
                          ),
                          // Add more form fields here if needed
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.of(routeGlobalKey.currentContext!).pop();
                      },
                      child: Text(
                        LMSStrings.strSignIn,
                        style: LMSStyles.tsblackNeutralbold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Consumer<SignInProvider>(
                      builder: (context, signInProvider, _) {
                        return ElevatedButton(
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
                            if (signInProvider.formKey.currentState
                                    ?.validate() ??
                                false) {
                              Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed( ResetLinkSentScreen.route,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SignInProvider(),
        child: buildForgotPasswordCard(
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
        create: (_) => SignInProvider(),
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
          padding: const EdgeInsets.all(20.0),
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
              
              // Expanded(
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.email_outlined,
              //           size: 80,
              //           color: LearningColors.darkBlue,
              //         ),
              //         SizedBox(height: 20),
              //         Text(
              //           'Check your email',
              //           style: LMSStyles.tsblackTileBold,
              //         ),
              //         SizedBox(height: 10),
              //         Text(
              //           'We have sent password reset instructions to your email.',
              //           textAlign: TextAlign.center,
              //           style: LMSStyles.tsWhiteNeutral300W5002,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Spacer(),
              // Bottom buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.of(routeGlobalKey.currentContext!).pop();
                      },
                      child: Text(
                        "Back",
                        style: LMSStyles.tsblackNeutralbold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
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
                        Navigator.of(routeGlobalKey.currentContext!).pushNamed(
                          ChangePasswordScreen.route,
                          arguments: {
                            'selectedPos': -1,
                            'isSignUp': false,
                          },
                        );
                      },
                      child: Text(
                        LMSStrings.strEnterChangeassword,
                        style: LMSStyles.tsWhiteNeutral50W600162,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
          padding: const EdgeInsets.all(20.0),
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

              Expanded(
                child: Consumer<SignInProvider>(
                  builder: (context, signInProvider, _) {
                    return Form(
                      key: signInProvider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFieldWidget(
                            title: LMSStrings.strEnterpassword,
                            hintText: LMSStrings.strEnterpassword,
                            onChange: (val) {},
                            textEditingController:
                                signInProvider.emailController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: signInProvider.validateEmailField,
                          ),
                          CustomTextFieldWidget(
                            title: LMSStrings.strEnterpassword,
                            hintText: LMSStrings.strEnterpassword,
                            onChange: (val) {},
                            textEditingController:
                                signInProvider.emailController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: signInProvider.validateEmailField,
                          ),
                          // Add more form fields here if needed
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.of(routeGlobalKey.currentContext!).pop();
                      },
                      child: Text(
                        "Back",
                        style: LMSStyles.tsblackNeutralbold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Consumer<SignInProvider>(
                      builder: (context, signInProvider, _) {
                        return ElevatedButton(
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
                            if (signInProvider.formKey.currentState
                                    ?.validate() ??
                                false) {
                              Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed( ResetLinkSentScreen.route,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SignInProvider(),
        child: buildChangePasswordCard(
          title: LMSStrings.strCreateANewPassword,
          subtitle: LMSStrings.strCreateNewPasswordDetail,
          color: LearningColors.white,
          titleStyle: LMSStyles.tsblackTileBold,
          subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
        ),
      ),
    );
  }
}