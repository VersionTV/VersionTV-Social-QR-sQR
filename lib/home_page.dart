import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/aboutus.dart';
import 'package:flutter_application_1/account_screen.dart';
import 'package:flutter_application_1/chats_screen.dart';
import 'package:flutter_application_1/help.dart';
import 'package:flutter_application_1/home_view.dart';
import 'package:flutter_application_1/label_detail_view.dart';
import 'package:flutter_application_1/qr_scanner_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _firestore
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text('User data not found'),
                );
              }

              final userName = snapshot.data!['name'];

              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Burada arka plan rengini temadan alıyoruz
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        title: Text(
                          'Merhaba $userName!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Kaybolmasından korktuğun eşyaların bizimle güvende',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white54),
                        ),
                        trailing: const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(200)),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(
                      'sQR Etiketlerim', CupertinoIcons.tag_solid, Colors.teal,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ),
                    );
                    print('QR kod oluştur tıklandı');
                  }),
                  itemDashboard(
                      'sQR Tara', CupertinoIcons.qrcode, Colors.pinkAccent, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QrScannerView()),
                    );
                    print('QR okut tıklandı');
                  }),
                  /*   itemDashboard('Profil', CupertinoIcons.person, Colors.orange,
                      () {
                    print('Profil tıklandı');
                  }),
                  */
                  itemDashboard(
                      'Mesaj', CupertinoIcons.chat_bubble_2, Colors.brown, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                    print('Mesaj tıklandı');
                  }),
                  itemDashboard('Ayarlar', CupertinoIcons.settings, Colors.grey,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AccountScreen()),
                    );
                    print('Ayarlar tıklandı');
                  }),
                  itemDashboard(
                      'Yardım', CupertinoIcons.heart_circle, Colors.red, () {
                    print('Yardım tıklandı');
                     Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HelpScreen()),
                    );
                  }),
                  itemDashboard(
                      'Hakkımızda', CupertinoIcons.question_circle, Colors.blue,
                      () {
                    print('Hakkımızda tıklandı');
                     Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AboutUS()),
                    );

                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, IconData iconData, Color background, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface, // Arka plan rengi temadan alınır
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
