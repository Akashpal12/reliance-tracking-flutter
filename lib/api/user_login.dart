import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reliance_sugar_tracking/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin {
  final BuildContext context;
  UserLogin(this.context);
  Future<void> login(String mobileNumber,String password, String imeiNo) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Please wait while we getting details"),
            ],
          ),
        );
      },
    );

    try {
      const String apiUrl = Constants.apiUrl+"";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'Mobile': mobileNumber,
          'Password': password,
          'IMEI': imeiNo,
        },
      );

      // Parse response
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse["API_STATUS"] == "OK") {
          await saveUserDetails(jsonResponse["USERDETAILS"]["Table"]);
          Navigator.of(context).pushReplacementNamed('/home'); // Navigate to Home screen
        } else {
          // Show error message
          showAlertDialog(jsonResponse["DATA"]);
        }
      } else {
        // Handle server error
        showAlertDialog("Server error, please try again later.");
      }
    } catch (e) {
      showAlertDialog("An error occurred: ${e.toString()}");
    } finally {
      // Dismiss loading dialog
      Navigator.of(context).pop(); // Dismiss dialog
    }
  }

  Future<void> saveUserDetails(List<dynamic> userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userDetails", json.encode(userDetails));
    // Save any other details you need
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
