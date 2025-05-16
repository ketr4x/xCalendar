import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                          hintText: 'Enter value',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                        ],
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            setState(() {
                              value = double.tryParse(text) ?? 0.0;
                            });
                          } else {
                            setState(() {
                              value = 0.0;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 1,),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Theme.of(context).colorScheme.surface,
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                            value: selectedFromUnit,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.primary,),
                            selectedItemBuilder: (BuildContext context) {
                              return units.map<Widget>((String value) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSecondary,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: units.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedFromUnit = newValue;
                                });
                              }
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),

    );
  }
}