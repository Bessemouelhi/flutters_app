import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/controller/welcome_controller.dart';

class ProfileAppBar extends StatelessWidget {
  final user;
  final FirebaseFirestore auth;
  ProfileAppBar({this.user, required this.auth});

  var userData = auth.collection('users').doc(user?.uid).get();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.40,
      pinned: true, // pour fixé en haut
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //image: DecorationImage(image: NetworkImage(user!.photoURL!)),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '{user!.displayName}\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
              TextSpan(
                text: '${user!.email}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            signOut(context);
          },
          icon: Icon(Icons.logout),
        )
      ],
    );
  }

  signOut(BuildContext context) {
    Navigator.of(context).pop;
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => WelcomeController()));
    });*/
    auth.signOut();
  }
}
