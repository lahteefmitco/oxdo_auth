import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oxdo_auth/screens/sign_up.dart';
import 'package:oxdo_auth/screens/user_info.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final StreamSubscription<User?> _authStateListener;

  Future _navigateToSignUpScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  Future _navigateToUserInfo(User user) async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>  UserInfoScreen(user:user)));
  }

  @override
  void dispose() {
    _authStateListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authStateListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        log("User is not null");
        await _navigateToUserInfo(user);
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign in"),
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Design google button
            SignInButton(
              Buttons.google,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                 // calling sign in button
                _signInWithGoogle();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
