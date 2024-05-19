import 'dart:io';

import 'package:flutter/material.dart';

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
            padding: EdgeInsets.only(top: 18.0, ),
            child: BottomAppBar(
              elevation: 0.0,
              color: Colors.white, // Set background color to white
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 60,
                  color: Colors.green, // Color for the selected item indicator
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
          bottom: Platform.isAndroid ? 28 : 32, // Adjusted position
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 64,
            width: 64,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () => debugPrint("Add Button pressed"), // yaha se open hoga camera wala screen tik h abhishek!!
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
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
