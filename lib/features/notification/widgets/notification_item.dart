import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final IconData icon;

  NotificationItem({
    required this.time,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue),
          )
          // Icon(Icons.circle, size: 8, color: Colors.blue),
        ],
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      // trailing: Container(
      //   padding: EdgeInsets.all(8),
      //   decoration: BoxDecoration(
      //     color: Colors.grey[200],
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   child: Icon(icon, color: Colors.blue),
      // ),
    );
  }
}
