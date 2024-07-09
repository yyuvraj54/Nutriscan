import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/auth/firestore_service.dart';
import '../../services/authservice.dart';
import '../bottom_nav_bar/bottom_navigation.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentPage = 0;
  String? _sex;
  String? _activityLevel;
  double _height = 160.0;
  int _age = 25;
  String _name = "";
  double _weight = 70.0;
  String? _allergies;
  String? _foodPreference;

  @override
  void initState() {
    super.initState();
    // Check if user data is already uploaded
    checkUserDataUploaded();
  }

  void checkUserDataUploaded() async {
    User? currentUser = AuthServices().getCurrentUser();

    if (currentUser != null) {
      // Assuming you have a method in FirestoreService to check if user data exists
      bool userDataExists = await FirestoreService().checkUserDataExists(currentUser.uid);

      if (userDataExists) {
        // User data already uploaded, navigate to HomeScreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    }
  }

  void onContinueCilcked() {
    User? currentUser = AuthServices().getCurrentUser();

    if (currentUser != null) {
      String email = currentUser.email.toString();
      String uid = currentUser.uid.toString();

      UserModel user = UserModel(
        id: uid, // Assuming you have a predefined ID or you can generate one as needed
        age: _age.toString(),
        weight: _weight.toString(),
        name: _name,
        height: _height.toString(),
        gender: _sex.toString(),
        healthConditions: _allergies.toString(),
        foodType: _foodPreference.toString(),
        email: email,  // Assuming email is predefined or obtained from authentication
      );

      FirestoreService().addUser(context,user).then((_) {
        print('User added successfully');
        // Navigate to HomeScreen after user data is uploaded
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      }).catchError((e) {
        print('Failed to add user: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(103, 229, 115, 1),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _buildSexPage(),
            _buildActivityLevelPage(),
            _buildNamePage(),
            _buildHeightPage(),
            _buildAgePage(),
            _buildWeightPage(),
            _buildAllergiesPage(),
            _buildFoodPreferencePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:  Color.fromRGBO(103, 229, 115, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage != 0)
              TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text('Previous'),
              ),
            if (_currentPage != 6)
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Text('Next'),
              ),
            if (_currentPage == 6)
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    onContinueCilcked();
                  }
                },
                child: Text('Submit'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSexPage() {
    return _buildPage(
      image: 'lib/asset/sex.png',
      title: 'Select Your Sex',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0,30, 0),
        child: DropdownButtonFormField<String>(
          value: _sex,
          items: ['Male', 'Female'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _sex = newValue;
            });
          },
          validator: (value) => value == null ? 'Please select your sex' : null,
        ),
      ),
    );
  }

  Widget _buildActivityLevelPage() {
    return _buildPage(
      image: 'lib/asset/activity.png',
      title: 'Select Your Activity Level',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0,30, 0),
        child: DropdownButtonFormField<String>(
          value: _activityLevel,
          items: ['Not Active', 'Normal', 'Weekly', 'Regular'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _activityLevel = newValue;
            });
          },
          validator: (value) => value == null ? 'Please select your activity level' : null,
        ),
      ),
    );
  }

  Widget _buildHeightPage() {
    return _buildPage(
      image: 'lib/asset/height.png',
      title: 'Enter Your Height',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _height,
            min: 100.0,
            max: 250.0,
            divisions: 150,
            onChanged: (double value) {
              setState(() {
                _height = value.roundToDouble();
              });
            },
          ),
          Text('Select Height: $_height cm'),
        ],
      ),
    );
  }

  Widget _buildAgePage() {
    return _buildPage(
      image: 'lib/asset/age.png',
      title: 'Enter Your Age',
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
      Slider(
      value: _age.toDouble(), // Convert _age to double
      min: 10.0,
      max: 80.0,
      divisions: 70,
      onChanged: (double value) {
        setState(() {
          _age = value.round(); // Round value to nearest integer
        });
      },
    ),
    Text('Select Age: $_age years'),

          ],
      ),

    );
  }

  Widget _buildWeightPage() {
    return _buildPage(
      image: 'lib/asset/weight.png',
      title: 'Enter Your Weight',
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _weight,
            min: 30.0,
            max: 200.0,
            divisions: 170,
            onChanged: (double value) {
              setState(() {
                _weight = value; // Update _weight with the slider value
              });
            },
          ),
          Text('Select Weight: $_weight kg'),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return _buildPage(
      image: 'lib/asset/user.png',
      title: 'Your Name',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0,30, 0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              _name = value;
            });
          },
          validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
        ),
      ),
    );
  }

  Widget _buildAllergiesPage() {
    return _buildPage(
      image: 'lib/asset/allergies.png',
      title: 'Any Allergic to Any Food?',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0,30, 0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              _allergies = value;
            });
          },
          validator: (value) => value?.isEmpty ?? true ? 'Please enter any allergies' : null,
        ),
      ),
    );
  }

  Widget _buildFoodPreferencePage() {
    return _buildPage(
      image: 'lib/asset/food.png',
      title: 'Which Type of Food Do You Prefer?',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0,30, 0),
        child: DropdownButtonFormField<String>(
          value: _foodPreference,
          items: ['Veg', 'Non-Veg', 'Both'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _foodPreference = newValue;
            });
          },
          validator: (value) =>
          value == null
              ? 'Please select your food preference'
              : null,
        ),
      ),
    );
  }
    Widget _buildPage({
      required String image,
      required String title,
      required Widget child,
    }) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 200),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            child,
          ],
        ),
      );
    }
  }
