import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../db/DBProvider.dart';
import '../../model/response/UserData.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    String imei = '6a37b2a4efd8d308'; // Replace with dynamic value if needed
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
        //log('data: ${response.data}');
        //log('data: ${response.data}');
        String jsonString = jsonEncode(response.data);
        print('Json Res :$jsonString');
        UserData userData = UserData.fromJson(response.data);

        // Print the extracted values
        print('API_STATUS: ${userData.apiStatus}');
        print('APPVERSION: ${userData.appversion}');
        print('APPURL: ${userData.appurl}');
        print('APPSTATUS: ${userData.apiStatus}');
        List<UserTable> userList=userData.userdetails.table;
        print(userList[0].name);

        await DBProvider.initialize(); // Initialize the database
        await DBProvider.db.deleteUserTable();
        // Insert each user into the database
        for (UserTable user in userList) {
          await DBProvider.db.createUser(user);
        }

        print('Successfully Inserted');
        List<UserTable> list = await DBProvider.db.getAllUsers();
        print(list[0].fName);

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
