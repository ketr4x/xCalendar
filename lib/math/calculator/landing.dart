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
              padding: const EdgeInsets.all(10.0),
              child: Text(
                currentEquation,
                style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    buildButtonRow(['7', '8', '9', '/'], 0),
                    buildButtonRow(['4', '5', '6', '*'], 4),
                    buildButtonRow(['1', '2', '3', '-'], 8),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      buildButton('C', 12),
                                      buildButton('0', 13),
                                      buildButton('.', 14),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      buildButton('%', 16),
                                      buildButton('⌫', 17),
                                      buildButton('=', 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              child: ElevatedButton(
                                onPressed: () => buttonPressed('+'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const SizedBox(
                                  height: double.infinity,
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style: TextStyle(fontSize: 42),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget buildButtonRow(List<String> rowButtons, int startIndex) {
    return Expanded(
      child: Row(
        children: rowButtons.asMap().entries.map((entry) {
          int buttonIndex = startIndex + entry.key;
          return buildButton(entry.value, buttonIndex);
        }).toList(),
      ),
    );
  }

  Widget buildButton(String text, int index) {
    bool isOperator = [3, 7, 11, 15, 16, 17, 18].contains(index);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator ? Theme.of(context).colorScheme.primary : null,
            foregroundColor: isOperator ? Theme.of(context).colorScheme.onPrimary : null,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            minimumSize: const Size(80, 80),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }


  void discardComma() {
    setState(() {
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
    });
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText != "=" && buttonText != "C" && buttonText != "⌫" && buttonText != "%") {
        currentEquation = equation + buttonText;
      }
      if (currentEquation.length > 1 && currentEquation[0] == "0" && currentEquation[1] != '.') {
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
        currentEquation = equation;
      } else if (buttonText == "%") {
        if (equation != "0") {
          double value = double.parse(equation) / 100;
          equation = value.toString();
          currentEquation = equation;
        }
      } else if (buttonText == "=") {
        expression = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          discardComma();
          currentEquation = result;
          equation = result;
        } catch (e) {
          result = "Error";
          currentEquation = result;
          equation = "0";
        }
      } else {
        if (equation == "0" && buttonText != ".") {
          equation = buttonText;
        } else if (equation == "0" && buttonText == ".") {
          equation = equation + buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}