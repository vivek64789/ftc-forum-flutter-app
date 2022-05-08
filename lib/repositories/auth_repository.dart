import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ftc_forum/models/models.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth? _firebaseAuth;

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
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
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
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photo: photoURL);
  }
}
