import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  void register(String email, String password, String username) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
      'username': username,
      'email': email
    });
  }

  void login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
