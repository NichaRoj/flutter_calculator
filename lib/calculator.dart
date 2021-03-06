import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '0';
  String prevResult = '';

  void appendResult(String input) {
    if (['+', '-', '*', '/'].contains(input)) {
      setState(() {
        result += ' ' + input + ' ';
      });
    } else if (result == '0') {
      setState(() {
        result = input;
      });
    } else {
      setState(() {
        result += input;
      });
    }
  }

  void calculate() {
    setState(() {
      prevResult = result;
    });

    var answer = const ExpressionEvaluator().eval(Expression.parse(result), {});

    setState(() {
      var wholeNumber = answer.truncate();
      if (wholeNumber == answer) {
        result = wholeNumber.toString();
      } else {
        var digits = 15 - wholeNumber.toString().length;
        result = answer.toStringAsFixed(digits);
      }
    });
  }

  void reset() {
    setState(() {
      result = '0';
      prevResult = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                alignment: Alignment.topRight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(prevResult,
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 16.0)),
                    FittedBox(
                      child: Text(result,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none)),
                    ),
                    const SizedBox(height: 32.0),
                    CalculatorButtons(
                        onPressed: appendResult,
                        onEqualPressed: calculate,
                        onResetPressed: reset),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

// Credit: 'https://github.com/NichaRoj/flutter_calculator'

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons(
      {Key? key, this.onPressed, this.onEqualPressed, this.onResetPressed})
      : super(key: key);

  final Function? onPressed;
  final Function? onEqualPressed;
  final Function? onResetPressed;

  TextButton buildButton(String value) {
    return TextButton(
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16.0)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white.withOpacity(0.2);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.5);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
        onPressed: () {
          if (value == '=') {
            onEqualPressed!();
          } else if (value == 'AC') {
            onResetPressed!();
          } else {
            onPressed!(value);
          }
        },
        child: Text(value,
            style: const TextStyle(color: Colors.white, fontSize: 24.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            buildButton('7'),
            buildButton('4'),
            buildButton('1'),
            buildButton('0')
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            buildButton('8'),
            buildButton('5'),
            buildButton('2'),
            buildButton('AC')
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            buildButton('9'),
            buildButton('6'),
            buildButton('3'),
            buildButton('=')
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            buildButton('/'),
            buildButton('*'),
            buildButton('-'),
            buildButton('+')
          ],
        ),
      ],
    );
  }
}

// Credit: 'https://github.com/NichaRoj/flutter_calculator'