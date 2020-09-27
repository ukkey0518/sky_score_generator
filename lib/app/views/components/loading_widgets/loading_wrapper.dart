import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/views/components/loading_widgets/loading_indicator.dart';

class LoadingWrapper extends StatelessWidget {
  LoadingWrapper({@required this.isLoading, @required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: LoadingIndicator(),
      );
    }
    return child;
  }
}
