import 'package:flutter/material.dart';
import 'package:nutriscan/pages/signin_page.dart';

import '../services/authservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(child: Column(children: [
      ElevatedButton(
          child: Text(
              "Sign Out".toUpperCase(),
              style: TextStyle(fontSize: 14)
          ),
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(Colors.red), shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.red)))),
          onPressed: () {
            AuthServices().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin()));
          }
      )

    ],),),);
  }
}

