import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';

class BottomBarWidget extends StatefulWidget {
  final int? pageIndex;
  const BottomBarWidget({super.key, this.pageIndex});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentPageIndex = 0;
  late PageController _pageController;
  late NotchBottomBarController _controller;
  int maxCount = 5;
  final List<Widget> bottomBarPages = BottomBarPage.values.map((page) => page.widget).toList();

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.pageIndex ?? 0;
    _initializeControllers();
  }

  void _initializeControllers() {
    _pageController = PageController(initialPage: currentPageIndex);
    _controller = NotchBottomBarController(index: currentPageIndex);
  }

  @override
  void didUpdateWidget(BottomBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pageIndex != null && widget.pageIndex != currentPageIndex) {
      setState(() {
        currentPageIndex = widget.pageIndex!;
        _pageController.jumpToPage(currentPageIndex);
        _controller.index = currentPageIndex;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customBottomBarItem = (IconData iconData, String label) {
      return BottomBarItem(
        inActiveItem: Icon(
          iconData,
          color: Palette.blueButton,
          fill: 1,
        ),
        activeItem: Icon(
          iconData,
          color: Palette.whiteButton,
          fill: 1,
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
                customBottomBarItem(Symbols.package, "Package plan"),
                customBottomBarItem(Symbols.settings, "Settings"), // Fixed label
              ],
              onTap: (index) {
                setState(() {
                  currentPageIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}