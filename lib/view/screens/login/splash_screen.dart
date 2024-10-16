import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reliance_sugar_tracking/view/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DeviceInfoPlugin _deviceInfo =
      DeviceInfoPlugin(); // DeviceInfoPlugin instance
  @override
  void initState() {
    super.initState();
    _checkPermissions(); // Check permissions on initialization
  }

  Future<void> _checkPermissions() async {
    // Request location and storage permissions
    final sdkInt = await _getAndroidVersion();
    print("Sdk Version : $sdkInt");
    var locationStatus;var storageStatus;
    if (sdkInt >= 33) {
      locationStatus = await Permission.location.request();
      storageStatus = await Permission.manageExternalStorage.request();
    } else {
      locationStatus = await Permission.location.request();
      storageStatus = await Permission.storage.request();
    }
    print("locationStatus : $locationStatus");
    print("storageStatus : $storageStatus");
    // Check if both permissions are granted
    if (locationStatus.isGranted && storageStatus.isGranted ) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    } else {
      // Handle the case where permissions are not granted
      _showPermissionErrorDialog();
    }
  }

  Future<int> _getAndroidVersion() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt; // Return the SDK version
    }
    return 0; // Return 0 if not Android
  }

  void _showPermissionErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permissions Required"),
          content: Text(
              "Please grant location and storage permissions to continue."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
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
                  SizedBox(height: 70.0),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.0,
                    child: Image.asset(
                      'assets/images/reliance_logo.png',
                      height: 130,
                      width: 130,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "RELIANCE SUGAR TRACKING",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontFamily: 'calibri',
                    ),
                  ),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
