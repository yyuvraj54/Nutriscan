import 'package:flutter/material.dart';
import 'package:nutriscan/pages/bottom_nav_bar/profile_screen.dart';
import '../../component/CustomBottomNav.dart';
import '../camera_page.dart';
import 'home_screen.dart';


void main() {
  runApp(MaterialApp(
    home: BottomNavigation(),
  ));
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        pageIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
