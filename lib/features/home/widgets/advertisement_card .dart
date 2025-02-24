import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';

class AdvertisementCard extends StatelessWidget {
  final int? bottomBarIndex;
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final String minDuration;
  final String traffic;
  final String type;
  AdvertisementCard({
    this.bottomBarIndex,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.minDuration,
    required this.traffic,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.acLocationDetail,
                arguments: bottomBarIndex);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://bienhieudep.vn/wp-content/uploads/2021/06/82-Ph%E1%BB%91-m%E1%BB%9Bi-H%C6%B0ng-y%C3%AAn-1-scaled.jpg',
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 500,
                      color: Palette.inputBackground,
                      child: Center(
                          child:
                              CircularProgressIndicator()), // Hiển thị khi đang tải
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 500,
                      color:
                          Palette.inputBackground, // Nếu lỗi, hiển thị màu nền
                    );
                  },
                ),
              ),
              // Positioned(
              //   top: 8.0,
              //   right: 8.0,
              //   child: CircleAvatar(
              //     backgroundColor: Palette.grayTransparent,
              //     child: Icon(
              //       Icons.favorite_border,
              //       color: Palette.nearlyWhite,
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 16.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Billboard advertising',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16.0,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'Thu Duc, District 2, HCM',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'From 500\$/month\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '1 years min\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              TextSpan(
                                text: 'Traffic: 50.000 views/day\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              TextSpan(
                                text: 'Type: Outdoor billboard',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              child: Column(
                            children: [
                              Text(
                                'View detail',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(Symbols.keyboard_arrow_down)
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
