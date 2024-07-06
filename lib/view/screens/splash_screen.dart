import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reliance_sugar_tracking/utils/other/jsonExtract.dart';

import '../../model/response/UserData.dart';

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

    // Constructing the URL
    String url = 'http://reltrack.vibsugar.com/api/WebAPI/GPS_ValidateIMEI';

    // Constructing the body parameters
    String imei = '6a37b2a4efd8d308';  // Replace with dynamic value if needed
    Map<String, dynamic> bodyParams = {
      'IMEI': imei,
    };

    // Setting headers
    Options options = Options(
      headers: {
        'Content-Type': 'application/json',
      },
    );

    try {
      // Making the POST request with Dio
      Response response = await dio.post(
        url,
        data: bodyParams,
        options: options,
      );

      // Checking the response status
      if (response.statusCode == 200) {

       /* print('Response: ${response.data}');
        Map<String, dynamic> responseData = response.data;
        print('Response1: $responseData');*/

        print('Raw Response: ${response.data}');
        final jsonData = jsonExtract.extractJsonObjectFromXml(response.data as String);
        final userData = UserData.fromJson(jsonData);


        /*Map<String, dynamic> responseData = response.data;
        UserData userData = UserData.fromJson(responseData);*/
        print('API_STATUS: ${userData.apiStatus.toString()}');
        print('APPVERSION: ${userData.appVersion.toString()}');
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
