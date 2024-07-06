import 'package:flutter/material.dart';
import 'package:reliance_sugar_tracking/view/screens/splash_screen.dart';

import '../../main.dart';
import '../../utils/lang/appLocalizations.dart';
import '../../utils/testing/test.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final bool syncWithSystem;
  final ValueChanged<bool> onSyncChanged;

  HomeScreen({
    required this.onThemeChanged,
    required this.syncWithSystem,
    required this.onSyncChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate('title_Home'),),
        actions: [
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              onThemeChanged();
            },
          ),
          Text(AppLocalizations.of(context).getTranslate('sync_message')),
          Switch(
            value: syncWithSystem,
            onChanged: onSyncChanged,
          ),
          IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                // Show language selection dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text('Select Language'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            MyApp.setLocale(context, Locale('ar', '')); // Arabic
                            Navigator.pop(context);
                          },
                          child: Text('العربية'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            MyApp.setLocale(context, Locale('en', '')); // English
                            Navigator.pop(context);
                          },
                          child: Text('English'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            MyApp.setLocale(context, Locale('hi', ''));// Hindi
                            Navigator.pop(context);
                          },
                          child: Text('हिंदी'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            MyApp.setLocale(context, Locale('gu', '')); // Gujarati
                            Navigator.pop(context);
                          },
                          child: Text('ગુજરાતી'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => TestScreen()),
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
            child: Text('Go to Test Screen'),
          ),
          SizedBox(height: 20),
          Text('Hello, World!'),
        ],
      ),
    );
  }
}