import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/drawer.dart';

class CurrencyLandingPage extends StatefulWidget {
  const CurrencyLandingPage({super.key});

  @override
  State<CurrencyLandingPage> createState() => _CurrencyLandingPageState();
}

class _CurrencyLandingPageState extends State<CurrencyLandingPage> {
  int _selectedIndex = 3;

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
          "Currency Converter",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: AppDrawer(category: 'Math'),
      body: Column(
        // TODO: Implement the currency converter UI
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}