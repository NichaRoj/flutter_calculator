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
          elapsed.inSeconds % (3 * (squares.length + 1)) == 0 &&
          squares.length < 50) {
        Random random = Random();
        var squareSize = random.nextInt(20).toDouble() + 5;
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
            breatheDuration: Duration(seconds: 2 + random.nextInt(3))
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

class Square extends StatefulWidget {
  final double squareSize;
  final List<double> position;
  final double breathe;
  final Duration breatheDuration;

  const Square(
      {Key? key,
      this.squareSize = 20.0,
      this.position = const [0.0, 0.0],
      this.breathe = 5.0,
      this.breatheDuration = const Duration(seconds: 3)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<Square> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double currentSize = 0.0;
  double animTracker = 1;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (currentSize == 0.0) {
        setState(() {
          currentSize = widget.squareSize;
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
    return Positioned(
        left: widget.position[0],
        top: widget.position[1],
        child: AnimatedContainer(
          duration: widget.breatheDuration,
          decoration: const BoxDecoration(color: Color(0xFF1976D2)),
          width: currentSize,
          height: currentSize,
          curve: Curves.easeInOutSine,
        ));
  }
}
