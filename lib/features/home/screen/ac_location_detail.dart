
import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/features/home/widgets/contact_info.dart';
import 'package:panelway_mobile/features/home/widgets/detail_item.dart';

class ACLocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billboard Advertising'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
             Navigator.pushReplacementNamed(context, AppRoutes.acHomeMain);
          },
        ),
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blueGrey,
            ),
            // Image.network(
            //   'https://example.com/billboard_image.jpg',
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   height: 200,
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billboard Advertising',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('123 Nguyen Van Linh, Ward 5, District 9, HCM'),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DetailItem(label: 'Price', value: '436\$/month'),
                      DetailItem(label: 'Size', value: '100m²'),
                      DetailItem(label: 'Height', value: '10m'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Location: 123 Nguyen Van Linh, Ward 5, District 9, HCM\n'
                    'Rent time: at least 4 months\n'
                    'Estimated Traffic: 60,000 views/day\n'
                    'Audience Type: Commuters, Local Residents\n'
                    'Type: Outdoor billboard',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Detailed Images',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageThumbnail(),
                      ImageThumbnail(),
                      ImageThumbnail(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'View on Map',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Map Placeholder')),
                  ),
                  SizedBox(height: 16),
                  ContactInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.acBookingAppointment);
            },
            child: Text(
              'Book now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Palette.lightText,
              ),),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Palette.blueButton
            ),
          ),
        ),
      ),
    );
  }
}