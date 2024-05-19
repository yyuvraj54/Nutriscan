import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/component/my_button.dart';
import 'package:nutriscan/component/mytext_field.dart';
import 'package:nutriscan/pages/user_info_screen.dart';
import 'package:nutriscan/services/authservice.dart';

class Signin extends StatefulWidget {
  final Function()? onTap;

  const Signin({super.key, this.onTap});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<void> signin() async {
    final _authServices = AuthServices();

    // Show progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // or any other indicator widget
        );
      },
    );

    try {
      await _authServices.signInWithEmailPassword(emailController.text, passwordController.text);

      // Hide progress indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the progress dialog
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserInfoScreen(),),);
      // Optionally, navigate to a new screen or perform any other action upon successful sign-in
    } catch (e) {
      // Hide progress indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the progress dialog

      // Show error dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            const Icon(
              Icons.food_bank,
              size: 100,
            ),
            const SizedBox(
              height: 25,
            ),

            //welcome message
            const Text(
              'Welcome back, nice to see you!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),

            //username
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(
              height: 25,
            ),

            //password
            MyTextField(
              controller: passwordController,
              hintText: 'password',
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),

            //button
            MyButton(
              text: "Signin",
              onTap: signin,
            ),
            const SizedBox(
              height: 25,
            ),

            //forgot pasword
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have a account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
