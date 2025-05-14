import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'converter.dart';

class UnitConvertPage extends StatefulWidget {
  final String category;
  final dynamic units;

  const UnitConvertPage({super.key, required this.category, required this.units});

  @override
  State<UnitConvertPage> createState() => _UnitConvertPageState();
}

class _UnitConvertPageState extends State<UnitConvertPage> {
  late String selectedFromUnit;
  late final List<String> units;
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    units = List<String>.from(widget.units);
    selectedFromUnit = units.first ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Convert ${widget.category}",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 8),
            ConvertedButtons(category: widget.category, units: units, selectedFromUnit: selectedFromUnit, value: value,),
          ],
        ),
      ),
    );
  }
}

class ConvertedButtons extends StatefulWidget {
  final String category;
  final List<String> units;
  final String selectedFromUnit;
  final double value;

  const ConvertedButtons({super.key, required this.category, required this.value, required this.units, required this.selectedFromUnit});

  @override
  State<ConvertedButtons> createState() => _ConvertedButtonsState();
}

class _ConvertedButtonsState extends State<ConvertedButtons> {
  late final List<String> units;
  late String selectedFromUnit;
  late double value;
  Map<String, double> conversionResults = {};
  
  @override
  void initState() {
    super.initState();
    units = widget.units;
    selectedFromUnit = widget.selectedFromUnit;
    value = widget.value;
    updateConversion();
  }
  
  @override
  void didUpdateWidget(ConvertedButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value || 
        oldWidget.selectedFromUnit != widget.selectedFromUnit) {
      selectedFromUnit = widget.selectedFromUnit;
      value = widget.value;
      updateConversion();
    }
  }
  
  void updateConversion() {
    var result = Converter()(
      category: widget.category, 
      value: value, 
      selectedFromUnit: selectedFromUnit,
      units: units,
    );
    
    setState(() {
      conversionResults = Map<String, double>.from(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: units.map((unit) {
        if (unit != selectedFromUnit) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        (conversionResults[unit] ?? 0.0).toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: Text(
                        unit,
                        style: TextStyle(color: Theme.of(context).colorScheme.surface)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }
}
