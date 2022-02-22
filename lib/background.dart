import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  var isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
