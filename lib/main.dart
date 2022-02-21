// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import './calculator.dart';

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

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          alignment: Alignment.topRight,
          color: isDarkMode ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 0.0),
                    side: const BorderSide(width: 2.0, color: Colors.grey)),
                child:
                    isDarkMode ? const Icon(Icons.nights_stay, color: Colors.grey,) : const Icon(Icons.wb_sunny, color: Colors.grey,),
                onPressed: () {
                  setState(() {
                    if (isDarkMode) {
                      isDarkMode = false;
                    } else {
                      isDarkMode = true;
                    }
                  });
                }),
          )),
      const Calculator()
    ]);
  }
}
