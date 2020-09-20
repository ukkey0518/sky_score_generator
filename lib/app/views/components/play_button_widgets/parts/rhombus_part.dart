import 'dart:math' as m;

import 'package:flutter/material.dart';

class RhombusPart extends StatelessWidget {
  RhombusPart({
    @required this.size,
    @required this.color,
    this.duration = const Duration(milliseconds: 50),
  });

  final double size;
  final Color color;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -m.pi / 4,
      child: AnimatedContainer(
        duration: duration,
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color, width: 2),
        ),
      ),
    );
  }
}
