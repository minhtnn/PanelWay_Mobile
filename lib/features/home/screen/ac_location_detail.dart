import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/features/home/view_models/rental_location_viewmodel.dart';
import 'package:panelway_mobile/features/home/widgets/MapCustom/build_map.dart';
import 'package:panelway_mobile/features/home/widgets/contact_info.dart';
import 'package:panelway_mobile/features/home/widgets/detail_description.dart';
import 'package:panelway_mobile/features/home/widgets/detail_item.dart';
import 'package:panelway_mobile/features/home/widgets/image_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ACLocationDetail extends StatefulWidget {
  final int? bottomBarIndex;
  final String? rentalLocationId;
  const ACLocationDetail(
      {super.key, this.bottomBarIndex, this.rentalLocationId});

  @override
  State<ACLocationDetail> createState() => _ACLocationDetailState();
}

class _ACLocationDetailState extends State<ACLocationDetail> {
  String? rentalLocationId;
  late RentalLocationViewmodel viewModel;
  RentalLocation? rentalLocation;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    // Delay loading until after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rentalLocationId = widget.rentalLocationId;
      if (rentalLocationId != null && rentalLocationId!.isNotEmpty) {
        viewModel =
            Provider.of<RentalLocationViewmodel>(context, listen: false);
        _loadRentalLocationData();
      } else {
        setState(() {
          errorMessage = "Invalid rental location ID";
          isLoading = false;
        });
      }
    });
  }

  // Remove didChangeDependencies to avoid duplication of data loading

  Future<void> _loadRentalLocationData() async {
    if (rentalLocationId == null) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await viewModel.getRentalLocationById(rentalLocationId!);

      setState(() {
        rentalLocation = data;
        isLoading = false;
        if (data == null) {
          errorMessage = "Location not found";
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<bool> _isImageUrlValid(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return false;

    try {
      // Try a HEAD request to check if resource exists
      final response = await http
          .head(Uri.parse(imageUrl))
          .timeout(const Duration(seconds: 5));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint("Image URL validation error: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 30, left: 18.0, right: 18.0, bottom: 20),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : rentalLocation != null
                    ? _buildLocationDetail()
                    : Center(child: Text('No location data available')),
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

  Widget _buildLocationDetail() {
    // Safe way to extract the price, with null checks and defaults
    String priceStr = '';
    if (rentalLocation?.price != null) {
      double price = double.tryParse(rentalLocation!.price!) ?? 0;
      double value = price / 1000000;
      priceStr =
          value % 1 == 0 ? '${value.toInt()}M' : '${value.toStringAsFixed(1)}M';
    }

    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FutureBuilder<bool>(
                future: rentalLocation != null &&
                        rentalLocation!.rentalLocationImages != null &&
                        rentalLocation!.rentalLocationImages!.isNotEmpty &&
                        rentalLocation!.rentalLocationImages![0].imageUrl !=
                            null &&
                        rentalLocation!
                            .rentalLocationImages![0].imageUrl!.isNotEmpty
                    ? _isImageUrlValid(
                        rentalLocation!.rentalLocationImages![0].imageUrl!)
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
                    return ImageFiltered(
                      imageFilter:
                          ImageFilter.blur(sigmaX: 0, sigmaY: 0), // No blur
                      child: Opacity(
                        opacity:
                            0.7, // Adjust this value for overall transparency (0.0-1.0)
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(
                                0.3), // Increase this for darker overlay (try 0.7)
                            BlendMode
                                .darken, // You can also try other modes like multiply
                          ),
                          child: Image.network(
                            rentalLocation!.rentalLocationImages![0].imageUrl!,
                            width: double.infinity,
                            height: 350,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: double.infinity,
                                height: 350,
                                color: Palette.inputBackground,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholder(context);
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    // If URL is invalid or empty, show placeholder
                    return _buildPlaceholder(context);
                  }
                },
              ),
            ),
            BackButtonCustomPosition(
              context: context,
              backToRoute: AppRoutes.bottombar,
              topSide: 10,
              leftSide: 10,
              previousPage: widget.bottomBarIndex,
            ),
            Positioned(
              top: 270,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rentalLocation?.code ?? "No title",
                    style: TextStyle(
                        color: Palette.lightText,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    rentalLocation?.address ?? "No address",
                    style: TextStyle(
                        color: Palette.lightText,
                        fontSize: 18,
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
                  DetailItem(label: 'Price', value: priceStr),
                  DetailItem(
                      label: 'Size',
                      value: '${rentalLocation?.panelSize ?? "N/A"}m²'),
                  DetailItem(label: 'Height', value: '10m'),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DetailDescription(
                      title: "Location",
                      description: "${rentalLocation?.address ?? "N/A"}"),
                  DetailDescription(
                      title: "Rent time",
                      description:
                          "at least ${rentalLocation?.code ?? "N/A"} months."),
                  DetailDescription(
                      title: "Audience type",
                      description: "Commuters, Local Residents."),
                  DetailDescription(
                      title: "Available date",
                      description:
                          "${rentalLocation?.availableDate?.split("T")[0] ?? "N/A"}"),
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
                  if (rentalLocation?.rentalLocationImages != null) ...[
                    ImageThumbnail(
                        rentalLocationImages:
                            rentalLocation!.rentalLocationImages!),
                    ImageThumbnail(
                        rentalLocationImages:
                            rentalLocation!.rentalLocationImages!),
                    ImageThumbnail(
                        rentalLocationImages:
                            rentalLocation!.rentalLocationImages!),
                  ] else ...[
                    // Placeholder for images if not available
                    Container(width: 100, height: 100, color: Colors.grey),
                    Container(width: 100, height: 100, color: Colors.grey),
                    Container(width: 100, height: 100, color: Colors.grey),
                  ],
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
                child: Center(
                    child: BuildMap(
                  latitude: double.tryParse(rentalLocation!.locationX??"10") ?? null,
                  longitude: double.tryParse(rentalLocation!.locationY??"10") ?? null,
                )),
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
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Palette.inputBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Symbols.broken_image_rounded,
            fill: 1,
            color: Palette.dismissibleBackground,
            size: 80,
          ),
          SizedBox(height: 12),
          Text(
            "Image not available",
            style: TextStyle(
              color: Palette.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
