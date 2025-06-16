
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/dto/tab_dto.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/HomePage.dart';
import 'package:learning_mgt/screens/CoursePage.dart';
import 'package:learning_mgt/screens/TrainingScreen.dart';

class TabProvider with ChangeNotifier {
  List<TabDTO> tabs = [];
  late Widget homeScreen;

  TabProvider(int selectedPos, bool isSignUp, LandingScreenProvider read,int selectedModule,) {
    homeScreen = HomePage();
    print("widget.selectedPos provider ${selectedPos}");
    initTabs(selectedPos,selectedModule);
  }

  void initTabs(int selectedPos,int selectedModule) {
    tabs = [
       TabDTO(
        name: "Courses",
        imagePathSelected: LMSImagePath.selectedCourse,
        imagePathUnselected: LMSImagePath.unselectedCourse,
        pageIC:  CoursePage(),
        pageManager: CoursePage(),
        isSelected: false,
        onClicked: () => onTabSelected(0),
      ),
      TabDTO(
        name: "Your Training",
        imagePathSelected: LMSImagePath.selectedTraing,
        imagePathUnselected: LMSImagePath.unselectedTraining,
        pageIC: TrainingScreen(),
        pageManager: TrainingScreen(),
        isSelected: false,
        onClicked: () => onTabSelected(1),
      ),
     
    
    ];
    onTabSelected(selectedPos);
  }

  int selectedIndex = -1; // -1 means home

  void onTabSelected(int index) {
    selectedIndex = index;
    for (int i = 0; i < tabs.length; i++) {
      tabs[i].isSelected = i == index;
    }
    notifyListeners();
  }
void resetHomeScreen({bool isSignUp = false}) {
  homeScreen = HomePage();
  notifyListeners();
}

  void onHomeSelected() {
    selectedIndex = -1;
    for (var tab in tabs) {
      tab.isSelected = false;
    }
    notifyListeners();
     resetHomeScreen(isSignUp: false); // <- Important change
  }

  Widget getCurrentPage() {
    return selectedIndex == -1 ? homeScreen : tabs[selectedIndex].pageIC;
  }
}
