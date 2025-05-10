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
      case 2:
        if (context.widget is! PWMLandingPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PWMLandingPage(),
            ),
          );
        }
        break;
      case 3:
        if (context.widget is! CalculatorLandingPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CalculatorLandingPage(),
            ),
          );
        }
        break;
    }
  }
}

