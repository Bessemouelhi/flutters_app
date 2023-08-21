import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/controller/welcome_controller.dart';

import '../views/widgets/profile_page.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user == null) {
      return WelcomeController();
    } else {
      return ProfilePage();
    }
  }
}
