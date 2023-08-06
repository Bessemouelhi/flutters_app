import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  final User? user;
  const HomeAppBar({this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Randodysse'),
      backgroundColor: Colors.green,
      elevation: 0.8,
      floating: true,
      forceElevated: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (user != null)
                Navigator.pushNamed(context, '/profile');
              else
                Navigator.pushNamed(context, '/');
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
          ),
        )
      ],
    );
  }
}
