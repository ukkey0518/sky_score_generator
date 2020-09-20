import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';

class PlayViewModel extends ChangeNotifier {
  PlayViewModel({@required this.sRep});

  final ScoreRepository sRep;
}
