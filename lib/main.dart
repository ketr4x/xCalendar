import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'xCalendar',
        theme: theme,
        darkTheme: darkTheme,
        home: const LaunchHandler(),
      ),
    );
  }
}
class LaunchHandler extends StatefulWidget {
  const LaunchHandler({super.key});

  @override
  State<LaunchHandler> createState() => _LaunchHandlerState();
}

class _LaunchHandlerState extends State<LaunchHandler> {
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (firstLaunch) {
      await prefs.setBool('firstLaunch', false);
    }
    return firstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return const MenuPage(); // TODO: Change to SetupPage() after implementing setup
        } else {
          return const MenuPage();
        }
      },
    );
  }
}
