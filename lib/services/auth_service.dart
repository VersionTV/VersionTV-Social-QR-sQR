import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // Kullanıcı oluşturulduktan sonra Firestore'a kullanıcı bilgilerini kaydet
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid, // UID ekleniyor
          'name': name,
          'email': email,
          'friendlist': [] 
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addContact(String uid) async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentReference friendDoc = _firestore.collection('users').doc(uid);

      // Firestore kullanıcı belgesindeki friendlist alanını güncelle
      await userDoc.update({
        'friendlist': FieldValue.arrayUnion([uid])
      });
       // Firestore'da eklenen kullanıcının friendlist alanını da güncelle
      await friendDoc.update({
        'friendlist': FieldValue.arrayUnion([user.uid])
      });
    }
  }
  Stream<DocumentSnapshot> getUserDocumentStream() {
    User? user = _auth.currentUser;

    if (user != null) {
      return _firestore.collection('users').doc(user.uid).snapshots();
    } else {
      throw Exception("No user logged in");
    }
  }
  Future<void> updateUserName(String newName) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).update({'name': newName});
        notifyListeners();
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception("No user logged in");
    }
  }

}
