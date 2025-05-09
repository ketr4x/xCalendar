import 'package:flutter/material.dart';
import '../calendar/landing.dart';
import '../menu.dart';

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
          label: 'Calendar',
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
        if (context.widget is! CalendarLandingPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CalendarLandingPage(),
            ),
          );
        }
        break;
    }
  }
}

