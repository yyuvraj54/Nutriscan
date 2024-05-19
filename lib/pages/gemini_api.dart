// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class APIPage extends StatefulWidget {
  final String imagePath;

  const APIPage({required this.imagePath});

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
    final gemini = Gemini.instance;

    gemini.textAndImage(
        text: 'The person is male and suffering from Diabetes,age-27,height-5foot9inches, weight-68kg,is a veg person,You are an expert in nutritionist where you need to see the food items from the image,answer all the questions related to the food in the json format given below\n' +
            '{' +
            'Name : name of the food,\n' +
            'Calories : integer value calories (Like : 100 calories),\n' +
            'Health Concern :  is it good to eat that food if the person is suffering from the disease mentioned?,\n' +
            'Allergy : mention allergic contents in the food in short bullets points,\n' +
            'Energy :  mention the energy value of the food in calories (like 100 cal),\n' +
            'Protein : mention the protein value of the food in gram (like 10 g),\n' +
            'Carbohydrates : "mention the carbohydrate value of the food in gram (like 10 g),\n' +
            'Fiber : mention the fiber value of the food in gram (like 10g),\n' +
            'Chloestrol : mention the chloestrol value of the food in gram (like 10g),\n' +
            'Vitamins : mention the overall value of the food in gram (like 10g),\n' +
            'Minerals : mention the overall minerals value of the food in gram (like 10g),\n' +
            '} ',
        images: [File(widget.imagePath).readAsBytesSync()]).then((value) {
      setState(() {
        output = value!.content!.parts![0].text.toString();
      });
      makejson();
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanning.....')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(widget.imagePath),
                    height: 400,
                    width: MediaQuery.of(context).size.width * 0.85,
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: 20),
              //Text(output),
              if (ans != null)
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           ans!['food'],
                    //           style: TextStyle(
                    //               fontSize: 32, fontWeight: FontWeight.w700),
                    //         ),
                    //         Text(
                    //           ans!['calorie'].toString(),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(height: 28,
                    //     child: Row(children:[Text('Health Concern',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w600,fontSize: 24),),SizedBox(width: 2,)]),),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width*0.9,
                    //       margin: EdgeInsets.symmetric(vertical: 12),
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                    //       color: Colors.grey.shade400
                    //       ),
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                    //         child: Text(ans!['health concern'].toString(),style: TextStyle(color: Colors.black),)),
                    //     ),
                    //     SizedBox(height: 28,
                    //     child: Row(children:[Text('Alergy Content',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w600,fontSize: 24),),SizedBox(width: 2,)]),),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width*0.9,
                    //       margin: EdgeInsets.symmetric(vertical: 12),
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                    //       color: Colors.grey.shade400
                    //       ),
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                    //         child: Text(ans!['allergy content'].toString(),style: TextStyle(color: Colors.black),)),
                    //     )

                    //   ],
                    // ),
                    //set a maximum height
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Nutrients',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),), Text('Value per Serving',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600))],
                                  ),
                                )),
                          )
                        ],
                      ),
                    )

                    // ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true, // to use ListView inside a Column
                    //   itemCount: ans!.length,
                    //   itemBuilder: (_, index) {
                    //     var key = ans!.keys.elementAt(index);
                    //     var value = ans![key];
                    //     return Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 10),
                    //         child: Text('$key: $value'));
                    // },
                    // ),
                    )
              else
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
