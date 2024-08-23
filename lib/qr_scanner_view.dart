import 'package:flutter/material.dart';
import 'package:flutter_application_1/scanned_label_detail_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'label_detail_view.dart';

class QrScannerView extends StatefulWidget {
  @override
  _QrScannerViewState createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'SQR Kodu Tarayın',
          style: TextStyle(color: Theme.of(context).textTheme.headline6?.color),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!isScanning) {
        isScanning = true;
        controller.pauseCamera();
        final scannedData = scanData.code;

        if (scannedData != null) {
          Uri uri = Uri.parse(scannedData);

          String? userId = uri.queryParameters['userId'];
          String? labelId = uri.queryParameters['labelId'];

          if (userId != null && labelId != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ScannedLabelDetailView(labelId, userId),
              ),
            );
          } else {
            // Handle the case where userId or labelId is null
            // For example, show an error message
          }
        }
        //isScanning = false;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
