import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionState();
}

class _PermissionState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Handler Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _requestPermission();
          },
          child: Text('Request Location Permission'),
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      print('Location Permission Granted');
      _showSnackBar('Location Permission Granted');
    } else if (status.isDenied) {
      print('Location Permission Denied, requesting again...');
      _showSnackBar('Location Permission Denied, requesting again...');
      await _requestPermission();
    } else if (status.isPermanentlyDenied) {
      print('Location Permission Permanently Denied, opening app settings...');
      _showSnackBar('Location Permission Permanently Denied, opening app settings...');
      await openAppSettings();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
