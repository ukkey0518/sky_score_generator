import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum LoadingIndicatorType {
  CUBE,
  CIRCLE,
  DOTS,
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({
    this.type = LoadingIndicatorType.CUBE,
    this.color,
    this.size = 50.0,
  });

  final LoadingIndicatorType type;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).primaryColorLight;

    var indicator;
    switch (type) {
      case LoadingIndicatorType.CUBE:
        indicator = SpinKitCubeGrid(
          color: indicatorColor,
          size: size,
        );
        break;
      case LoadingIndicatorType.CIRCLE:
        indicator = SpinKitCircle(
          color: indicatorColor,
          size: size,
        );
        break;
      case LoadingIndicatorType.DOTS:
        indicator = SpinKitChasingDots(
          color: indicatorColor,
          size: size,
        );
        break;
    }
    return Center(
      child: indicator,
    );
  }
}
