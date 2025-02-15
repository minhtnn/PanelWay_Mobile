import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/features/account/screens/account_information.dart';
import 'package:panelway_mobile/features/account/screens/account_setting.dart';
import 'package:panelway_mobile/features/home/screen/ac_home_main.dart';
import 'package:panelway_mobile/features/notification/screen/notification_list_screen.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomBarWidget extends StatefulWidget {
  final int? pageIndex;
  const BottomBarWidget({super.key, this.pageIndex});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentPageIndex = 0;
  var _pageController = PageController(initialPage: 0);
  NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;
  final List<Widget> bottomBarPages = [
    ACHomeMain(bottomBarIndex: 1),
    NotificationListScreen(),
    AccountSetting(),
  ];
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.pageIndex ?? 0;

    _pageController = PageController(initialPage: currentPageIndex);
    _controller = NotchBottomBarController(index: currentPageIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pageController.jumpToPage(currentPageIndex);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customBottomBarItem = (IconData iconData, String label) {
      return BottomBarItem(
        inActiveItem: Icon(
          iconData,
          color: Palette.blueButton,
        ),
        activeItem: Icon(
          iconData,
          color: Palette.whiteButton,
        ),
        itemLabel: label,
      );
    };
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Palette.white,
              showLabel: false,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Palette.blueButton,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: true,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: [
                customBottomBarItem(Symbols.home, "Home"),
                customBottomBarItem(Symbols.chat_bubble_outline_rounded, "Chat"),
                customBottomBarItem(Symbols.settings, "Chat"),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
