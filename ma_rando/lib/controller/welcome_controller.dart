import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_rando/controller/profile_controller.dart';
import 'package:ma_rando/controller/login_controller.dart';
import 'package:ma_rando/controller/register_controller.dart';
import 'package:ma_rando/views/widgets/profile_page.dart';

import '../views/widgets/rounded_button.dart';

class WelcomeController extends StatefulWidget {
  @override
  _WelcomeControllerState createState() => _WelcomeControllerState();
}

class _WelcomeControllerState extends State<WelcomeController> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  //final _firestore = FirebaseFirestore.instance;
  late var loggedInUser;

  Future<void> getCurrentUser() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print('User is logged - email ${loggedInUser.email}');

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProfilePage()));
      }
    } catch (e) {
      print(e);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => WelcomeController()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 30.0,
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Login',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginController(),
                  ),
                );
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegistrationController(),
                  ),
                );
                //Navigator.pushNamed(context, RegistrationController.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
