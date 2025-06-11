import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/instituteprovider.dart';
import 'package:provider/provider.dart';

class InstituteScreen extends StatefulWidget {
  static const String route = "/instituteScreen";
  InstituteScreen({Key? key}) : super(key: key);

  @override
  _InstituteScreenState createState() => _InstituteScreenState();
}

class _InstituteScreenState extends State<InstituteScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: AppDecorations.gradientBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Consumer<InstituteProvider>(
              builder: (context, instituteProvider, child) {
                return ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
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
                            "Institutes",
                            style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        "Select an Institute to view details",
                        style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 16),
                      ),
                    ),
                    ...List.generate(
                      instituteProvider.institutesData.length,
                      (index) => InstituteExpansionTile(
                        instituteData: instituteProvider.institutesData[index],
                        isExpanded: expandedIndex == index,
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            expandedIndex = expanded ? index : null;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class InstituteExpansionTile extends StatelessWidget {
  final Map<String, dynamic> instituteData;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const InstituteExpansionTile({
    Key? key,
    required this.instituteData,
    required this.isExpanded,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = instituteData['name'] as String;
    final String iconPath = instituteData['iconPath'] as String;
    final List<Map<String, dynamic>> courses =
        instituteData['courses'] as List<Map<String, dynamic>>;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: LearningColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            listTileTheme: ListTileTheme.of(context).copyWith(
              contentPadding: EdgeInsets.zero,
            ),
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            onExpansionChanged: onExpansionChanged,
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            title: Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    name,
                    style: LMSStyles.tsblackTileBold.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            children: courses.map((course) {
              final String title = course['title'] as String;
              final String description = course['description'] as String;
              final String enrollmentNo = course['enrollmentNo'] as String;
              final String date = course['date'] as String;
              final String time = course['time'] as String;
              final String duration = course['duration'] as String;
              final String mode = course['mode'] as String;
              final double price = course['price'] as double;
      
              return Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: LMSStyles.tsblackTileBold.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          description,
                          style: LMSStyles.tsblackNeutralbold
                              .copyWith(fontSize: 12, color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildEnrollmentDetails(
                              enrollmentNo: enrollmentNo,
                              date: date,
                              time: time,
                              duration: duration,
                              mode: mode,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: LMSStyles.tsblueW900.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildEnrollmentDetails({
    required String enrollmentNo,
    required String date,
    required String time,
    required String duration,
    required String mode,
  }) {
    return RichText(
      text: TextSpan(
        style: LMSStyles.tsblackNeutralbold
            .copyWith(fontSize: 12, color: Colors.grey.shade600),
        children: [
          TextSpan(text: 'Enrollment no.: '),
          TextSpan(
              text: enrollmentNo,
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\nDate: '),
          TextSpan(text: date, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\nTime: '),
          TextSpan(text: time, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\nDuration: '),
          TextSpan(
              text: duration, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '\nMode: '),
          TextSpan(text: mode, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}
