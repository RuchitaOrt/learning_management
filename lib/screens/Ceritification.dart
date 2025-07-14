import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/main.dart';
import 'package:learning_mgt/model/GetCertificateResponse.dart';
import 'package:learning_mgt/provider/CertificateProvider.dart';
import 'package:learning_mgt/provider/CourseProvider.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final courseProvider =
  //     Provider.of<CertificateCourseprovider>(context, listen: false);
  //     if (courseProvider.coursesByCategory.isNotEmpty) {
  //       setState(() {
  //         selectedCategory = courseProvider.coursesByCategory.keys.first;
  //       });
  //     }
  //   });
  // }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);

      // if (!provider.isSubscriptionLoading) {
      provider.getCategoryList();

       final courseProvider = Provider.of<CourseProvider>(context, listen: false);
      courseProvider.getCertificateAPI();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
     final courseProvider = Provider.of<CourseProvider>(context);
    // final categories = courseProvider.coursesByCategory.keys.toList();

    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
        key: scaffoldKey,
        endDrawer: CustomDrawer(),
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
                      style: LMSStyles.tsblackTileBold,
                      /*style: LMSStyles.tsHeadingbold.copyWith(
                        fontSize: 24,
                        color: LearningColors.darkBlue,
                      ),*/
                    ),
                  ),
                  SizedBox(height: 16),
                  listing(courseProvider)
                  // _buildCertificateCard(courseProvider)
                  // // if (selectedCategory != null &&
                  // //     courseProvider.coursesByCategory[selectedCategory!] !=
                  // //         null) ...[
                    // ...courseProvider.certificatecourseList[selectedCategory!]!
                    //     .map((course) => _buildCertificateCard(courseProvider.certificatecourseList!))
                    //     .toList()
                  // ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
Widget listing(CourseProvider courseProvider)
{
     
   
    if (courseProvider.isCertificateLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: LearningColors.darkBlue,
      ));
    }
    if (courseProvider.certificatecourseList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250),
          child: Text(
            "No certifications found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }
   return Column(
      children: courseProvider.certificatecourseList
          .map((course) => _buildCertificateCard(course))
          .toList(),
    );
}
  Widget _buildCertificateCard(CourseData course) {
    // final isDownloaded = course.isDownloaded;
    final isDownloaded = true;
    final expiryDate =DateTime.parse(course.expiry ) ?? DateTime.now().add(Duration(days: 365));
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
              .pushNamed(CourseDetailPage.route,arguments: {
                "courseID":course.id.toString()
              });
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
                          course.courseName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: LearningColors.darkBlue,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          course.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
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
                    label: "ID: ${course.ogCode}",
                  ),
                  SizedBox(width: 16),
                  _buildInfoItem(
                    icon: Icons.schedule,
                    label: "Duration: ${course.duration}",
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoItem(
                    icon: Icons.calendar_today,
                    label: "Expires: ${course.expiry}"
                    //  ${DateFormat('MMM d, y').format(expiryDate)}",
                  ),
                  SizedBox(width: 16),
                  /*_buildInfoItem(
                    icon: Icons.timer,
                    label: isExpired
                        ? "Expired"
                        : "$daysRemaining days remaining",
                    textColor: isExpired ? Colors.red : Colors.green,
                  ),*/
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