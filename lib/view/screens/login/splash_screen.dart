import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _permissionGranted = false;
  late Directory caneDevelopmentDir;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.videos,
        Permission.audio,
        Permission.manageExternalStorage,
      ].request();

      if (statuses.values.every((status) => status.isGranted)) {
        _permissionGranted = true;
      } else if (statuses.values.any((status) => status.isPermanentlyDenied)) {
        openAppSettings();
      }
    }
    else if (androidInfo.version.sdkInt == 32 || androidInfo.version.sdkInt == 31) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();

      if (statuses.values.every((status) => status.isGranted)) {
        _permissionGranted = true;
      } else if (statuses.values.any((status) => status.isPermanentlyDenied)) {
        openAppSettings();
      }
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        _permissionGranted = true;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    if (_permissionGranted) {
      await createDirectories();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Storage permission is required to proceed.')));
    }
  }


  Future<void> createDirectories() async {
    try {
      Directory internalDir = Directory('/storage/emulated/0');
      if (await internalDir.exists()) {
        String internalPath = internalDir.path;
        caneDevelopmentDir = Directory('$internalPath/akash_dev');
        if (!(await caneDevelopmentDir.exists())) {
          await caneDevelopmentDir.create(recursive: true);
          debugPrint('Directory created: ${caneDevelopmentDir.path}');
        } else {
          debugPrint('Directory already exists: ${caneDevelopmentDir.path}');
        }
      } else {
        debugPrint('Error: Internal storage not detected at ${internalDir.path}');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Internal storage not detected. Please check your device settings.'))
        );
      }
      _navigateToHome();
    } catch (e) {
      debugPrint('Error creating directories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating directories: $e'))
      );
    }
  }
  void _navigateToHome() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(), // Loading indicator
            SizedBox(height: 20),
            Text("Checking permissions...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: const Center(child: Text('Welcome to Home!')),
    );
  }
}
