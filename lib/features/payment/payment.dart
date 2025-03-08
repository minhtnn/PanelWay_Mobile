import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  final String qrCodeData; // Dữ liệu mã QR từ PayOS

  QRCodeScreen({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Payment')),
      body: Center(
        child: QrImageView(
          data: qrCodeData,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
