import 'package:flutter/material.dart';
import '../calendar/daily.dart';
import '../calendar/monthly.dart';
import '../menu.dart';
import '../settings.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Monthly',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      onTap: onItemTapped,
    );
  }

  // Helper method for navigation
  static void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (context.widget is! MenuPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuPage(),
            ),
          );
        }
        break;
      case 1:
        if (context.widget is! DailyPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DailyPage(),
            ),
          );
        }
        break;
      case 2:
        if (context.widget is! MonthlyPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MonthlyPage(),
            ),
          );
        }
        break;
      case 3:
        if (context.widget is! SettingsPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            ),
          );
        }
        break;
    }
  }
}
