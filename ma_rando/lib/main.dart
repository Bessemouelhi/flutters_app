import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ma_rando/controller/home_map_controller.dart';
import 'package:ma_rando/controller/weather_controller.dart';
import 'package:ma_rando/models/parcours_list.dart';
import 'package:ma_rando/views/parcours_list_view.dart';
import 'package:ma_rando/views/profile/profile_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Parcours',
      theme: ThemeData(primaryColor: Colors.blue),
      home: NavigationHome(title: 'Home'),
      //home: ParcoursListView(parcoursList: new ParcoursList(1, 'nom')),
    );
  }
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'NavigationBar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NavigationBar Example
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.route),
            label: 'Mes parcours',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.cloudSun),
            label: 'Météo',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        //backgroundColor: Colors.blue,
        //elevation: 10,
        //surfaceTintColor: Colors.lime,
        //height: 20,
        //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      body: <Widget>[
        ProfileNavigator(),
        HomeMapController(),
        ParcoursListView(parcoursList: new ParcoursList(1, 'Mes parcours')),
        WeatherController()
        // Container(
        //   color: Colors.purple,
        //   alignment: Alignment.center,
        //   child: const Text('Purple'),
        // ),
      ][currentPageIndex],
    );
  }
}
