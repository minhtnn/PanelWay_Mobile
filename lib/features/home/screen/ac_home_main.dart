import 'package:flutter/material.dart';
import 'package:panelway_mobile/features/home/widgets/advertisement_card%20.dart';
import 'package:panelway_mobile/features/home/widgets/bottom_bar.dart';
import 'package:panelway_mobile/features/home/widgets/icon_navigation.dart';

class ACHomeMain extends StatefulWidget {
  final List<Map<String, dynamic>> list = [
    {'icon': Icons.home, 'page': 'Home'},
    {'icon': Icons.message, 'page': 'Message'},
    {'icon': Icons.tab, 'page': 'Task'},
    {'icon': Icons.settings, 'page': 'Setting'},
    {'icon': Icons.account_balance, 'page': 'Account'},
  ];
  ACHomeMain({super.key});

  @override
  State<ACHomeMain> createState() => _ACHomeMainState();
}

class _ACHomeMainState extends State<ACHomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleIconNavigation(
                  iconData: Icons.notifications_none_rounded, onTap: () {}),
              const SizedBox(width: 15),
              CircleIconNavigation(
                  iconData: Icons.grid_view_outlined, onTap: () {}),
            ],
          ),
          actions: [
            DropdownButton(
              value: 'Thủ Đức, Hồ Chí Minh',
              items: [
                DropdownMenuItem(
                  child: Text('Thủ Đức, Hồ Chí Minh'),
                  value: 'Thủ Đức, Hồ Chí Minh',
                ),
              ],
              onChanged: (value) {
                // Handle location change
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
          children: [
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AdvertisementCard(
                  imageUrl: '',
                  title: 'Billboard advertising',
                  location: 'Thủ Đức, District 2, HCM',
                  price: 'From 500/month',
                  minDuration: '1 year min',
                  traffic: '50,000 views/day',
                  type: 'Outdoor billboard',
                ),
                AdvertisementCard(
                  imageUrl: '',
                  title: 'Another advertising',
                  location: 'District 3, HCM',
                  price: 'From 400/month',
                  minDuration: '6 months min',
                  traffic: '30,000 views/day',
                  type: 'Indoor billboard',
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(
          list: widget.list,
        ));
  }
}
