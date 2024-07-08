import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/login_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.0),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.0,
                    child: Image.asset(
                      'assets/images/wavelogo.png',
                      height: 130,
                      width: 130,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "WAVE INDUSTRIES LIMITED",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      fontFamily: 'calibri',
                    ),
                  ),
                  SizedBox(height: 40.0),
                  CircularProgressIndicator(),
                  SizedBox(height: 40.0),
                  Text(
                    "Checking Permissions...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: 'calibri',
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
