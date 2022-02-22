// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './calculator.dart';
import './background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Container(child: RandomCanvas()),
      const Calculator()
    ]);
  }
}

class RandomCanvas extends StatefulWidget {
  const RandomCanvas({Key? key}) : super(key: key);

  @override
  _RandomCanvasState createState() => _RandomCanvasState();
}

class _RandomCanvasState extends State<RandomCanvas>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  var squares = <Square>[];

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (elapsed.inSeconds > 0 && elapsed.inSeconds % (3 * (squares.length + 1)) == 0  && squares.length < 50) {
        Random random = Random();
        var squareSize = random.nextInt(20).toDouble() + 5;
        var screenSize = MediaQuery.of(context).size;
        var width = screenSize.width;
        var height = screenSize.height;
        var squarePosition = [
          random.nextDouble() * width,
          random.nextDouble() * height
        ];

        setState(() {
          squares.add(Square(
            squareSize: squareSize,
            position: squarePosition,
          ));
        });

      }
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: squares,
    );
  }
}

class Square extends StatelessWidget {
  const Square(
      {Key? key, this.squareSize = 1.0, this.position = const [0.0, 0.0]})
      : super(key: key);

  final double squareSize;
  final List<double> position;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: RandomPainter(
            position: Offset(position[0], position[1]),
            squareSize: squareSize));
  }
}

class RandomPainter extends CustomPainter {
  Offset position;
  double squareSize;

  RandomPainter(
      {this.position = const Offset(0.0, 0.0), this.squareSize = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint()
      ..color = const Color(0xFF1976D2)
      ..style = PaintingStyle.fill;

    canvas.drawRect(position & Size(squareSize, squareSize), brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
