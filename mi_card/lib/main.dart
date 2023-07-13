import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              Text(
                'Bessem Mouelhi',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade200,
                ),
              ),
              SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+33 6 12 34 56 78',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'bessem.mouelhi@flutter.com',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Card(
              //   child: Column(
              //     children: [
              //       ListTile(
              //         title: const Text(
              //           '1625 Main Street',
              //           style: TextStyle(fontWeight: FontWeight.w500),
              //         ),
              //         subtitle: const Text('My City, CA 99984'),
              //         leading: Icon(
              //           Icons.restaurant_menu,
              //           color: Colors.blue[500],
              //         ),
              //       ),
              //       const Divider(),
              //       ListTile(
              //         title: const Text(
              //           '(408) 555-1212',
              //           style: TextStyle(fontWeight: FontWeight.w500),
              //         ),
              //         leading: Icon(
              //           Icons.contact_phone,
              //           color: Colors.blue[500],
              //         ),
              //       ),
              //       ListTile(
              //         title: const Text('costa@example.com'),
              //         leading: Icon(
              //           Icons.contact_mail,
              //           color: Colors.blue[500],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
