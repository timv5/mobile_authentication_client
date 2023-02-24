import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideMenuNavigationWidget extends StatelessWidget {

  final Function onTap;

  const SideMenuNavigationWidget(this.onTap);

  void _logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    Future<DocumentSnapshot> getUserData() async {
      var currentUser = FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get();
    }


    return FutureBuilder(
      future: getUserData(),
      builder: (ctx, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(height: 5,),
                        Text(
                          "${userData['username']}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white,),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                          "${userData['email']}",
                          style: const TextStyle(color: Colors.white, fontSize: 12,),
                        )
                      ],
                    ),
                  )
                ),
                ListTile(
                  leading: const Icon(Icons.currency_bitcoin),
                  title: Text(AppLocalizations.of(context).cryptoMarket),
                  onTap: ()=>onTap(0),
                ),
                ListTile(
                  leading: const Icon(Icons.money),
                  title: Text(AppLocalizations.of(context).stocksMarket),
                  onTap: ()=>onTap(1),
                ),
                ListTile(
                  leading: const Icon(Icons.money),
                  title: Text(AppLocalizations.of(context).news),
                  onTap: ()=>onTap(2),
                ),
                ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(AppLocalizations.of(context).stockNotes),
                  onTap: ()=>onTap(3),
                ),
                Divider(color: Theme.of(context).dividerColor,),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context).logout),
                  onTap: ()=>_logout(),
                ),
              ],
            ),
          ),
        );
      },
    );
    return Container();
  }
}
