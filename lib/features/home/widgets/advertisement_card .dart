import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:http/http.dart' as http;

class AdvertisementCard extends StatelessWidget {
  final String rentalLocationId;
  final int? bottomBarIndex;
  final String? imageUrl;
  final String title;
  final String location;
  final String price;
  final String minDuration;
  final String traffic;
  final String type;

  // ignore: use_key_in_widget_constructors
  const AdvertisementCard({
    required this.rentalLocationId,
    this.bottomBarIndex,
    this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.minDuration,
    required this.traffic,
    required this.type,
  });

  // Check if URL is reachable
  Future<bool> _isImageUrlValid() async {
    if (imageUrl == null || imageUrl!.isEmpty) return false;

    try {
      // Try a HEAD request to check if resource exists
      final response = await http
          .head(Uri.parse(imageUrl!))
          .timeout(const Duration(seconds: 5));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint("Image URL validation error: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.acLocationDetail,
                arguments: rentalLocationId);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FutureBuilder<bool>(
                  future: imageUrl != null && imageUrl!.isNotEmpty
                      ? _isImageUrlValid()
                      : Future.value(false),
                  builder: (context, snapshot) {
                    // If URL check is in progress, show loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: double.infinity,
                        height: 500,
                        color: Palette.inputBackground,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    // If URL is valid, try to load the image
                    if (snapshot.hasData && snapshot.data == true) {
                      return Image.network(
                        imageUrl!,
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
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(context);
                        },
                      );
                    } else {
                      // If URL is invalid or empty, show placeholder
                      return _buildPlaceholder(context);
                    }
                  },
                ),
              ),
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
                          title,
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
                              location,
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
                                text: 'From ${price}\$/month\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${minDuration} years min\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              TextSpan(
                                text: '${traffic}\n',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              TextSpan(
                                text: '${type}',
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

  // Helper method to build placeholder
  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Palette.inputBackground,
      child: Image.asset("lib\\assets\\Image-not-found.png"),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Icon(
      //       Symbols.broken_image_rounded,
      //       fill: 1,
      //       color: Palette.dismissibleBackground,
      //       size: 80,
      //     ),
      //     SizedBox(height: 12),
      //     Text(
      //       "Image not available",
      //       style: TextStyle(
      //         color: Palette.grey,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w500,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
