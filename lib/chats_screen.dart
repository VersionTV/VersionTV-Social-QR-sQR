import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat_view.dart';
import 'package:flutter_application_1/services/chat_service.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final ChatService _chatService = ChatService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sohbetler',
          style: TextStyle(color: Theme.of(context).textTheme.headline6?.color),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: authService.getUserDocumentStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Hiçbir kişiye mesaj göndermediniz.'));
          }

          List<dynamic> friendList = snapshot.data!['friendlist'];

          return ListView.builder(
            itemCount: friendList.length,
            itemBuilder: (context, index) {
              String friendUid = friendList[index];
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(friendUid)
                    .get(),
                builder: (context, friendSnapshot) {
                  if (friendSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (friendSnapshot.hasError) {
                    return Center(child: Text('Hata'));
                  } else if (!friendSnapshot.hasData ||
                      !friendSnapshot.data!.exists) {
                    return Center(child: Text('Kullanıcı bulunamadı'));
                  }

                  String friendName = friendSnapshot.data!['name'];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatView(
                              receiverName: friendName,
                              receiverID: friendUid,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          friendName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
