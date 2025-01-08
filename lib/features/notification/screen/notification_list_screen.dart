import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/features/notification/widgets/notification_item.dart';
import 'package:panelway_mobile/features/notification/widgets/notification_section.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          NotificationSection(
            title: 'Today',
            notifications: [
              NotificationItem(
                time: '1 hour',
                title: 'Lorem Ipsum is simply',
                description:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                icon: Icons.mail_outline,
              ),
            ],
          ),
          SizedBox(height: 16),
          NotificationSection(
            title: 'This week',
            notifications: [
              NotificationItem(
                time: '4 days',
                title: 'Lorem Ipsum is',
                description:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                icon: Icons.insert_chart_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
