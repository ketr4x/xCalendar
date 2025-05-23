import 'package:flutter/material.dart';
import 'package:xcalendar/time/calendar/weekly.dart';
import '../../settings.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'daily.dart';
import 'monthly.dart';
import 'events.dart';
import '../../widgets/drawer.dart';

class CalendarLandingPage extends StatefulWidget {
  const CalendarLandingPage({super.key});

  @override
  State<CalendarLandingPage> createState() => _CalendarLandingPageState();
}

class _CalendarLandingPageState extends State<CalendarLandingPage> {
  int _selectedIndex = 1;

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_view_week_outlined),
            tooltip: 'Weekly View',
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeeklyPage(),
                ),
              );
            },
          ),
        ],
        title: Text(
          "Calendar",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: AppDrawer(category: 'Time'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: MonthlyScreen(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageEventsPage(),
                        ),
                      );
                    },
                    child: const Text('Manage Events'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
