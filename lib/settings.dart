import 'package:flutter/material.dart';

import 'calendar/daily.dart';
import 'menu.dart';
import 'widgets/bottom_nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 2; // Uaktualniono indeks, bo Settings jest teraz na pozycji 2

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBar.handleNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(16.0),
              ),
              onPressed: () {
                // TODO: Add dark mode functionality here when implemented
              },
              child: Text('Dark Mode', style:
              TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary
              )
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
