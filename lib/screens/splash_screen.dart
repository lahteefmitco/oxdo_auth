import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oxdo_auth/screens/sign_in.dart';
import 'package:oxdo_auth/screens/user_info.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<User?> _authStateListener;

  Future _navigateToSignInScreen() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  Future _navigateToUserInfo(User user) async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => UserInfoScreen(user: user,)));
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
      if (user == null) {
        log("User is null");
        await Future.delayed(const Duration(seconds: 3));
        await _navigateToSignInScreen();
      } else {
        log("User is not null");
        await Future.delayed(const Duration(seconds: 3));
        await _navigateToUserInfo(user);
      }
    });
    return const Scaffold(
      body: Center(child: Text("Splash screen")),
    );
  }
}
