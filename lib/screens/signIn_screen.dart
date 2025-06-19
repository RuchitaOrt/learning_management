import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/sign_In_provider.dart';
import 'package:learning_mgt/screens/TabScreen.dart';
import 'package:learning_mgt/screens/VerificationScreen.dart';
import 'package:learning_mgt/screens/forgotPassword_screen.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  static const String route = "/signIn";
  SignInScreen({super.key});
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

  Widget buildMostInterestedCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 62.5,
      decoration: AppDecorations.gradientBackground,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SignInProvider>(builder: (context, signInProvider, _) {
              return SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                child:
                /*ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),*/
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          LMSImagePath.splashLogo,
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 20),
                      child: Text(
                        title,
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Consumer<SignInProvider>(
                      builder: (context, signInProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Form(
                            key: signInProvider
                                .formKey, // Wrap all fields inside the Form widget
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
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                // Password Field with Validation
                                /*CustomTextFieldWidget(
                                  title: LMSStrings.strpassword,
                                  hintText: LMSStrings.strEnterpassword,
                                  onChange: (val) {},
                                  textEditingController: signInProvider.passwordController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signInProvider.validatePassword,
                                ),*/
                                TextFormField(
                                  style: LMSStyles.tsWhiteNeutral300W50012,
                                  obscureText:
                                      signInProvider.isPasswordObscured,
                                  controller: signInProvider.passwordController,
                                  validator: signInProvider.validatePassword,
                                  decoration: CommonInputDecoration(
                                    hint: LMSStrings.strEnterpassword,
                                    label: LMSStrings.strpassword,
                                    isObscured:
                                        signInProvider.isPasswordObscured,
                                    toggle:
                                        signInProvider.togglePasswordVisibility,
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 0.2),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      Navigator.of(
                                              routeGlobalKey.currentContext!)
                                          .pushNamed(ForgotPasswordScreen.route)
                                          .then((value) {});
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Text(
                                          LMSStrings.strForgetPassword,
                                          style: TextStyle(
                                              color: LearningColors.darkBlue),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 0.6,
                                            color: LearningColors.darkBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2),
                                /*Text(
                                  LMSStrings.strpassword,
                                  style: LMSStyles.tsblackNeutralbold,
                                ),*/
                                /*SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                                TextFormField(
                                  style: LMSStyles.tsWhiteNeutral300W50012,
                                  obscureText: signInProvider.isPasswordObscured,
                                  controller: signInProvider.passwordController,
                                  validator: signInProvider.validatePassword,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    suffixIcon: IconButton(
                                      onPressed: signInProvider
                                          .togglePasswordVisibility,
                                      icon: Icon(
                                        signInProvider.isPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: LearningColors.neutral50,
                                      ),
                                    ),
                                    hintText: LMSStrings.strEnterpassword,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16.0),
                                    border: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: focusedBorder),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: focusedBorder),
                                    filled: true,
                                    fillColor: LearningColors.white,
                                    hintStyle: LMSStyles.tsHintstyle,
                                    errorStyle:
                                        LMSStyles.tsWhiteNeutral300W50012,
                                    counterText: "",
                                  ),
                                ),*/
                                // SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /// Checkbox + Terms
                                    Checkbox(
                                      value: signInProvider.isCheckedTerms,
                                      activeColor: LearningColors.darkBlue,
                                      onChanged: (val) {
                                        signInProvider.toggleTermsCheckbox(val);
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              ' I accept the terms and privacy policy',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),

                                    // Center(
                                    //   child: Column(
                                    //     children: [
                                    //       ElevatedButton.icon(
                                    //         onPressed: () {
                                    //           /*Navigator.of(
                                    //             routeGlobalKey.currentContext!,
                                    //           ).pushNamed(
                                    //             TabScreen.route,
                                    //             arguments: {
                                    //               'selectedPos': -1,
                                    //               'isSignUp': false,
                                    //             },
                                    //           );*/
                                    //           Navigator.pushReplacement(
                                    //             context,
                                    //             MaterialPageRoute(builder: (context) => TabScreen(selectedPos: -1,)),
                                    //           );
                                    //         },
                                    //         label: Text(
                                    //           'Go to Home',
                                    //           style: TextStyle(color: LearningColors.neutral100),
                                    //         ),
                                    //         style: ElevatedButton.styleFrom(
                                    //             backgroundColor: LearningColors.primaryBlue500),
                                    //       ),
                                    //       SizedBox(height: 8),
                                    //       ElevatedButton.icon(
                                    //         onPressed: () {
                                    //           Navigator.of(
                                    //             routeGlobalKey.currentContext!,
                                    //           ).pushNamed(
                                    //             TabScreen.route,
                                    //             arguments: {
                                    //               'selectedPos': 0,
                                    //               'isSignUp': false,
                                    //             },
                                    //           );
                                    //         },
                                    //         label: Text(
                                    //           'Browse Courses',
                                    //           style: TextStyle(color: LearningColors.black18),
                                    //         ),
                                    //         style: ElevatedButton.styleFrom(
                                    //           backgroundColor: Colors.transparent,
                                    //           side: BorderSide(color: Colors.black, width: 1.5),
                                    //           elevation: 0,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )

                                    /*Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: signInProvider.isCheckedTerms,
                                            onChanged: (val) {
                                              signInProvider.toggleTermsCheckbox(val);
                                            },
                                          ),
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'I accept the terms and privacy policy',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/

                                    /*/// Forget Password Text
                                    GestureDetector(
                                      onTap: () {
                                        // Handle forget password
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Text(
                                            LMSStrings.strForgetPassword,
                                            style: LMSStyles
                                                .tsPrimaryblue500300W500,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height: 0.6,
                                              color:
                                                  LearningColors.primaryBlue500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ],
                                ),
                                if (signInProvider.showTermsError)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 26, top: 0),
                                    child: Text(
                                      'Please accept the terms and privacy policy',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 16, right: 10), // only side padding
                  child: Consumer<SignInProvider>(
                    builder: (context, signInProvider, _) {
                      return SizedBox(
                        width: double.infinity, // full width
                        child: ElevatedButton(
                          onPressed: () {
                            if (signInProvider.validateForm()) {
                              Navigator.of(
                                routeGlobalKey.currentContext!,
                              ).pushNamed(
                                TabScreen.route,
                                arguments: {
                                  'selectedPos': -1,
                                  'isSignUp': false,
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LearningColors.darkBlue,
                            padding: EdgeInsets.symmetric(
                                vertical: 14), // internal padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            LMSStrings.strSignIn,
                            style: LMSStyles.tsWhiteNeutral50W600162,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(VerificationScreen.route)
                        .then((value) {});
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LMSStrings.strHaveAnAccount,
                            style: LMSStyles.tsWhiteNeutral300W3002
                                .copyWith(color: LearningColors.neutralBlue750),
                          ),
                          TextSpan(
                            text: LMSStrings.strCreateAnAccount,
                            style: LMSStyles.tsOrange50W60016.copyWith(
                                decoration: TextDecoration.underline,
                                color: LearningColors.darkBrown),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              ],
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 16, right: 20),
                  child: Consumer<SignInProvider>(
                    builder: (context, signInProvider, _) {
                      return ElevatedButton(
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
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(SizeConfig.blockSizeHorizontal * 25,
                              SizeConfig.blockSizeVertical * 5),
                          backgroundColor: LearningColors.darkBlue,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          LMSStrings.strSignIn,
                          style: LMSStyles.tsWhiteNeutral50W600162,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(VerificationScreen.route)
                        .then((value) {});
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LMSStrings.strHaveAnAccount,
                            style: LMSStyles.tsWhiteNeutral300W300,
                          ),
                          TextSpan(
                            text: LMSStrings.strCreateAnAccount,
                            style: LMSStyles.tsOrange50W60016
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   SizeConfig().init(context);

  //   return Scaffold(
  //     body: ChangeNotifierProvider(
  //       create: (_) => SignInProvider(),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Image.asset(
  //             LMSImagePath.coverbg,
  //             width: SizeConfig.blockSizeHorizontal * 100,
  //             height: SizeConfig.blockSizeVertical * 30,
  //             fit: BoxFit.cover,
  //           ),
  //           SizedBox(height: SizeConfig.blockSizeVertical * 2),
  //           buildMostInterestedCard(
  //             title: LMSStrings.strSignIn,
  //             subtitle: LMSStrings.strAccountDetail,
  //             color: LearningColors.white,
  //             titleStyle: LMSStyles.tsblackTileBold,
  //             subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

@override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SignInProvider(),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Image.asset(
              LMSImagePath.coverbg,
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 30,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            buildMostInterestedCard(
              title: LMSStrings.strSignIn,
              subtitle: LMSStrings.strAccountDetail,
              color: LearningColors.white,
              titleStyle: LMSStyles.tsblackTileBold,
              subtitleStyle: LMSStyles.tsWhiteNeutral300W5002,
            ),
          ],
        ),
      ),
    );
  }
}
