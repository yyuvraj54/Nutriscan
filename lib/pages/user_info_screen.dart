import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/pages/bottom_nav_bar/home_screen.dart';
import 'package:nutriscan/services/auth/firestore_service.dart';
import 'package:nutriscan/services/authservice.dart';

import '../component/mytext_field.dart';
import '../models/user_model.dart';
import 'bottom_nav_bar/bottom_navigation.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController healthController = TextEditingController();
  TextEditingController foodTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if user data is already uploaded
    checkUserDataUploaded();
  }

  void checkUserDataUploaded() async {
    User? currentUser = AuthServices().getCurrentUser();

    if (currentUser != null) {
      // Assuming you have a method in FirestoreService to check if user data exists
      bool userDataExists = await FirestoreService().checkUserDataExists(currentUser.uid);

      if (userDataExists) {
        // User data already uploaded, navigate to HomeScreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    }
  }

  void onContinueCilcked() {
    User? currentUser = AuthServices().getCurrentUser();

    if (currentUser != null) {
      String email = currentUser.email.toString();
      String uid = currentUser.uid.toString();

      UserModel user = UserModel(
        id: uid, // Assuming you have a predefined ID or you can generate one as needed
        name: nameController.text,
        age: ageController.text,
        weight: weightController.text,
        height: heightController.text,
        gender: genderController.text,
        healthConditions: healthController.text,
        foodType: foodTypeController.text,
        email: email, // Assuming email is predefined or obtained from authentication
      );

      FirestoreService().addUser(context,user).then((_) {
        print('User added successfully');
        // Navigate to HomeScreen after user data is uploaded
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      }).catchError((e) {
        print('Failed to add user: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,103, 229, 115,),
      appBar: AppBar(title: Text('User Information')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(inta: 98,intb: 179,intc: 255, controller: nameController, hintText: 'Name', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 98,intb: 179,intc: 255,controller: ageController, hintText: 'Age', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 98,intb: 179,intc: 255,controller: weightController, hintText: 'Weight', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 98,intb: 179,intc: 255,controller: heightController, hintText: 'Height', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 98,intb: 179,intc: 255,controller: genderController, hintText: 'Gender', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 98,intb: 179,intc: 255,controller: healthController, hintText: 'Health Conditions', obscureText: false,),
              SizedBox(height: 20),
              MyTextField(inta: 298,intb: 179,intc: 255,controller: foodTypeController, hintText: 'Food Type', obscureText: false,),
              SizedBox(height: 40), // Adjusting space between text fields and button
              Center(
                child: ElevatedButton(

                  onPressed: onContinueCilcked,
                  child: Text('Continue',style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(Color.fromARGB(255,98, 179, 255)),
                      foregroundColor: MaterialStateProperty.all<Color?>(Color.fromARGB(255,98, 179, 255))
                  ),
                ),
              ),
              SizedBox(height: 40), 
              // Adding extra space at the bottom for padding
            ],
          ),
        ),
      ),
    );
  }
}
