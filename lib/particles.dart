import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

class Particles extends StatefulWidget {
  const Particles({Key? key}) : super(key: key);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  var squares = <Square>[];

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (elapsed.inSeconds > 0 &&
          elapsed.inSeconds % (2 * (squares.length + 1)) == 0) {
        Random random = Random();
        var squareSize = random.nextInt(17).toDouble() + 3;
        var screenSize = MediaQuery.of(context).size;
        var squarePosition = [
          random.nextDouble() * screenSize.width,
          random.nextDouble() * screenSize.height
        ];

        setState(() {
          squares.add(Square(
            squareSize: squareSize,
            position: squarePosition,
            breathe: 2 + random.nextDouble() * squareSize / 2,
            breatheDuration: Duration(seconds: 3 + random.nextInt(2)),
            colorSaturation: random.nextDouble(),
            direction: 2 * pi * random.nextDouble(),
          ));

          if (squares.length > 100) {
            squares.removeAt(0);
          }
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

class Square extends StatefulWidget {
  final double squareSize;
  final List<double> position;
  final double breathe;
  final Duration breatheDuration;
  final double colorSaturation;
  final double direction;

  const Square(
      {Key? key,
      this.squareSize = 20.0,
      this.position = const [0.0, 0.0],
      this.breathe = 5.0,
      this.breatheDuration = const Duration(seconds: 3),
      this.colorSaturation = 0.8,
      this.direction = pi})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<Square> with TickerProviderStateMixin {
  late final Ticker _ticker;
  double currentSize = 0.0;
  double animTracker = 1;
  bool startMoving = false;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((elapsed) {
      // Breathing
      if (currentSize == 0.0) {
        setState(() {
          currentSize = widget.squareSize + widget.breathe;
        });
      } else if (elapsed.inSeconds > 0 &&
          elapsed.inSeconds %
                  (widget.breatheDuration.inSeconds * animTracker) ==
              0) {
        setState(() {
          currentSize = currentSize == widget.squareSize
              ? widget.squareSize + widget.breathe
              : widget.squareSize;
          animTracker++;
        });
      }

      // Movement
      if (!startMoving && elapsed.inMilliseconds > 100) {
        setState(() {
          startMoving = true;
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
      children: [
        AnimatedPositioned(
          duration: const Duration(minutes: 20),
          left: startMoving
              ? widget.position[0] + sin(widget.direction) * 10000
              : widget.position[0],
          top: startMoving
              ? widget.position[1] + cos(widget.direction) * 10000
              : widget.position[1],
          child: AnimatedContainer(
            duration: widget.breatheDuration,
            decoration: BoxDecoration(
                color: Color.alphaBlend(
              const Color(0xFF1976D2).withOpacity(widget.colorSaturation),
              Colors.white,
            )),
            width: currentSize,
            height: currentSize,
            curve: Curves.easeInOutSine,
          ),
        )
      ],
    );
  }
}

// Credit: 'https://github.com/NichaRoj/flutter_calculator'
