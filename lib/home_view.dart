import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_label_view.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'label_detail_view.dart';
import 'qr_scanner_view.dart';

class HomeView extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Etiketlerim"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QrScannerView()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(user.uid)
            .collection('labels')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final labels = snapshot.data!.docs;

          return ListView.builder(
            itemCount: labels.length,
            itemBuilder: (context, index) {
              final label = labels[index];

              return ListTile(
                tileColor: Theme.of(context)
                    .colorScheme
                    .surface, // Arka plan rengi temadan alınıyor
                title: Text(
                  label['Baslik'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  label['Ad'],
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete,
                      color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () {
                    _firestore
                        .collection('users')
                        .doc(user.uid)
                        .collection('labels')
                        .doc(label.id)
                        .delete();
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LabelDetailView(label.id, user.uid),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateLabelView(user.uid),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
