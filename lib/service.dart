import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumenden/tab_subwidgets/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

String serviceMessage = "";

class FirebaseCostumeAuthServices {
  static String serviceMessages = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//giriş yap

  Future signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()))})
        .catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hata: $e"),
        ),
      );
      log("Hata: $e");
    });
    return null;
  }

//çıkış yap

  signOut() async {
    return await _auth.signOut();
  }

// mail ile kayıt ol ve ek bilgi girme

  Future createEmailAndPassword(BuildContext context, String email, password, name, phone, adress, isAdmin, profileImage) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        await postUserField(email, password, name, profileImage);
      });
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case "invalid-email":
          print("Not a valid email address.");
          break;
        default:
          print("Unknown error. ${exception.toString()}");
      }
    }
  }

  postUserField(String email, password, name, profileImage) async {
    User? user = _auth.currentUser;

    await _firestore.collection("userDocs").doc(user?.uid).set(
      {
        "email": email,
        "password": password,
        "name": name,
        "profileImage": profileImage,
      },
    ).then((value) => {});
  }
}
