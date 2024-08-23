import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateLabelView extends StatelessWidget {
  final String userId;
  CreateLabelView(this.userId);

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController numaraController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController baslikController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Etiket Oluştur")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            TextField(
              controller: baslikController,
              decoration: InputDecoration(
                labelText: "Baslik",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
                final docRef = await _firestore
                    .collection('users')
                    .doc(userId)
                    .collection('labels')
                    .add({
                  'Baslik': baslikController.text,
                  'Ad': adController.text,
                  'Soyad': soyadController.text,
                  'Numara': numaraController.text,
                  'Not': notController.text,
                  'Adres': adresController.text,
                });
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
