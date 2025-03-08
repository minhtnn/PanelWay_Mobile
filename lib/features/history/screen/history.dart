import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/features/history/widgets/history_box.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';

class UserHistory extends StatefulWidget {
  const UserHistory({super.key});

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
        children: [
          BackButtonCustom(
            context: context,
            backToRoute: AppRoutes.bottombar,
            previousPage: BottomBarPage.settings.index,
            title: "History",
            buttonTitleDistance: 90,
          ),
          const SizedBox(
            height: 32,
          ),
          HistoryBox(
            statusName: "Cancelled",
            statusColor: Palette.red,
            statusIcon: Symbols.cancel,
            statusDescription:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            title: "Panel advertising",
            titleDescription: "123 Nguyen Van Linh, Ward 5, District 2, HCM",
          ),
          const SizedBox(height: 16,),
          HistoryBox(
            statusName: "Pending",
            statusColor: Palette.yellow,
            statusIcon: Symbols.pending,
            statusDescription:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            title: "Panel advertising",
            titleDescription: "123 Nguyen Van Linh, Ward 5, District 2, HCM",
          ),
        ],
      ),
    );
  }
}
