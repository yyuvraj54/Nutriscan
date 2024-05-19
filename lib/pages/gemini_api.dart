import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class APIPage extends StatefulWidget {
  @override
  _APIPageState createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> {
  final TextEditingController _textController = TextEditingController();
  File? _image;
  String output = '';
  final ImagePicker _picker = ImagePicker();
  Map<dynamic, dynamic>? ans = null;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _sendData() async {
    final text = _textController.text;
    if (_image == null || text.isEmpty) {
      print('Please provide both text and image.');
      return;
    }
    final gemini = Gemini.instance;

    gemini.textAndImage(
        text: _textController.text +
            ' , give answer in json format, start with { and end with }, dont put the word json and ```  in the output',

        /// text
        images: [_image!.readAsBytesSync()]

        /// list of images
        ).then((value) {
      setState(() {
        output = value!.content!.parts![0].text.toString();
      });
      makejson();
    }).catchError((e) => print(e));
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Upload to Gemini')),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter your text'),
            ),
            SizedBox(height: 20),
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            //Text(output),
            if (ans != null)
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 600), // set a maximum height
                child: ListView.builder(
                  shrinkWrap: true, // to use ListView inside a Column
                  itemCount: ans!.length,
                  itemBuilder: (_, index) {
                    var key = ans!.keys.elementAt(index);
                    var value = ans![key];
                    return Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('$key: $value'));
                  },
                ),
              )
            else
              Text('Data will be shown here'),
            SizedBox(height: 20), // add some spacing before the buttons
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendData,
              child: Text('Send Data'),
            ),
            
          ],
        ),
      ),
    ),
  );
}


  void makejson() {
    if (output != '') {
      Map<dynamic, dynamic> usecase = jsonDecode(output);
      setState(() {
        ans = usecase;
      });
    }
  }
}
