import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutriscan/component/my_button.dart';
import 'package:nutriscan/component/mytext_field.dart';
import 'package:nutriscan/models/user_model.dart';
import 'package:nutriscan/pages/user_info_screen.dart';
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

  final TextEditingController confirmPasswordController =TextEditingController();
  final TextEditingController nameController =TextEditingController();

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
        showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Stack(alignment: Alignment.bottomCenter, children: [
                SvgPicture.asset(
                  'lib/asset/dotedline.svg',
                  height: 70,
                ),
                Text('Get Started',
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255,98, 179, 255)))
              ]),

              Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.88,
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
                        SvgPicture.asset('lib/asset/signup_text.svg'),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ),
                        MyTextField(
                          inta: 255,intb: 255,intc: 255,
                          controller: nameController,
                          hintText: 'John Doe',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ),
                        MyTextField(
                          inta: 255,intb: 255,intc: 255,
                          controller: emailController,
                          hintText: 'example@email.com',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'Confirm Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              )),
                        ),
                        MyTextField(
                          inta: 255,intb: 255,intc: 255,
                          controller: confirmPasswordController,
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
                          onPressed: signup,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                          color: Colors.black),
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
                            color: Color.fromARGB(255,98, 179, 255)),
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
