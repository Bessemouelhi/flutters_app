import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/controller/welcome_controller.dart';
import 'package:ma_rando/views/widgets/profile_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final loggedInUser;
  const ProfilePage({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    //final _firestore = FirebaseFirestore.instance;

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
              user: user,
              auth: _auth,
            )
          ],
        ),
      ),
    );
  }
}
