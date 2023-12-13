import 'package:flutter/material.dart';

import 'package:flutter_internship_assignment/screens/login.dart';
import 'package:flutter_internship_assignment/screens/registration.dart';

class LandingPage extends StatefulWidget {
  static String id = 'LandingPage';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle login button press
                Navigator.pushNamed(context, Login.id);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200.0, 50.0), // Set fixed size
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle registration button press
                Navigator.pushNamed(context, Registration.id);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200.0, 50.0), // Set fixed size
              ),
              child: Text('Registration'),
            ),
          ],
        ),
      ),
    );
  }
}
