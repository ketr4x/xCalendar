import 'package:flutter/material.dart';

import 'calendar/daily.dart';
import 'calendar/monthly.dart';
import 'settings.dart';
import 'widgets/bottom_nav_bar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

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
          "xCalendar",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimary,),
            tooltip: 'Open settings',
            onPressed: () {
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Good ${DateTime.now().weekday == 1 ? 'monday' : DateTime.now().weekday == 2 ? 'tuesday' : DateTime.now().weekday == 3 ? 'wednesday' :
                      DateTime.now().weekday == 4 ? 'thursday' : DateTime.now().weekday == 5 ? 'friday' : DateTime.now().weekday == 6 ? 'saturday' : 'sunday'}, User!",  // TODO: Use the actual user's name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: Theme.of(context).colorScheme.primary,
                    tooltip: 'Add new item',
                    onPressed: () {
                      // TODO: Add functionality to add new item
                    },
                  ),
                ],
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
