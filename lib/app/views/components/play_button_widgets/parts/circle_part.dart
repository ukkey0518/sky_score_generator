import 'package:flutter/material.dart';

class CirclePart extends StatelessWidget {
  CirclePart({
    @required this.size,
    @required this.color,
    this.duration,
  });

  final double size;
  final Color color;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration ?? const Duration(milliseconds: 50),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(800),
        border: Border.all(color: color, width: 2),
      ),
    );
  }
}
