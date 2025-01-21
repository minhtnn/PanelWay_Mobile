import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/features/home/widgets/contact_info.dart';
import 'package:panelway_mobile/features/home/widgets/detail_description.dart';
import 'package:panelway_mobile/features/home/widgets/detail_item.dart';

class ACLocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 18.0, right: 18.0, bottom: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(18)),
                ),
                BackButtonCustom(
                  context: context,
                  backToRoute: AppRoutes.acHomeMain,
                  topSide: 10,
                  leftSide: 10,
                ),
                Positioned(
                  top: 275,
                  right: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Billboard advertising",
                        style: TextStyle(
                            color: Palette.lightText,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "123 Nguyen Van Tang, Ward 5, District 9, HCM",
                        style: TextStyle(
                            color: Palette.lightText,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Detail',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailItem(label: 'Price', value: '436\$/month'),
                      DetailItem(label: 'Size', value: '100m²'),
                      DetailItem(label: 'Height', value: '10m'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailDescription(
                          title: "Location",
                          description:
                              "123 Nguyen Van Linh, Ward 5, District 9, HCM."),
                      DetailDescription(
                          title: "Rent time",
                          description: "at least 4 months."),
                      DetailDescription(
                          title: "Estimated traffic",
                          description: "60,000 views/day."),
                      DetailDescription(
                          title: "Audience type",
                          description: "Commuters, Local Residents."),
                      DetailDescription(
                          title: "Type",
                          description:
                              "123 Nguyen Van Linh, Ward 5, District 9, HCM."),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Detailed Images',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageThumbnail(),
                      ImageThumbnail(),
                      ImageThumbnail(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'View on Map',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: Center(child: Text('Map Placeholder')),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(height: 16),
                  ContactInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(
            functionName: "Book now",
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.acBookingAppointment);
            },
            buttonBackgroundColor: Palette.blueButton,
            textColor: Palette.lightText),
      ),
    );
  }
}
