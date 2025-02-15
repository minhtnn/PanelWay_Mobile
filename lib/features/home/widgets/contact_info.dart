import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(style: BorderStyle.solid, color: Palette.spacer)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              "Contact information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Nguyen Thi B',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Contact for more details'),
                ],
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage('https://example.com/profile.jpg'),
                backgroundColor: Palette.grey,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: () {
          //     // Handle contact upgrade
          //   },
          //   child: Text('Upgrade to get'),

          // ),
          CustomButton(
            functionName: 'Upgrade to get',
            onPressed: () {},
            buttonBackgroundColor: Palette.buttonGrayTransparent,
            textColor: Palette.deactivatedText,
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }
}
