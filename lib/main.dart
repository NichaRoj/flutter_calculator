// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
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

class _RandomCanvasState extends State<RandomCanvas> {
  var squares = <Square>[];

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      Random random = Random();
      var squareSize = random.nextInt(50).toDouble();
      var screenSize = MediaQuery.of(context).size;
      var width = screenSize.width;
      var height = screenSize.height;
      var squarePosition =
          Offset(random.nextDouble() * width, random.nextDouble() * height);

      setState(() {
        squares.add(Square(
          squareSize: squareSize,
          position: squarePosition,
        ));
      });

      if (squares.length <= 50) {
        timer.cancel();
      }
    });

    return Stack(
      children: squares,
    );
  }
}

class Square extends StatelessWidget {
  const Square(
      {Key? key, this.squareSize = 1.0, this.position = const Offset(0.0, 0.0)})
      : super(key: key);

  final double squareSize;
  final Offset position;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: RandomPainter(position: position, squareSize: squareSize));
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
