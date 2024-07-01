import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/services/auth/firestore_service.dart';

import '../../models/user_model.dart';
import '../../services/authservice.dart';
import '../signin_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Service = FirestoreService();
  final firebase = FirebaseAuth.instance;
  // Replace this with your user data
  UserModel user = UserModel(
    id: '1',
    name: 'John Doe',
    age: '30',
    height: '6\'2"',
    weight: '180 lbs',
    gender: 'Male',
    healthConditions: 'None',
    foodType: 'Vegetarian',
    email: 'john.doe@example.com',
  );

  @override
  void initState() {
    super.initState();
    getUser();
  }
  void getUser() async {
    final UserModel? getuser = await Service.getUser(context,firebase.currentUser!.uid);
    if(getuser==null){
      print (getuser);
      return;
    }
    setState((){
      user=getuser;
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
     ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App logo at the top
                  Center(
                    child: Image.asset('lib/asset/logo.png', height: 100, width: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  // User details
                  _buildDetailRow('Name', user.name),
                  _buildDetailRow('Age', user.age),
                  _buildDetailRow('Height', user.height),
                  _buildDetailRow('Weight', user.weight),
                  _buildDetailRow('Gender', user.gender),
                  _buildDetailRow('Health Conditions', user.healthConditions),
                  _buildDetailRow('Food Type', user.foodType),
                  _buildDetailRow('Email', user.email),
                  SizedBox(height: 20),
                  // Sign out button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        AuthServices().signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                      child: Text('Sign Out'.toUpperCase(), style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
