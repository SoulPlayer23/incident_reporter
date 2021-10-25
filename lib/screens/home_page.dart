import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final User user;

  const Home({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${user.email}'),
            TextButton(
              onPressed: () => {},
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
