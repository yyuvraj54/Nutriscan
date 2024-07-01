
import 'dart:async';

import 'package:flutter/material.dart';

class TextRotator extends StatefulWidget {
  final List<String> texts;

  TextRotator({required this.texts});

  @override
  _TextRotatorState createState() => _TextRotatorState();
}

class _TextRotatorState extends State<TextRotator> {
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            widget.texts[_currentIndex],
            style: TextStyle(fontSize: 24),
            ),
        );
    }
}