import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
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
        body: Align(
          alignment: Alignment.center,
          child: ListView(
            padding: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleIconNavigation(
                          iconData: Icons.notifications_none_rounded,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notification);
                          }),
                      const SizedBox(width: 15),
                      CircleIconNavigation(
                          iconData: Icons.grid_view_outlined,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.acMap);
                          }),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Text("location"),
                            top: 5,
                            right: 5,
                          ),
                          Positioned(
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 16,
                            ),
                            top: 30,
                            right: 0,
                          ),
                          DropdownButton(
                            padding: EdgeInsets.only(right: 20, top: 16),
                            icon: const SizedBox(),
                            underline: const SizedBox(),
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
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.tune, color: Colors.white),
                              onPressed: () {
                                // Add filter action here
                              },
                            ),
                          ),
                        ),
                        hintText: 'Search for...',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Search for...',
                  //     prefixIcon: Icon(Icons.search),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     suffixIcon: GestureDetector(
                  //       child: Container(
                  //         child: Icon(Icons.settings ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
        ),
        bottomNavigationBar: BottomBarWidget(
          list: widget.list,
        ));
  }
}
