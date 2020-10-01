import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/extensions/extensions_exporter.dart';

class ScoreCard extends StatelessWidget {
  ScoreCard({
    @required this.score,
    @required this.onTap,
    @required this.onLongPress,
  });

  final Score score;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      // borderRadius: BorderRadius.circular(100),
      color: Colors.black54,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          width: 500,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                score.title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.yellow[100],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                score.createdAt.toFormatStr(DateFormatMode.FULL),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.yellow[100],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
