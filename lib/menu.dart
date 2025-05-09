import 'package:flutter/material.dart';
import 'settings.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "xCalendar",
          style:  TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.settings),
            tooltip: 'Go to Settings',
            onPressed: () {
              // Navigate to the settings page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          spacing: 20,
          children: <Widget>[
            Text(
              'Welcome to xCalendar!',
              style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
