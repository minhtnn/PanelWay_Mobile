import 'package:flutter/material.dart';
import 'package:panelway_mobile/features/notification/widgets/notification_item.dart';

class NotificationSection  extends StatelessWidget {
  final String title;
  final List<NotificationItem> notifications;
  NotificationSection({required this.title, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...notifications,
        ],
      ),
      onTap: () {

        print(1);
      },
    );
  }
}