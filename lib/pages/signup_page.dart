import 'package:flutter/material.dart';
import 'package:nutriscan/component/my_button.dart';
import 'package:nutriscan/component/mytext_field.dart';
import 'package:nutriscan/services/authservice.dart';

class Signup extends StatefulWidget {
  final Function()? onTap;
  const Signup({super.key, this.onTap});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signup() async {
    final _authService = AuthServices();

    // Show progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // or any other indicator widget
        );
      },
    );

    if (passwordController.text == confirmPasswordController.text) {
      try {
        await _authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        // Hide progress indicator
        Navigator.of(context).pop(); // Close the progress dialog

        // Optionally, navigate to a new screen or perform any other action upon successful signup
      } catch (e) {
        // Hide progress indicator
        Navigator.of(context).pop(); // Close the progress dialog

        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      // Hide progress indicator
      Navigator.of(context).pop(); // Close the progress dialog

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Please enter the same password'),
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
              'Register yourself.',
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

            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm password',
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),

            //button
            MyButton(
              text: "Signup",
              onTap: signup,
            ),
            const SizedBox(
              height: 25,
            ),

            //forgot pasword
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have a account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now!',
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
