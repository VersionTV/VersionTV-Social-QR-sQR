import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class LabelDetailView extends StatefulWidget {
  final String labelId;
  final String userId;

  LabelDetailView(this.labelId, this.userId);

  @override
  _LabelDetailViewState createState() => _LabelDetailViewState();
}

class _LabelDetailViewState extends State<LabelDetailView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController numaraController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController baslikController = TextEditingController();

  @override
  void dispose() {
    adController.dispose();
    soyadController.dispose();
    numaraController.dispose();
    notController.dispose();
    adresController.dispose();
    baslikController.dispose();
    super.dispose();
  }

  Future<void> _shareQRCode() async {
    try {
      // Generate the QR code image
      final qrPainter = QrPainter(
        data:
            'https://socialqr-d2f3e.web.app?userId=${widget.userId}&labelId=${widget.labelId}',
        version: QrVersions.auto,
        gapless: false,
      );

      // Convert the QR code to an image file
      final picData =
          await qrPainter.toImageData(200, format: ImageByteFormat.png);
      final buffer = picData!.buffer.asUint8List();

      // Save the image to a temporary directory
      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/qr_code.png').writeAsBytes(buffer);

      // Share the image file
      Share.shareFiles([file.path], text: 'sQR Etiketim');
    } catch (e) {
      print('QR code olusturma hatasi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Etiket Detayları")),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore
            .collection('users')
            .doc(widget.userId)
            .collection('labels')
            .doc(widget.labelId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final label = snapshot.data!;

          adController.text = label['Ad'];
          soyadController.text = label['Soyad'];
          numaraController.text = label['Numara'];
          notController.text = label['Not'];
          adresController.text = label['Adres'];
          baslikController.text = label['Baslik'];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: baslikController,
                  decoration: InputDecoration(labelText: "Baslik"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: adController,
                  decoration: InputDecoration(labelText: "Ad"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: soyadController,
                  decoration: InputDecoration(labelText: "Soyad"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: numaraController,
                  decoration: InputDecoration(labelText: "Numara"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: notController,
                  decoration: InputDecoration(labelText: "Not"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: adresController,
                  decoration: InputDecoration(labelText: "Adres"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _firestore
                        .collection('users')
                        .doc(widget.userId)
                        .collection('labels')
                        .doc(widget.labelId)
                        .update({
                      'Baslik': baslikController.text,
                      'Ad': adController.text,
                      'Soyad': soyadController.text,
                      'Numara': numaraController.text,
                      'Not': notController.text,
                      'Adres': adresController.text,
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Güncelle"),
                ),
                SizedBox(height: 10),
                QrImageView(
                  data:
                      'https://socialqr-d2f3e.web.app?userId=${widget.userId}&labelId=${widget.labelId}',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: _shareQRCode,
                  child: Text("Kaydet veya Paylaş"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
