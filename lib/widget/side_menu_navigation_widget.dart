import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SideMenuNavigationWidget extends StatelessWidget {

  final Function onTap;

  const SideMenuNavigationWidget(this.onTap);

  @override
  Widget build(BuildContext context) {

    // Future<DocumentSnapshot> getUserData() async {
    //   var currentUser = FirebaseAuth.instance.currentUser;
    //   return FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get();
    // }
    //
    //
    // return FutureBuilder(
    //     builder: builder
    // );

    return Container();
  }
}
