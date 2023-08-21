import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ma_rando/controller/welcome_controller.dart';
import 'package:ma_rando/views/widgets/profile_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitDoubleBounce(
                  color: Colors.blue,
                );
              }
              var userDoc = snapshot.data;
              return SafeArea(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userDoc?["image_url"]),
                    ),
                    Text(
                      userDoc?["username"],
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                            userDoc?["email"],
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
              );
            }));
  }
}
