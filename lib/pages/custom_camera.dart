import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/pages/model_page.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras(); // Fetch the list of available cameras
    if (cameras.isNotEmpty) {
      _controller = CameraController(
        cameras[0], // Use the first camera in the list
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePictureAndNavigate() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => APIPage(
            imagePath: image.path,
          ),
        ),
      ).then((_) => _initializeCamera()); // Reinitialize the camera when returning
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? CameraPreview(
        _controller,
        child: _buildCameraOverlay(),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCameraOverlay() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
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
              onTap: _takePictureAndNavigate,
              child: Icon(
                Icons.camera_outlined,
                color: Color.fromARGB(255, 177, 177, 177),
                size: 70,
              ),
            ),
          ],
        ),
      ),
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
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
