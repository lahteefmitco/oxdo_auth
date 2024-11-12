import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oxdo_auth/screens/user_info.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final StreamSubscription<User?> _authStateListener;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurepassword = true;
  bool _showPrgressBar = false;

  final _fomKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authStateListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        log("User is not null");
        await _navigateToUserInfo(user);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateListener.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Sign Up"),
            toolbarHeight: 100,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _fomKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    // email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Colors.black38),
                        floatingLabelStyle: TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email  is empty";
                        }

                        if (!_isValidEmail(value)) {
                          return "Enter valid email";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // password
                    TextFormField(
                      obscureText: _obscurepassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        labelStyle: const TextStyle(color: Colors.black38),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _obscurepassword = !_obscurepassword;
                            setState(() {});
                          },
                          icon: Icon(
                            _obscurepassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is empty";
                        }
                        if (value.length < 6) {
                          return "Password length is less than 6";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      obscureText: _obscurepassword,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        label: const Text("Confirm Password"),
                        labelStyle: const TextStyle(color: Colors.black38),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _obscurepassword = !_obscurepassword;
                            setState(() {});
                          },
                          icon: Icon(
                            _obscurepassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is empty";
                        }
                        if (value != _passwordController.text.trim()) {
                          return "Confirm Password is not match with password";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    MaterialButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_fomKey.currentState!.validate()) {
                          _showPrgressBar = true;
                          setState(() {});
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          try {
                            await _createUserWithEmailAndPawword(
                              email: email,
                              password: password,
                            );
                            _showPrgressBar = false;
                            setState(() {});
                          } catch (e) {
                            _showPrgressBar = false;
                            setState(() {});
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            });
                          }
                        }
                      },
                      elevation: 6,
                      minWidth: double.infinity,
                      color: Colors.amber,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Or"),
                    const SizedBox(
                      height: 8,
                    ),

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
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    TextButton(
                      onPressed: () {
                        _navigateToSignInScreen();
                      },
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                      child: const Text("Don't have an account?"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _showPrgressBar ? const CircularProgressIndicator() : const SizedBox()
      ],
    );
  }

  _navigateToSignInScreen() {
    Navigator.pop(context);
  }

  Future _navigateToUserInfo(User user) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => UserInfoScreen(user: user)),(route)=>false,);
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<UserCredential> _signInWithGoogle() async {
    try {
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
    } catch (e) {
      rethrow;
    }
  }

  Future _createUserWithEmailAndPawword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
