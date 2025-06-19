import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_images.dart';
import 'package:learning_mgt/dto/tab_dto.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/Tabprovider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  static const String route = "/tab_screen";
  final int selectedPos;
  final bool isSignUp;
  final int selectedModule;

  const TabScreen({
    super.key,
    required this.selectedPos,
    this.isSignUp = false,
    this.selectedModule = 0,
  });

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final selectedPos = args?['selectedPos'] ?? widget.selectedPos;
    final isSignUp = args?['isSignUp'] ?? widget.isSignUp;
    print("Route arguments: $args");
    print("Extracted selectedPos: $selectedPos"); // This should show -1
    print("Widget selectedPos: ${widget.selectedPos}");
    return ChangeNotifierProvider<TabProvider>(
      create: (_) => TabProvider(
        selectedPos,
        isSignUp,
        context.read<LandingScreenProvider>(),
        widget.selectedModule,
      ),
      child: Consumer2<TabProvider, LandingScreenProvider>(
        builder: (context, provider, appProvider, _) {
          return WillPopScope(
            onWillPop: () async {
              if (provider.selectedIndex == -1) {
                final now = DateTime.now();
                if (_lastBackPressed == null ||
                    now.difference(_lastBackPressed!) >
                        const Duration(seconds: 10)) {
                  _lastBackPressed = now;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Press back again to exit")),
                  );
                  return false;
                }
                return true;
              } else {
                provider.onHomeSelected();
                return false;
              }
            },
            child: Scaffold(
              key: scaffoldKey,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isSearchClickVisible: () {},
                  isSearchValueVisible: false,
                  onMenuPressed: () =>
                      scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),
              endDrawer: CustomDrawer(),
              body: provider.getCurrentPage(),
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: LearningColors.darkBlue,
                elevation: 5,
                onPressed: provider.onHomeSelected,
                child: SvgPicture.asset(
                  LMSImagePath.home,
                  color: provider.selectedIndex == -1
                      ? LearningColors.white
                      : Colors.grey,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 6,
                  color: LearningColors.darkBlue,
                  child: SizedBox(
                    height: Theme.of(context).platform == TargetPlatform.iOS
                        ? 45
                        : 50,
                    child: Row(
                      children: [
                        // Left tab
                        Expanded(child: _buildTabButton(provider.tabs[0])),
                        const SizedBox(width: 48), // Space for FAB
                        // Right tab
                        Expanded(child: _buildTabButton(provider.tabs[1])),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabButton(TabDTO tab) {
    final isSelected = tab.isSelected;
    return InkWell(
      onTap: tab.onClicked,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSelected ? tab.imagePathSelected : tab.imagePathUnselected,
            height: 18,
            colorFilter: ColorFilter.mode(
              isSelected ? LearningColors.white : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tab.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? LearningColors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
