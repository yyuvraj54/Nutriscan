import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/pages/camera_page.dart';
import 'package:nutriscan/pages/custom_camera.dart';
import 'package:nutriscan/pages/model_page.dart';
import 'package:nutriscan/pages/signin_signup_page.dart';
import 'package:nutriscan/pages/user_info_screen.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  UserInfoScreen();
          } else {
            return const SigninOrSignup();
          }
        },
      ),
    );
  }
}