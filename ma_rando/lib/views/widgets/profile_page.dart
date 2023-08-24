import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ma_rando/controller/welcome_controller.dart';
import 'package:ma_rando/utilities/utils.dart';
import 'package:ma_rando/views/widgets/profile_app_bar.dart';

import '../profile/user_image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _username;
  var _email;
  var _password;
  File? _userImage;

  signOut(BuildContext context) {
    Navigator.of(context).pop;
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitDoubleBounce(
                  color: Colors.blue,
                );
              }
              var userDoc = snapshot.data;
              _username = userDoc?["username"];
              _email = userDoc?["email"];
              _usernameController.text = _username;
              _emailController.text = _email;
              //_userImage = userDoc?["image_url"];
              return SafeArea(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userDoc?["image_url"]),
                    ),
                    Text(
                      _username,
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.teal,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _email,
                            style: const TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        openEditDialog();
                      },
                      child: const Text('Editer le profil'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: const Text('Deconnexion'),
                    )
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

  Future openEditDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edition du profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserImagePicker(
                  onPickImage: (pickedImage) {
                    _userImage = pickedImage;
                  },
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  onSubmitted: (value) {
                    print(value);
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  print("Username: ${_usernameController.text}");
                  print("Email: ${_emailController.text}");
                  print("Password: ${_passwordController.text}");
                  print("User Image Path: ${_userImage?.path}");

                  if (_passwordController.text == null) return;

                  final userDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_currentUser!.uid);

                  try {
                    await _currentUser?.reauthenticateWithCredential(
                      EmailAuthProvider.credential(
                        email: _currentUser!.email!,
                        password: _passwordController.text,
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    print('e.code : $e.code');
                  }

                  userDoc.update({
                    'username': _usernameController.text,
                    'email': _emailController.text
                  });
                  //userDoc.update({'email': _emailController.text});
                  if (_userImage != null) {
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child('user_images')
                        .child('${_currentUser!.uid}.jpg');

                    await storageRef.putFile(_userImage!);
                    final imageUrl = await storageRef.getDownloadURL();
                    userDoc.update({'image_url': imageUrl});
                  }
                  _currentUser?.updateEmail(_emailController.text);

                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Text('Envoyer'))
          ],
        ),
      );
}
