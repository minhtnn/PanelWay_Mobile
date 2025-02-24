import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/features/home/view_models/rental_location_viewmodel.dart';
import 'package:panelway_mobile/features/home/widgets/advertisement_card%20.dart';
import 'package:panelway_mobile/features/home/widgets/icon_navigation.dart';
import 'package:provider/provider.dart';

class ACHomeMain extends StatefulWidget {
  final int bottomBarIndex;
  const ACHomeMain({super.key, required this.bottomBarIndex});

  @override
  State<ACHomeMain> createState() => _ACHomeMainState();
}

class _ACHomeMainState extends State<ACHomeMain> {
  void initState() {
    super.initState();
    fetchData(); // Gọi API khi widget khởi tạo
  }

  void fetchData() async {
    // print("Fetching data..."); // Kiểm tra fetchData có chạy không
    // final rentalLocationViewModel =
    //     Provider.of<RentalLocationViewmodel>(context, listen: false);
    // var result = await rentalLocationViewModel.getRentalLocationPaging();
    // print("🎯 Fetching complete: $result"); // Kiểm tra kết quả trả về
  }

  @override
  Widget build(BuildContext context) {
    final rentalLocationViewModel =
        Provider.of<RentalLocationViewmodel>(context);
    rentalLocationViewModel.getRentalLocationPaging();
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: ListView(
          padding:
              EdgeInsets.only(top: 20, left: 30.0, right: 30.0, bottom: 80.0),
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
                        color: Palette.grey,
                        iconData: Symbols.notifications_none,
                        iconWeight: 400,
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, AppRoutes.bottombar,
                              arguments: BottomBarPage.notifications.index);
                        }),
                    const SizedBox(width: 15),
                    CircleIconNavigation(
                        color: Palette.grey,
                        iconData: Symbols.map,
                        iconWeight: 400,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.acMap,
                              arguments: widget.bottomBarIndex);
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Symbols.search,
                                  color: Palette.grayTransparent),
                              hintText: 'Search for...',
                              hintStyle:
                                  TextStyle(color: Palette.grayTransparent),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide: BorderSide(
                                  color: Palette.chipBackground,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide: BorderSide(
                                  color: Palette.chipBackground,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide: BorderSide(
                                  color: Palette.blueButton,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(16),
                            child: Icon(
                              Symbols.add,
                              color: Palette.white,
                              weight: 700,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.blueButton,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.uploadContent);
                            // Navigator.pushNamed(context, AppRoutes.uploadSpace);
                          },
                        ),
                      ],
                    )),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
