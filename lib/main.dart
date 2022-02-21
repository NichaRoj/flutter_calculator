// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Welcome to Flutter', home: Calculator());
  }
}

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

    var inputs = result.split(' ');
    var answer = 0.0;

    for (int i = 0; i < inputs.length; i++) {
      if (i == 0) {
        answer += double.parse(inputs[i]);
      } else {
        switch (inputs[i]) {
          case '+':
            {
              answer += double.parse(inputs[i + 1]);
            }
            break;
          case '-':
            {
              answer -= double.parse(inputs[i + 1]);
            }
            break;
          case '*':
            {
              answer *= double.parse(inputs[i + 1]);
            }
            break;
          case '/':
            {
              answer /= double.parse(inputs[i + 1]);
            }
            break;
          default:
            {
              break;
            }
        }
      }
    }

    setState(() {
      result = answer.toInt() == answer
          ? answer.toInt().toString()
          : answer.toString();
    });
  }

  void reset() {
    setState(() {
      result = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Text(
              prevResult,
            ),
            Text(
              result,
            ),
            CalculatorButtons(onPressed: appendResult,
                onEqualPressed: calculate,
                onResetPressed: reset)
          ],
        ));
  }
}

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({
    Key? key,
    this.onPressed,
    this.onEqualPressed,
    this.onResetPressed
  }) : super(key: key);

  final Function? onPressed;
  final Function? onEqualPressed;
  final Function? onResetPressed;

  TextButton buildButton(String value) {
    return TextButton(
        onPressed: () {
          if (value == '=') {
            onEqualPressed!();
          } else if (value == 'AC') {
            onResetPressed!();
          } else {
            onPressed!(value);
          }
        },
        child: Text(value));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            buildButton('7'),
            buildButton('4'),
            buildButton('1'),
            buildButton('0')
          ],
        ),
        Column(
          children: [
            buildButton('8'),
            buildButton('5'),
            buildButton('2'),
            buildButton('AC')
          ],
        ),
        Column(
          children: [
            buildButton('9'),
            buildButton('6'),
            buildButton('3'),
            buildButton('=')
          ],
        ),
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
