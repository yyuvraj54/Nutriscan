import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final int inta;
  final int intb;
  final int intc;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
        required this.inta,
        required this.intb,
        required this.intc,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: Color.fromARGB(255, inta, intb, intc)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color.fromARGB(255, 112, 253, 142)),
          ),
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.blue.shade700),
          hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),
        ),
        
      ),
    );
  }
}
