import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class ListViewModel extends ChangeNotifier {
  ListViewModel({@required this.sRep});

  final DebugLabel _label = DebugLabel.VIEW_MODEL;
  final String _className = 'ListViewModel';

  final ScoreRepository sRep;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Score> _scores = [];

  List<Score> get scores => _scores;

  /// スコアリスト取得
  Future<void> getScores() async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'getScores',
    );

    _isLoading = true;
    notifyListeners();

    _scores = await sRep.getAllScores();

    _isLoading = false;
    notifyListeners();
  }

  /// スコア削除
  Future<void> deleteScore(String scoreId) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'deleteScore',
      args: {'scoreId': scoreId},
    );

    _isLoading = true;
    notifyListeners();

    await sRep.deleteScore(scoreId);
    _scores = await sRep.getAllScores();

    _isLoading = false;
    notifyListeners();
  }
}
