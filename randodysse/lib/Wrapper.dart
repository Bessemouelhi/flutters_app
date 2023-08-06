import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randodysse/views/home_page.dart';
import 'package:randodysse/views/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    if (_user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
