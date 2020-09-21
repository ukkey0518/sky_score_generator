import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';

class ListViewModel extends ChangeNotifier {
  ListViewModel({@required this.sRep});

  final ScoreRepository sRep;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Score> _scores = [];

  List<Score> get scores => _scores;

  Future<void> getScores() async {
    _isLoading = true;
    notifyListeners();

    _scores = await sRep.getAllScores();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteScore(String scoreId) async {
    _isLoading = true;
    notifyListeners();

    await sRep.deleteScore(scoreId);
    _scores = await sRep.getAllScores();

    _isLoading = false;
    notifyListeners();
  }
}
