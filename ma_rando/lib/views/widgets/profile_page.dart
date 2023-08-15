import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/controller/welcome_controller.dart';
import 'package:ma_rando/views/widgets/profile_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final _auth;
  const ProfilePage({super.key, required dynamic loggedInUser})
      : _auth = loggedInUser;

  @override
  Widget build(BuildContext context) {
    final _user = _auth.currentUser;
    var _userData;

    getUserdata() async {
      _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user?.uid)
          .get();
    }

    /*Future<void> getCurrentUser() async {
      final user = _auth.currentUser;
      try {
        if (user != null) {
          loggedInUser = user;
          print('loggedInUser.email ${loggedInUser.email}');
        }
      } catch (e) {
        print(e);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => WelcomeController()));
      }
    }*/

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
              user: _user,
              auth: _auth,
            )
          ],
        ),
      ),
    );
  }
}
