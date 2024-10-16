import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceInfoUtil {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Get Application Version Name
  Future<String> getAppVersionName() async {
    final info = await _deviceInfo.deviceInfo;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = info as AndroidDeviceInfo;
      return androidInfo.version.release; // Returns the Android version
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = info as IosDeviceInfo;
      return iosInfo.systemVersion; // Returns the iOS version
    }
    return 'Unknown';
  }

  // Get Application Version Code
  Future<String> getAppVersionCode() async {
    // You might consider returning a constant or fetching from your app's configuration
    return '1.0.0'; // Example placeholder version code
  }

  // Get Application ID
  Future<String> getApplicationId() async {
    return 'com.example.yourapp'; // Replace with your app ID
  }

  // Get Device IMEI or Unique ID
  Future<String> getDeviceImei() async {
    if (await Permission.phone.request().isGranted) {
      final info = await _deviceInfo.deviceInfo;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = info as AndroidDeviceInfo;
        return androidInfo.id; // Use device ID for Android (IMEI not available on Android 10+)
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = info as IosDeviceInfo;
        return iosInfo.identifierForVendor ?? 'Unknown'; // Unique ID for iOS
      }
    }
    return 'Permission Denied or Unsupported Platform';
  }

  // Check if Mobile Data is Enabled
  Future<bool> isMobileDataEnabled() async {
    final connectivity = Connectivity();
    ConnectivityResult result = (await connectivity.checkConnectivity()) as ConnectivityResult;
    return result == ConnectivityResult.mobile;
  }

  // Check Airplane Mode Status (Android Only)
  Future<bool> isAirplaneModeOn() async {
    if (Platform.isAndroid) {
      const platform = MethodChannel('com.example.yourapp/airplaneMode');
      try {
        final bool result = await platform.invokeMethod('isAirplaneModeOn');
        return result;
      } on PlatformException catch (_) {
        return false;
      }
    }
    return false;
  }

  // Check Uplink and Downlink Speeds (requires ConnectivityPlus)
  Future<String> getNetworkSpeed() async {
    ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      // You can integrate a third-party library or API to measure speeds
      return 'Speed Measurement Not Available in Flutter by Default';
    } else {
      return 'No active network';
    }
  }
}
