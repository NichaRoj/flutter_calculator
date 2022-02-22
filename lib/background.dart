import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './particles.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  final _url = 'https://github.com/NichaRoj/flutter_calculator';
  var isDarkMode = true;

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        color: isDarkMode ? Colors.black : Colors.white,
        child: Stack(
          children: [
            const Particles(),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 0.0),
                            side: BorderSide.none),
                        child: const Text('github',
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Colors.grey)),
                        onPressed: () {
                          _launchURL();
                        }),
                    const SizedBox(width: 16.0),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 0.0),
                            side: const BorderSide(
                                width: 2.0, color: Colors.grey)),
                        child: isDarkMode
                            ? const Icon(
                                Icons.nights_stay,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.wb_sunny,
                                color: Colors.grey,
                              ),
                        onPressed: () {
                          setState(() {
                            if (isDarkMode) {
                              isDarkMode = false;
                            } else {
                              isDarkMode = true;
                            }
                          });
                        }),
                  ],
                ))
          ],
        ));
  }
}

// Credit: 'https://github.com/NichaRoj/flutter_calculator'
