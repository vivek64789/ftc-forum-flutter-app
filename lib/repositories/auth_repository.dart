import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ftc_forum/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class AuthRepository {
  final firebase_auth.FirebaseAuth? _firebaseAuth;
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth!.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String dob,
  }) async {
    try {
      await _firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        updateUserData(
            name: name,
            phone: phone,
            dob: dob,
            uid: value.user!.uid,
            email: email);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserData({
    required String uid,
    required String name,
    required String phone,
    required String dob,
    required String email,
    String role = "user",
  }) async {
    await _firestore.collection("users").doc(uid).set({
      "uid": uid,
      "name": name,
      "phone": phone,
      "dob": dob,
      "role": role,
      "email": email,
      'photo':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png"
    });
  }

  Future<firebase_auth.UserCredential> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    late firebase_auth.UserCredential userCredential;
    try {
      userCredential = await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
    return userCredential;
  }

  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth!.signOut()]);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getIsAdmin(String uid) async {
    bool isAdmin = false;
    final response = await _firestore.collection("users").doc(uid).get();
    if (response.exists) {
      Map<String, dynamic>? data = response.data();
      var role = data?['role'];
      if (role == "admin") {
        isAdmin = true;
      }
    }
    return isAdmin;
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photo: photoURL);
  }
}
