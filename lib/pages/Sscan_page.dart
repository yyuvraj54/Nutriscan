import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              pickImageFromGAllery();
            },
            child: Text('Pick Image from Galery'),
          ),
          ElevatedButton(
            onPressed: () {
              pickImageFromCamera();
            },
            child: Text('Pick Image from Camera'),
          ),
          SizedBox(
            height: 30,
          ),
          selectedImage == null
              ? Text('Please select a image')
              : SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.file(selectedImage!))
        ]),
      ),
    );
  }

  Future pickImageFromGAllery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }
  Future pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }
}
