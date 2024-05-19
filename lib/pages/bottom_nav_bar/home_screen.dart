import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nutriscan/pages/signin_page.dart';

import '../../services/authservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Image.asset(
                'lib/asset/logo.png',
                height: 30, // Adjust the height as needed
              ),
              onPressed: () {
                // Add functionality for Nurifit icon
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Add functionality for menu button
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Auto-scrolling images
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true, // Enable auto-scrolling
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: [
                'lib/asset/doctor.png',
                'lib/asset/scan.png',
                'lib/asset/plan.png',
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(right: 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath,
                            height: 120, // Adjust the height as needed
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Card view with an image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'lib/asset/helth.png', // Replace 'assets/your_image.jpg' with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Check Your Health Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Facts and news card with image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Facts and News', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    // Replace this with actual image and content
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'lib/asset/funfact.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200, // Adjust the height as needed
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
