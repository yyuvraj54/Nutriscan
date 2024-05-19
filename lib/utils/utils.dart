import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
