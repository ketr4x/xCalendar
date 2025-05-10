import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class ClockLandingPage extends StatefulWidget {
  const ClockLandingPage({super.key});

  @override
  State<ClockLandingPage> createState() => _ClockLandingPageState();
}

class _ClockLandingPageState extends State<ClockLandingPage> {
  int _selectedIndex = 2;

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
          "Clock",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(

      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
