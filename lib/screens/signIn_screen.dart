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

class SignInScreen extends StatefulWidget {
  static const String route = "/signIn";
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

 @override
  void initState() {
    // TODO: implement initState
 super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("COMING");
      final provider =
          Provider.of<SignInProvider>(context, listen: false);
         
        provider.setIDandpassword();

           print(provider.emailController.text);
 

    });
  }

  Widget buildMostInterestedCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      // height: SizeConfig.blockSizeVertical * 62.5,
      decoration: AppDecorations.gradientBackground,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 72),
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
                  mainAxisSize: MainAxisSize.min,
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
                                Theme(
                                   data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                                  child: TextFormField(
                                    cursorColor: LearningColors.darkBlue,
                                    style: LMSStyles.tsWhiteNeutral300W50012,
                                    obscureText:
                                        signInProvider.isPasswordObscured,
                                    controller: signInProvider.passwordController,
                                    // validator: signInProvider.validatePassword,
                                    decoration: CommonInputDecoration(
                                      hint: LMSStrings.strEnterpassword,
                                      label: LMSStrings.strpassword,
                                      isObscured:
                                          signInProvider.isPasswordObscured,
                                      toggle:
                                          signInProvider.togglePasswordVisibility,
                                    ),
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
                /*Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 16, right: 10), // only side padding
                  child: Consumer<SignInProvider>(
                    builder: (context, signInProvider, _) {
                      return signInProvider.isLoading
                          ? CircularProgressIndicator()
                        : SizedBox(
                        width: double.infinity, // full width
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus(); // Hide keyboard
                            Provider.of<SignInProvider>(context, listen: false).createSignIn();
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
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 16, right: 10),
                  child: Consumer<SignInProvider>(
                    builder: (context, signInProvider, _) {
                      return  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: signInProvider.areRequiredFieldsFilled
                              ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Provider.of<SignInProvider>(context, listen: false).createSignIn();
                          }
                              : null, // Disables button when conditions aren't met
                          style: ElevatedButton.styleFrom(
                            backgroundColor: signInProvider.areRequiredFieldsFilled
                                ? LearningColors.darkBlue
                                : LearningColors.darkBlue.withOpacity(0.5), // Grayed out when disabled
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child:signInProvider.isLoading
                          ? Center(child: CircularProgressIndicator(color: LearningColors.white,))
                          : Text(
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    // Navigator.of(routeGlobalKey.currentContext!)
                    Navigator.of(context)
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
          ],
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
        child: SafeArea(
          child: SingleChildScrollView(
            // shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            child:
              Column(
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
        ),
      ),
    );
  }
}
