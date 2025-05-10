import 'package:flutter/material.dart';
import '../time/calendar/landing.dart';
import '../menu.dart';
import '../other/passwords/landing.dart';
import '../math/calculator/landing.dart';

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
          icon: Icon(Icons.watch_later),
          label: 'Time',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.key_outlined),
          label: 'Other',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Math',
        )
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuPage(),
            ), 
            (route) => false,
          );
        }
        break;
      case 1:
        if (context.widget is! CalendarLandingPage) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const CalendarLandingPage(),
            ),
            (route) => false,
          );
        }
        break;
      case 2:
        if (context.widget is! PWMLandingPage) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PWMLandingPage(),
            ),
            (route) => false,
          );
        }
        break;
      case 3:
        if (context.widget is! CalculatorLandingPage) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const CalculatorLandingPage(),
            ),
            (route) => false,
          );
        }
        break;
    }
  }
}

