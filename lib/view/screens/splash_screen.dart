import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Directory caneDevelopmentDir;

  @override
  void initState() {
    super.initState();
    getValidateImei();
  }

  void getValidateImei() async {
    Dio dio = Dio();

    // Constructing the URL and parameters
    String url = 'http://reltrack.vibsugar.com/api/WebAPI/GPS_ValidateIMEI';
    String imei = '6a37b2a4efd8d308';  // Replace with dynamic value if needed
    String firebaseRegistrationId = 'hngtyaf';  // Replace with dynamic value if needed

    // Constructing query parameters
    Map<String, dynamic> queryParams = {
      'IMEINO': imei
    };

    // Setting headers
    Options options = Options(
      headers: {
        'X-ApiKey': 'LsTrackingVib@1234',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('LsDemo@45:LsAdmin@123')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    try {
      // Making the GET request with Dio
      Response response = await dio.post(
        url,
        queryParameters: queryParams,
        options: options,
      );

      // Checking the response status
      if (response.statusCode == 200) {
        // Handle successful response here
        print('Response: ${response.data}');
      } else {
        // Handle unsuccessful response here
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

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
