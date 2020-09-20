import 'package:flutter/material.dart';

class BackgroundPart extends StatelessWidget {
  BackgroundPart({
    @required this.size,
    @required this.backgroundColor,
    this.duration,
  });

  final double size;
  final Color backgroundColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration ?? const Duration(milliseconds: 50),
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: backgroundColor,
      ),
    );
  }
}
