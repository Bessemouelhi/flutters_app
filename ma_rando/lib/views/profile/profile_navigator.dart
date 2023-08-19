import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/views/profile/auth.dart';
import 'package:ma_rando/views/profile/splash_screen.dart';
import 'package:ma_rando/views/widgets/profile_page.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            /*final userData = FirebaseFirestore.instance
                .collection('users')
                .doc(_user?.uid)
                .get();*/
            return ProfilePage(loggedInUser: FirebaseAuth.instance);
          }

          return const AuthPage();
        },
      ),
    );
  }
}
