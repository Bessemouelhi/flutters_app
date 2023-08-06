import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randodysse/views/profile_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    if (_user == null) Navigator.pushNamed(context, '/');
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
              user: _user,
            )
          ],
        ),
      ),
    );
  }
}
