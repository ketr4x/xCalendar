import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class PWMLandingPage extends StatefulWidget {
  const PWMLandingPage({super.key});

  @override
  State<PWMLandingPage> createState() => _PWMLandingPageState();
}

class _PWMLandingPageState extends State<PWMLandingPage> {
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
          "Password Manager",
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
