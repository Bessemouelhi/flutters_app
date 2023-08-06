import 'package:flutter/material.dart';
import 'package:randodysse/servives/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage('images/hiking-hero.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Text(
                'Randodysse',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Découvrez et partagez vos parcours préférés',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              inLoginProcess
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        signIn();
                        print('Connectez-vous avec Google');
                      },
                      child: Text('Connectez-vous avec Google'))
            ],
          ),
        ),
      ),
    );
  }

  signIn() {
    setState(() {
      inLoginProcess = true; // en cours de chargement (true)
      AuthService().signInWithGoogle();
    });
  }
}
