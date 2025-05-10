import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdaptiveTheme.of(context).toggleThemeMode();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
    );
  }
}
