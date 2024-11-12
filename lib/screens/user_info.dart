import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oxdo_auth/screens/sign_in.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;
  const UserInfoScreen({super.key, required this.user});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late final StreamSubscription<User?> _authStateListener;

  Future _navigateToSignInScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  void dispose() {
    _authStateListener.cancel();
    super.dispose();
  }

  @override
  void initState() {
       _authStateListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        log("User is not null");
      } else {
        log("User is null");
        _navigateToSignInScreen();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    final photoUrl = widget.user.photoURL;
    final name = widget.user.displayName;
    final phoneNumber = widget.user.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User info"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            if (photoUrl != null)

              // Display the image here
              CircleAvatar(
                radius: 100,
                backgroundImage: Image.network(photoUrl).image,
              ),
            const SizedBox(
              height: 20,
            ),

            // Display name
            Text(name ?? "Nil"),
            const SizedBox(
              height: 20,
            ),

            // Display phone number
            Text(phoneNumber ?? "Nil"),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                // Sign out
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
