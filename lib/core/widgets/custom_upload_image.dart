import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageUploadOneField extends StatefulWidget {
  final Function(File)? onImageSelected;
  final String? initialImageUrl;

  const ImageUploadOneField({
    Key? key,
    this.onImageSelected,
    this.initialImageUrl,
  }) : super(key: key);

  @override
  _ImageUploadOneFieldState createState() => _ImageUploadOneFieldState();
}

class _ImageUploadOneFieldState extends State<ImageUploadOneField> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  static const String PERMISSION_ASKED_KEY = 'image_permission_asked';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkAndRequestPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool permissionAsked = prefs.getBool(PERMISSION_ASKED_KEY) ?? false;

    if (!permissionAsked) {
      var status = await Permission.photos.request();
      await prefs.setBool(PERMISSION_ASKED_KEY, true);

      if (status.isDenied) {
        // Handle permanent denial
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permission Required'),
              content: const Text(
                  'Please enable photo access in settings to upload images.'),
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    // Proceed with image picking
    _pickImage();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        if (widget.onImageSelected != null) {
          widget.onImageSelected!(_imageFile!);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to pick image')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _checkAndRequestPermission,
      child: DottedBorder(
        color: Palette.grayTransparent, // Màu viền
        strokeWidth: 4, // Độ dày viền
        dashPattern: [8, 4], // Mẫu nét đứt: 8px vẽ, 4px khoảng trống
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: _imageFile != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Palette.white),
                          onPressed: _checkAndRequestPermission,
                        ),
                      ),
                    ),
                  ],
                )
              : widget.initialImageUrl != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.initialImageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: _checkAndRequestPermission,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Symbols.upload_file,
                          size: 40,
                          color: Palette.grayTransparent,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Upload image',
                          style: TextStyle(
                              color: Palette.grayTransparent,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ImageUploadMultipleField extends StatefulWidget {
  final Function(File)? onImageSelected;
  final String? initialImageUrl;

  const ImageUploadMultipleField({
    Key? key,
    this.onImageSelected,
    this.initialImageUrl,
  }) : super(key: key);

  @override
  _ImageUploadMultipleFieldState createState() =>
      _ImageUploadMultipleFieldState();
}

class _ImageUploadMultipleFieldState extends State<ImageUploadMultipleField> {
  List<File> _imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  static const String PERMISSION_ASKED_KEY = 'image_permission_asked';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkAndRequestPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool permissionAsked = prefs.getBool(PERMISSION_ASKED_KEY) ?? false;

    if (!permissionAsked) {
      var status = await Permission.photos.request();
      await prefs.setBool(PERMISSION_ASKED_KEY, true);

      if (status.isDenied) {
        // Handle permanent denial
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permission Required'),
              content: const Text(
                  'Please enable photo access in settings to upload images.'),
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    // Proceed with image picking
    _pickImages();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
        });

        if (widget.onImageSelected != null) {
          for (var file in _imageFiles) {
            widget.onImageSelected!(file);
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to pick images')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _checkAndRequestPermission,
      child: DottedBorder(
        color: Palette.grayTransparent, // Màu viền
        strokeWidth: 4, // Độ dày viền
        dashPattern: [8, 4], // Mẫu nét đứt: 8px vẽ, 4px khoảng trống
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: _imageFiles.isNotEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Hiển thị 3 cột ảnh
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _imageFiles[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imageFiles.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.deactivatedText,
                              ),
                              child: const Icon(Icons.close,
                                  size: 16, color: Palette.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Symbols.upload_file,
                      size: 40,
                      color: Palette.grayTransparent,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Upload images',
                      style: TextStyle(
                          color: Palette.grayTransparent,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
