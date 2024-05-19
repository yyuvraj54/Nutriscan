import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutriscan/firebase_options.dart';
import 'package:nutriscan/pages/gemini_api.dart';
import 'package:nutriscan/pages/signin_page.dart';
import 'package:nutriscan/pages/user_info_screen.dart';
import 'package:nutriscan/services/auth/authgate.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyAeaWmJGffYG1ERxB6ifLcr8Xet9ULgEg0');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade800),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      cameras![0],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(
                    _controller,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        //margin: EdgeInsets.symmetric(vertical: 50),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(128, 72, 76, 81),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 120,
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  try {
                                    await _initializeControllerFuture;
                                    final image =
                                        await _controller.takePicture();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayPictureScreen(
                                          imagePath: image.path,
                                        ),
                                      ),
                                    );
                                    //dispose();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Icon(
                                  Icons.camera_outlined,
                                  color: Color.fromARGB(255, 177, 177, 177),
                                  size: 70,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     try {
      //       await _initializeControllerFuture;
      //       final image = await _controller.takePicture();
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => DisplayPictureScreen(
      //             imagePath: image.path,
      //           ),
      //         ),
      //       );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      //   child: Icon(Icons.camera_alt),
      // ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Picture')),
      body: Center(child: Text('Anyhing '),)
      //Image.file(File(imagePath)),
    );
  }
}
