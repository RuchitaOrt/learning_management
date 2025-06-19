
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/dto/tab_dto.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/Ceritification.dart';
import 'package:learning_mgt/screens/HomePage.dart';
import 'package:learning_mgt/screens/CoursePage.dart';
import 'package:learning_mgt/screens/TrainingScreen.dart';

// class TabProvider with ChangeNotifier {
//   List<TabDTO> tabs = [];
//   late Widget homeScreen;

//   TabProvider(int selectedPos, bool isSignUp, LandingScreenProvider read,int selectedModule,) {
//     homeScreen = HomePage();
//     print("widget.selectedPos provider ${selectedPos}");
//     initTabs(selectedPos,selectedModule);
//   }

//   void initTabs(int selectedPos,int selectedModule) {
//     tabs = [
//        TabDTO(
//         name: "Courses",
//         imagePathSelected: LMSImagePath.selectedCourse,
//         imagePathUnselected: LMSImagePath.unselectedCourse,
//         pageIC:  CoursePage(),
//         pageManager: CoursePage(),
//         isSelected: false,
//         onClicked: () => onTabSelected(0),
//       ),
//       TabDTO(
//         name: "Certifications",
//         imagePathSelected: LMSImagePath.certificateLogo,
//         imagePathUnselected: LMSImagePath.unselectedTraining,
//         pageIC: Ceritification(),
//         pageManager: Ceritification(),
//         isSelected: false,
//         onClicked: () => onTabSelected(1),
//       ),
//       /*TabDTO(
//         name: "Your Training",
//         imagePathSelected: LMSImagePath.selectedTraing,
//         imagePathUnselected: LMSImagePath.unselectedTraining,
//         pageIC: TrainingScreen(),
//         pageManager: TrainingScreen(),
//         isSelected: false,
//         onClicked: () => onTabSelected(1),
//       ),*/
     
    
//     ];
//     onTabSelected(selectedPos);
//   }

//   int selectedIndex = -1; // -1 means home

//   void onTabSelected(int index) {
//     selectedIndex = index;
//     for (int i = 0; i < tabs.length; i++) {
//       tabs[i].isSelected = i == index;
//     }
//     notifyListeners();
//   }
// void resetHomeScreen({bool isSignUp = false}) {
//   homeScreen = HomePage();
//   notifyListeners();
// }

//   void onHomeSelected() {
//     selectedIndex = -1;
//     for (var tab in tabs) {
//       tab.isSelected = false;
//     }
//     notifyListeners();
//      resetHomeScreen(isSignUp: false); // <- Important change
//   }

//   Widget getCurrentPage() {
//     return selectedIndex == -1 ? homeScreen : tabs[selectedIndex].pageIC;
//   }
// }
class TabProvider with ChangeNotifier {
  List<TabDTO> tabs = [];
  late Widget homeScreen;

  TabProvider(int selectedPos, bool isSignUp, LandingScreenProvider read, int selectedModule) {
    homeScreen = HomePage();
    print("widget.selectedPos provider ${selectedPos}");
    initTabs(selectedPos, selectedModule);
  }

  void initTabs(int selectedPos, int selectedModule) {
    tabs = [
      TabDTO(
        name: "Courses",
        imagePathSelected: LMSImagePath.selectedCourse,
        imagePathUnselected: LMSImagePath.unselectedCourse,
        pageIC: CoursePage(),
        pageManager: CoursePage(),
        isSelected: false,
        onClicked: () => onTabSelected(0),
      ),
      TabDTO(
        name: "Certifications",
        imagePathSelected: LMSImagePath.certificateLogo,
        imagePathUnselected: LMSImagePath.unselectedTraining,
        pageIC: Ceritification(),
        pageManager: Ceritification(),
        isSelected: false,
        onClicked: () => onTabSelected(1),
      ),
    ];
    
    // Simplified initialization
    selectedIndex = selectedPos; // Set directly
    
    // Update tab selection states only for valid indices
    if (selectedPos >= 0 && selectedPos < tabs.length) {
      tabs[selectedPos].isSelected = true;
    }
    
    // Don't call any methods here, just notify
    notifyListeners();
  }

  int selectedIndex = -1; // -1 means home

  void onTabSelected(int index) {
    if (index < 0 || index >= tabs.length) {
      return; // Don't change anything for invalid indices
    }
    
    selectedIndex = index;
    for (int i = 0; i < tabs.length; i++) {
      tabs[i].isSelected = i == index;
    }
    notifyListeners();
  }

  void onHomeSelected() {
    selectedIndex = -1;
    for (var tab in tabs) {
      tab.isSelected = false;
    }
    // Remove the resetHomeScreen call - it's unnecessary
    notifyListeners();
  }

  Widget getCurrentPage() {
    if (selectedIndex == -1) {
      return HomePage(); // Return HomePage directly
    } else if (selectedIndex >= 0 && selectedIndex < tabs.length) {
      return tabs[selectedIndex].pageIC;
    } else {
      return HomePage(); // Fallback to home for invalid indices
    }
  }
}