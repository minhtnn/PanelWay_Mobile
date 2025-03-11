import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  bool _initialLoadDone = false;
  @override
  void initState() {
    super.initState();
    // Only load data once when widget is created
    _loadDataOnce();
  }

  void _loadDataOnce() {
    if (!_initialLoadDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authVM = Provider.of<AuthViewModel>(context, listen: false);
        authVM.getAccount().then((_) {
          if (mounted) {
            setState(() {}); // Force refresh if needed
          }
        });
        _initialLoadDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    var account = authViewModel.account;

    // Show loading if account is null
    if (account == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                        backgroundColor: Palette.grayTransparent,
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  account.fullName ?? "Unavailable",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  account.email??"Unavailable",
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
                buildProfileOption(
                  Symbols.person_filled,
                  "Account Profile",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.accountInformation);
                  },
                ),
                buildProfileOption(
                  Symbols.history,
                  "History",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.history);
                  },
                ),
                buildProfileOption(
                  Symbols.settings,
                  "Settings",
                  onTap: () {},
                ),
                buildProfileOption(
                  Symbols.logout,
                  "Log out",
                  onTap: () async {
                    await context.read<AuthViewModel>().logout();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildProfileOption(IconData icon, String title,
    {GestureTapCallback? onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.all(5),
    leading: Container(
      padding: EdgeInsets.all(10),
      child: Icon(icon, color: Palette.blueButton),
      decoration: BoxDecoration(
        color: Palette.nearlyWhite2,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    title: Text(title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: onTap,
  );
}
