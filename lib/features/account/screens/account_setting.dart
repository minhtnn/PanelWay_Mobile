import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Palette.white,
                      backgroundImage:
                          AssetImage('lib\\assets\\default-avatar.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Nguyen Van A",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Panelway@gmail.com",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      "26 days left",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                buildProfileOption(Icons.remove_red_eye, "Account Profile",
                    onTap: () {
                  Navigator.pushNamed(context, AppRoutes.accountInformation);
                }),
                buildProfileOption(Icons.favorite, "Favourite"),
                buildProfileOption(Icons.history, "History"),
                buildProfileOption(Icons.settings, "Settings"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class AccountSetting extends StatefulWidget {
//   const AccountSetting({super.key});

//   @override
//   State<AccountSetting> createState() => _AccountSettingState();
// }

// class _AccountSettingState extends State<AccountSetting> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,

//         children: [
//           SizedBox(height: 16),
//           Center(
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.black,
//                         child: Icon(Icons.edit, color: Colors.white, size: 16),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Nguyen Van A",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Panelway@gmail.com",
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.star, color: Colors.blue),
//                     SizedBox(width: 4),
//                     Text(
//                       "26 days left",
//                       style: TextStyle(fontSize: 16, color: Colors.blue),
//                     ),
//                   ],
//                 ),
//                 CustomButton(functionName: "Log out", onPressed: (){}, buttonBackgroundColor: Palette.blueButton, textColor: Palette.white)
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView(
//               children: [
//                 buildProfileOption(Icons.remove_red_eye, "Account Profile",
//                     onTap: () {
//                   Navigator.pushNamed(context, AppRoutes.accountInformation);
//                 }),
//                 buildProfileOption(Icons.favorite, "Favourite"),
//                 buildProfileOption(Icons.history, "History"),
//                 buildProfileOption(Icons.settings, "Settings"),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: BottomBarWidget(
//       //     // list: widget.list,
//       //     ),
//     );
//   }
// }

Widget buildProfileOption(IconData icon, String title,
    {GestureTapCallback? onTap}) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(title, style: TextStyle(fontSize: 16)),
    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: onTap,
  );
}
