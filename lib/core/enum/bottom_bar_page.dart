import 'package:flutter/material.dart';
import 'package:panelway_mobile/features/account/screens/account_setting.dart';
import 'package:panelway_mobile/features/home/screen/ac_home_main.dart';
import 'package:panelway_mobile/features/notification/screen/notification_list_screen.dart';
import 'package:panelway_mobile/features/package_plan/screen/package_plan.dart';

enum BottomBarPage {
  home,
  notifications,
  packagePlan,
  settings;

  // Get the index (1-based as per your requirement)
  int get pageIndex => this.pageIndex + 1;

  // Get the corresponding widget
  Widget  get widget {
    switch (this) {
      case BottomBarPage.home:
        return ACHomeMain(bottomBarIndex: this.index);
      case BottomBarPage.notifications:
        return NotificationListScreen();
      case BottomBarPage.packagePlan:
        return PackagePlan();
      case BottomBarPage.settings:
        return AccountSetting();
    }
  }

  // Get page from index
  static BottomBarPage fromIndex(int pageIndex) {
    return BottomBarPage.values[pageIndex - 1];
  }
}