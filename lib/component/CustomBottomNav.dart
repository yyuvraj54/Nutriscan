import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutriscan/pages/custom_camera.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.pageIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: BottomAppBar(
              elevation: 0.0,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 60,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      navItem(
                        Icons.home_outlined,
                        "Home",
                        pageIndex == 0,
                        onTap: () => onTap(0),
                      ),
                      navItem(
                        Icons.person_outline,
                        "Profile",
                        pageIndex == 1,
                        onTap: () => onTap(1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: Platform.isAndroid ? 28 : 32,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 64,
            width: 64,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen())),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 3, color: Colors.green),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.camera_enhance,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem(
      IconData icon,
      String label,
      bool isSelected, {
        required Function() onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
            size: isSelected ? 28.0 : 24.0, // Change the size to emphasize selected icon
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
