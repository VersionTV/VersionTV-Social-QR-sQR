import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat_view.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScannedLabelDetailView extends StatelessWidget {
  final String labelId;
  final String userId;
  ScannedLabelDetailView(this.labelId, this.userId);
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController numaraController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController baslikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Etiket Detaylari")),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore
            .collection('users')
            .doc(userId)
            .collection('labels')
            .doc(labelId)
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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EtiketCard(
                  adController: adController,
                  soyadController: soyadController,
                  numaraController: numaraController,
                  notController: notController,
                  adresController: adresController,
                  baslikController: baslikController,
                  userId: userId,
                ),
                SizedBox(height: 20),
                
                
              ],
            ),
          );
        },
      ),
    );
  }
}

class EtiketCard extends StatelessWidget {
  final TextEditingController adController;
  final TextEditingController soyadController;
  final TextEditingController numaraController;
  final TextEditingController notController;
  final TextEditingController adresController;
  final TextEditingController baslikController;
  final String userId;

  EtiketCard({
    required this.adController,
    required this.soyadController,
    required this.numaraController,
    required this.notController,
    required this.adresController,
    required this.baslikController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Color(0xFF00B4FF),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${baslikController.text}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 46.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Sahibinin adı: ${adController.text}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Soyad: ${soyadController.text}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: numaraController,
              decoration: InputDecoration(                            
    filled: true,
    fillColor: const Color.fromARGB(255, 255, 255, 255),
    border: OutlineInputBorder(     
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
  ),              
            ),
            SizedBox(height: 8.0),
            Text(
              "Not: ${notController.text}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Adres: ${adresController.text}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                
              ),
            ),
            ElevatedButton(onPressed: () async {
              
            final _authService = Provider.of<AuthService>(context,listen:false);
            await _authService.addContact(userId);
            
            
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatView(
              receiverName:"Yeni Mesaj Gönder",receiverID:userId
              
            ),));
          
            
            
            }, 
            child: Text("Mesaj Gönder"))
          ],
        ),
      ),
    );
      
  }
}
