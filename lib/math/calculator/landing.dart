import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../widgets/bottom_nav_bar.dart';


class CalculatorLandingPage extends StatefulWidget {
  const CalculatorLandingPage({super.key});

  @override
  State<CalculatorLandingPage> createState() => _CalculatorLandingPageState();
}

class _CalculatorLandingPageState extends State<CalculatorLandingPage> {
  var currentEquation = "0";
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

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
          "Calculator",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currentEquation,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                if ([3, 7, 11, 12, 14, 15].contains(index)) {
                  return ElevatedButton(
                    onPressed: () {
                      buttonPressed(buttons[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }
                else {
                  return ElevatedButton(
                    onPressed: () {
                      buttonPressed(buttons[index]);
                    },
                    child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }
              },
            ),
          ),
        ]
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
  static const List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    'C', '0', '=', '+',
  ];


  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText != "=" && buttonText != "C" && buttonText != "⌫") {
        currentEquation = equation + buttonText;
      }
      if (currentEquation.length > 1 && currentEquation[0] == "0") {
        currentEquation = currentEquation.substring(1);
      }
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        currentEquation = result;
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          currentEquation = result;
        } catch (e) {
          result = "Error";
          currentEquation = result;
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}
