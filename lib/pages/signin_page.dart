import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 140,
              ),
              Stack(alignment: Alignment.bottomCenter, children: [
                SvgPicture.asset(
                  'lib/asset/dotedline.svg',
                  height: 70,
                ),
                const Text('Get Started',
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255,98, 179, 255)))
              ]),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 12,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 103, 229, 115)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset('lib/asset/login_signup_text.svg'),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ),
                        MyTextField(inta: 255,intb: 255,intc: 255,
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Text(
                                'Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ),
                        MyTextField(
                          inta: 255,intb: 255,intc: 255,
                          controller: passwordController,
                          hintText: 'at least 8 character',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(10),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255,98, 179, 255)), // Change background color
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white), // Change text color
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent.withOpacity(
                                    0.1)), // Change overlay color when pressed
                          ),
                          onPressed: signin,
                          child: const Text(
                            'Log in',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have a account?",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'SignUp now!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255,98, 179, 255)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
