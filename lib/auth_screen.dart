import 'package:chatting_app/screens/imagefeed-screen.dart';
import 'package:chatting_app/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, navigate to the ImageFeedScreen
      return ImageFeedScreen();
    } else {
      // User is not signed in, navigate to the SignInScreen
      return SignInScreen();
    }
  }
}
