import 'package:flutter/material.dart';

class UnitConvertPage extends StatefulWidget {
  final String category;

  const UnitConvertPage({super.key, required this.category});

  @override
  State<UnitConvertPage> createState() => _UnitConvertPageState();
}

class _UnitConvertPageState extends State<UnitConvertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Calculate ${widget.category}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}