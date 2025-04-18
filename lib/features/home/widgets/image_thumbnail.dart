import 'package:flutter/material.dart';
import 'package:panelway_mobile/data/models/rental_location_image.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class ImageThumbnail extends StatelessWidget {
  final List<RentalLocationImage> rentalLocationImages;

  const ImageThumbnail({Key? key, required this.rentalLocationImages})
      : super(key: key);

  // Convert various image URL formats to direct image URLs
  String _getDirectImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    
    // Case 1: Regular direct image URLs
    if (url.toLowerCase().endsWith('.jpg') || 
        url.toLowerCase().endsWith('.jpeg') || 
        url.toLowerCase().endsWith('.png') || 
        url.toLowerCase().endsWith('.gif') ||
        url.toLowerCase().endsWith('.webp')) {
      return url; // Already a direct image URL
    }
    
    // Case 2: Google Drive link format: drive.google.com/file/d/ID/view
    if (url.contains('drive.google.com/file/d/')) {
      // Extract the file ID from the URL
      final RegExp regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
      final match = regExp.firstMatch(url);
      
      if (match != null && match.groupCount >= 1) {
        final String fileId = match.group(1)!;
        // Return direct download URL
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
    }
    
    // Case 3: Alternative Google Drive link format: drive.google.com/open?id=ID
    if (url.contains('drive.google.com/open?id=')) {
      final Uri uri = Uri.parse(url);
      final String? fileId = uri.queryParameters['id'];
      
      if (fileId != null) {
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
    }
    
    // Return original URL if it doesn't match any known pattern
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImagesPopup(context);
      },
      child: Container(
        width: 100,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.dismissibleBackground,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: rentalLocationImages.isNotEmpty
                  ? _buildNetworkImageWithFallback(
                      rentalLocationImages[0].imageUrl ?? '',
                      withDarkOverlay: true,
                    )
                  : Container(color: Colors.grey[300]),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  '+${rentalLocationImages.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Modified method to handle network image with fallback and URL conversion
  Widget _buildNetworkImageWithFallback(String url, {bool withDarkOverlay = false}) {
    // Convert URL to direct image URL if needed
    final String directUrl = _getDirectImageUrl(url);
    
    Widget imageWidget = Image.network(
      directUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[600],
            size: 30,
          ),
        );
      },
    );
    
    if (withDarkOverlay) {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
        child: imageWidget,
      );
    }
    
    return imageWidget;
  }

  // Show popup with image list
  void _showImagesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Images (${rentalLocationImages.length})",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: rentalLocationImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the popup
                          _showFullImage(context, index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildNetworkImageWithFallback(
                              rentalLocationImages[index].imageUrl ?? '',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show full image view
  void _showFullImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullImageView(
          rentalLocationImages: rentalLocationImages,
          initialIndex: initialIndex,
          getDirectImageUrl: _getDirectImageUrl, // Pass the URL conversion function
        ),
      ),
    );
  }
}

// Modified FullImageView with URL conversion support
class FullImageView extends StatefulWidget {
  final List<RentalLocationImage> rentalLocationImages;
  final int initialIndex;
  final String Function(String?) getDirectImageUrl; // Function to convert URLs

  const FullImageView({
    Key? key,
    required this.rentalLocationImages,
    required this.initialIndex,
    required this.getDirectImageUrl,
  }) : super(key: key);

  @override
  _FullImageViewState createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.rentalLocationImages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          // Convert URL to direct image URL
          final String directUrl = widget.getDirectImageUrl(
              widget.rentalLocationImages[index].imageUrl);
              
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            child: Center(
              child: Image.network(
                directUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Image not available",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black54,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_currentIndex + 1}/${widget.rentalLocationImages.length}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}