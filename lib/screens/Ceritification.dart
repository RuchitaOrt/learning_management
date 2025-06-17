/*
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/CertificateProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

class Ceritification extends StatefulWidget {
  static const String route = "/Ceritification";
  @override
  _CeritificationState createState() => _CeritificationState();
}

class _CeritificationState extends State<Ceritification> {
  String? selectedCategory;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
          Provider.of<CertificateCourseprovider>(context, listen: false);
      if (courseProvider.coursesByCategory.isNotEmpty) {
        setState(() {
          selectedCategory = courseProvider.coursesByCategory.keys.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CertificateCourseprovider>(context);
    final categories = courseProvider.coursesByCategory.keys.toList();

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      // Show loading spinner while fetching data

      return Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {
              // provider.toggleSearchIconCategory();
            },
            isSearchValueVisible: provider.isSearchIconVisible,
             onMenuPressed: () => scaffoldKey.currentState?.openDrawer(), 
          ),
        ),
        body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          decoration: AppDecorations.gradientBackground,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Certification",
                          style: LMSStyles.tsHeadingbold.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  if (selectedCategory != null &&
                      courseProvider.coursesByCategory[selectedCategory!] !=
                          null) ...[
                    ...courseProvider.coursesByCategory[selectedCategory!]!
                        .map((course) => _buildVerticalCard(course))
                        .toList()
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildVerticalCard(CertificateProvider course) {
    return GestureDetector(
      onTap: () {
        Navigator.of(routeGlobalKey.currentContext!)
            .pushNamed(CourseDetailPage.route)
            .then((value) {});
      },
      child: Card(
        elevation: 0.5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(LMSImagePath.certificateLogo),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 75,
                      child: Text(
                        course.title,
                        style: LMSStyles.tsHeadingbold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(course.description, style: LMSStyles.tsSubHeadingBold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Id: #ACDS1102999", style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Duration: 25.5 hrs",
                              style: LMSStyles.tsHeading),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        LMSStrings.strView,
                        style: LMSStyles.tsblackNeutralbold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.darkBlue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        LMSStrings.strDownload,
                        style: LMSStyles.tsWhiteNeutral50W60016,
                      ),
                    ),
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
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/provider/CertificateProvider.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/CourseDetailPage.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Ceritification extends StatefulWidget {
  static const String route = "/Certification";
  @override
  _CeritificationState createState() => _CeritificationState();
}

class _CeritificationState extends State<Ceritification> {
  String? selectedCategory;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider =
      Provider.of<CertificateCourseprovider>(context, listen: false);
      if (courseProvider.coursesByCategory.isNotEmpty) {
        setState(() {
          selectedCategory = courseProvider.coursesByCategory.keys.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CertificateCourseprovider>(context);
    final categories = courseProvider.coursesByCategory.keys.toList();

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(),
        /*appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            isSearchClickVisible: () {},
            isSearchValueVisible: provider.isSearchIconVisible,
            onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),*/
        body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          decoration: AppDecorations.gradientBackground,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "My Certifications",
                      style: LMSStyles.tsHeadingbold.copyWith(
                        fontSize: 24,
                        color: LearningColors.darkBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (selectedCategory != null &&
                      courseProvider.coursesByCategory[selectedCategory!] !=
                          null) ...[
                    ...courseProvider.coursesByCategory[selectedCategory!]!
                        .map((course) => _buildCertificateCard(course))
                        .toList()
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCertificateCard(CertificateProvider course) {
    // final isDownloaded = course.isDownloaded;
    final isDownloaded = true;
    final expiryDate = course.expiryDate ?? DateTime.now().add(Duration(days: 365));
    final daysRemaining = expiryDate.difference(DateTime.now()).inDays;
    final isExpired = daysRemaining <= 0;

    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(routeGlobalKey.currentContext!)
              .pushNamed(CourseDetailPage.route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: LearningColors.darkBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      LMSImagePath.certificateLogo,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: LMSStyles.tsHeadingbold.copyWith(
                            fontSize: 16,
                            color: LearningColors.darkBlue,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          course.description,
                          style: LMSStyles.tsSubHeadingBold.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey.shade300),
              SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoItem(
                    icon: Icons.numbers,
                    label: "ID: #ACDS1102999",
                  ),
                  SizedBox(width: 16),
                  _buildInfoItem(
                    icon: Icons.schedule,
                    label: "Duration: 25.5 hrs",
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoItem(
                    icon: Icons.calendar_today,
                    label: "Expires: ${DateFormat('MMM d, y').format(expiryDate)}",
                  ),
                  SizedBox(width: 16),
                  _buildInfoItem(
                    icon: Icons.timer,
                    label: isExpired
                        ? "Expired"
                        : "$daysRemaining days remaining",
                    textColor: isExpired ? Colors.red : Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // View certificate logic
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: LearningColors.darkBlue,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        "View",
                        style: LMSStyles.tsblackNeutralbold.copyWith(
                          color: LearningColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: isDownloaded
                        ? Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Downloaded",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        // Download certificate logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LearningColors.darkBlue,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Download",
                            style: LMSStyles.tsWhiteNeutral50W60016,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    Color? textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: textColor ?? Colors.grey.shade700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}