import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reliance_sugar_tracking/utils/lang/appLocalizations.dart';
import 'package:reliance_sugar_tracking/utils/themes/theme.dart';
import 'package:reliance_sugar_tracking/utils/testing/home_screen.dart';
import 'package:reliance_sugar_tracking/view/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setState(() {
      state.locale = newLocale;
    });
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale locale = const Locale('en', ''); // Default locale is English
  late ThemeData _themeData = AppThemes.lightTheme; // Initialize with a default value
  late bool _isDarkMode = false; // Initialize with a default value
  late bool _syncWithSystem = false; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    bool syncWithSystem = prefs.getBool('syncWithSystem') ?? false;

    setState(() {
      _isDarkMode = isDarkMode;
      _syncWithSystem = syncWithSystem;
      _themeData = _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      MyApp.setLocale(context, locale);
    });
  }

  void _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    setState(() {
      _isDarkMode = isDarkMode;
      _themeData = _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    });
  }

  void _toggleTheme() {
    _saveTheme(!_isDarkMode);
  }

  @override
  void didChangePlatformBrightness() {
    if (_syncWithSystem) {
      bool isDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      _saveTheme(isDark);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),   // English
        Locale('ar', ''),   // Arabic
        Locale('hi', ''),   // Hindi
        Locale('gu', ''),   // Gujarati
      ],
      localeResolutionCallback: (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
        // Use deviceLocale if available and supported, otherwise use the first supported locale
        return deviceLocale != null && ['en', 'ar', 'hi', 'gu'].contains(deviceLocale.languageCode)
            ? deviceLocale
            : supportedLocales.first;
      },
      /*home: HomeScreen(
        onThemeChanged: _toggleTheme,
        syncWithSystem: _syncWithSystem,
        onSyncChanged: (value) {
          setState(() {
            _syncWithSystem = value;
          });
        },
      ),*/
      home: SplashScreen(),
    );
  }
}
