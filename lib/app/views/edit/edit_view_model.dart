import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';

class EditViewModel extends ChangeNotifier {
  EditViewModel({@required this.sRep});

  final ScoreRepository sRep;
}
