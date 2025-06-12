import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/Utils/lms_strings.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
 
  final VoidCallback isSearchClickVisible;
  final bool isSearchValueVisible;
  

  CustomAppBar({
    super.key,

    required this.isSearchClickVisible,
   required  this.isSearchValueVisible,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

   void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel(); // Cancel previous timer

    _debounce = Timer(const Duration(milliseconds: 500), () { // Debounce API call
      if (query.isNotEmpty) {
        // Provider.of<LandingScreenProvider>(routeGlobalKey.currentContext!, listen: false)
        //     .getSearchList(query);
      }
    });

    setState(() {
      searchController.text = query; // Ensure text remains in field
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length), // Keeps cursor at the end
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LandingScreenProvider>(context);

    return AppBar(
      surfaceTintColor: LearningColors.white,
      backgroundColor: LearningColors.neutral100,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace:

      Padding(
        padding: EdgeInsets.only(top: Platform.isAndroid ? 45 : 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 35), // Slight left margin for balance
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer(); // This will open the Drawer
                },
                child: Icon(Icons.menu, size: 28),
              ),
            ),
            SvgPicture.asset(
              LMSImagePath.splashLogo,
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16), // Same right margin for symmetry
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, size: 25),
                    onPressed: widget.isSearchClickVisible,
                  ),
                  SizedBox(width: 8), // Slight gap between search & notification
                  SvgPicture.asset(LMSImagePath.notify),
                ],
              ),
            ),
          ],
        ),
      )


      /*Padding(
              padding: EdgeInsets.only(top: Platform.isAndroid ? 45 : 60, left: 8),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal *2.5,),
                    child: SvgPicture.asset(
                     LMSImagePath.splashLogo,
                      height: 40,
                    ),
                  ),
                  Spacer(),
                  
                  IconButton(
                    icon: const Icon(Icons.search,size: 25,),
                    onPressed: widget.isSearchClickVisible,
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 0.2),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset(LMSImagePath.notify),
                  ),
               
                ],
              ),
            ),*/
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: widget.isSearchClickVisible,
          ),
        ),
        Expanded(
          child: CustomTextFieldWidget(
            textFieldContainerHeight: 40,
            title: "",
            hintText: LMSStrings.strSearch,
            textEditingController: searchController,
            autovalidateMode: AutovalidateMode.disabled,
            onChange: _onSearch, // Text remains while API is called
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search, color: LearningColors.neutral100),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
      ],
    );
  }
}
