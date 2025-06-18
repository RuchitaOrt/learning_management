/*
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart'; // For SizeConfig

class SeafarerSettings extends StatefulWidget {
  static const String route = "/SeafarerSettings";
  const SeafarerSettings({Key? key}) : super(key: key);

  @override
  _SeafarerSettingsState createState() => _SeafarerSettingsState();
}

class _SeafarerSettingsState extends State<SeafarerSettings> {
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
          return true;
        },
        child: Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(kToolbarHeight),
          //   child: CustomAppBar(
          //     isSearchClickVisible: () {
          //       // provider.toggleSearchIconCategory();
          //     },
          //     isSearchValueVisible: provider.isSearchIconVisible,
          //   ),
          // ),
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
                      "Seafarers",
                      style:
                          LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: SizeConfig.blockSizeVertical * 1,
              // ),

              // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    informationPlan(
                        "Seafarers No.",
                        personalprovider.seafarersNoController,
                        "Enter Your Seafarers Number"),
                    informationPlan(
                        "Passport No.",
                        personalprovider.passportNoController,
                        "Enter Your Passport Number"),
                    informationPlan(
                        "Department",
                        personalprovider.departmentController,
                        "Enter Your Department"),
                    informationPlan("Rank", personalprovider.rankController,
                        "Enter Your Rank"),
                    informationPlan(
                        "Pin Code",
                        personalprovider.pinCodeController,
                        "Enter Your Pin Code"),
                    informationPlan(
                        "Country",
                        personalprovider.countryController,
                        "Enter Your Country"),
                    informationPlan("City", personalprovider.cityController,
                        "Enter Your City"),
                    informationPlan("State", personalprovider.stateController,
                        "Enter Your State"),
                    informationPlan("COC", personalprovider.COCController,
                        "Enter Your COC"),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "5 years left from now",
                        style:
                        LMSStyles.tsWhiteNeutral300W300.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                  ],
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
*/


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class SeafarerSettings extends StatefulWidget {
  static const String route = "/SeafarerSettings";
  const SeafarerSettings({Key? key}) : super(key: key);

  @override
  _SeafarerSettingsState createState() => _SeafarerSettingsState();
}

class _SeafarerSettingsState extends State<SeafarerSettings> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _buildForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        Text("Seafarers", style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18)),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Consumer<PersonalAccountProvider>(
        builder: (context, personalprovider, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildField("Seafarers No.", personalprovider.seafarersNoController, "Enter Your Seafarers Number"),
              _buildField("Passport No.", personalprovider.passportNoController, "Enter Your Passport Number"),
              _buildField("Department", personalprovider.departmentController, "Enter Your Department"),
              _buildField("Rank", personalprovider.rankController, "Enter Your Rank"),
              _buildField("Pin Code", personalprovider.pinCodeController, "Enter Your Pin Code"),
              _buildField("Country", personalprovider.countryController, "Enter Your Country"),
              _buildField("City", personalprovider.cityController, "Enter Your City"),
              _buildField("State", personalprovider.stateController, "Enter Your State"),

              //const SizedBox(height: 10),
              Text("COC", style: LMSStyles.tsHintstyle.copyWith(fontSize: 14)),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: personalprovider.COCController,
                      decoration: InputDecoration(
                        hintText: "Enter Your COC",
                        hintStyle: LMSStyles.tsHintstyle.copyWith(
                          fontSize: LMSStyles.tsHintstyle.fontSize! + 4,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: LearningColors.neutral300, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: LearningColors.neutral300, width: 1.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Verify", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "${_calculateYearsLeft()} years left from now",
                  style: LMSStyles.tsWhiteNeutral300W300.copyWith(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: LearningColors.darkBlue, // Border color
                            width: 0.5, // Border width
                          ),
                          backgroundColor: Colors.transparent, // Transparent background
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: LMSStyles.tsblackNeutralbold.copyWith(
                            color: LearningColors.darkBlue, // Text color matching border
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.darkBlue,
                          padding: EdgeInsets.symmetric(vertical: 14),
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
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget _buildField(String title, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: CustomTextFieldWidget(
        title: title,
        hintText: hint,
        onChange: (val) {},
        textEditingController: controller,
        autovalidateMode: AutovalidateMode.disabled,
      ),
    );
  }

  int _calculateYearsLeft() {
    final now = DateTime.now();
    return 5; // as per your logic, it's always 5 years from now
  }
}
