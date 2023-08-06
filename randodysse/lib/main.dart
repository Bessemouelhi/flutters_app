import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:randodysse/Wrapper.dart';
import 'package:randodysse/servives/authentication.dart';
import 'package:randodysse/views/login_page.dart';
import 'package:randodysse/views/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      StreamProvider.value(value: AuthService().user, initialData: null)
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randodysse',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
