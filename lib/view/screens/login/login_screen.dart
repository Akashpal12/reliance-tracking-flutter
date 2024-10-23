import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package

import '../../../db/DBProvider.dart';
import '../../../model/response/login_response.dart';
import '../../../utils/testing/UserData.dart';
import '../../../utils/connectivity/deviceInfo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DeviceInfoUtil deviceInfoUtil = DeviceInfoUtil();
  String dropdownValue = 'Please Select User';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String imeiNumber = '';
  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    imeiNumber = await deviceInfoUtil.getDeviceImei();
    setState(() {});
  }

  Future<void> verifyUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });
      String apiUrl =
          "http://reltrack.vibsugar.com/api/WebAPI/GPS_CheckOTP"; // Replace with your actual API URL
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'Mobile': _mobileController.text,
            'Password': _passwordController.text,
            'IMEI': imeiNumber,
          },
        );
        print('Request URL: $apiUrl');
        print('Request Parameters:');
        print('Mobile: ${_mobileController.text}');
        print('Password: ${_passwordController.text}');
        print('IMEI: $imeiNumber');

        if (response.statusCode == 200) {
          print('Response data: ${response.body}');
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          ApiResponse apiResponse = ApiResponse.fromJson(jsonResponse);
          print('API_STATUS: ${apiResponse.apiStatus}');
          List<UserDetail> userList=apiResponse.userDetails.table;
          print(userList[0].name);
          await DBProvider.initialize(); // Initialize the database
          await DBProvider.db.deleteUserTable();
          // Insert each user into the database
          for (UserDetail user in userList) {
            await DBProvider.db.createUser(user);
          }
          print('Successfully Inserted');
          if (jsonResponse["API_STATUS"] == "OK") {

          } else {
            showAlertDialog(jsonResponse["DATA"]);
          }
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A3A4), // Background color
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/reliance_logo.png', // Logo asset
                height: 100,
              ),
              SizedBox(height: 20),
              // Login Form
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey, // Attach the form key
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please enter your details to continue',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                        // Employee Dropdown
                        DropdownButtonFormField<String>(
                          value: dropdownValue,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null ||
                                value == 'Please Select User') {
                              return 'Please select a user type';
                            }
                            return null;
                          },
                          items: <String>['Please Select User', 'User', 'Admin']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        // Mobile Number Input
                        TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Mobile Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            } else if (value.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Password Input
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: true,
                          // Hide the password
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Verify User Button
                        _isLoading
                            ? CircularProgressIndicator() // Show loading indicator
                            : ElevatedButton(
                                onPressed: verifyUser, // Call verifyUser method
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'VERIFY USER',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'RELIANCE SUGAR SECURITY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Alert",
            style: TextStyle(
              fontSize: 20, // Increase title font size
              fontWeight: FontWeight.bold, // Make title bold
            ),
          ),
          content: Text(message,
              style: TextStyle(
                fontSize: 18, // Increase button font size
              )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Set to zero for square shape
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 16, // Increase button font size
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
