import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWrapper extends StatelessWidget {
  LoadingWrapper({@required this.isLoading, @required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SpinKitCubeGrid(color: Theme.of(context).primaryColorLight),
      );
    }
    return child;
  }
}
