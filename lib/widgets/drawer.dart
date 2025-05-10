import 'package:flutter/material.dart';
import '../time/calendar/landing.dart';
import '../math/calculator/landing.dart';
import '../other/passwords/landing.dart';
import '../time/clock/landing.dart';

class AppDrawer extends StatelessWidget {
  final dynamic category;

  const AppDrawer({
    super.key,
    required this.category,
  });
  @override

  Widget build(BuildContext context) {
    if (category == "Time") {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Text(
                  category,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/calendar') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarLandingPage(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: const Text('Tasks'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: const Text('Clock'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/clock') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClockLandingPage(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: const Text('Stopwatch'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: const Text('Timer'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      );
    }
    else if (category == "Other") {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Text(
                category,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Password Manager'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/passwords') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PWMLandingPage(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: const Text('Random Number Generator'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      );
    }
    else if (category == "Math") {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Text(
                category,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Calculator'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/calculator') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculatorLandingPage(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              title: const Text('Unit Converter'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      );
    }
    else {
      return const SizedBox.shrink();
    }
  }
}