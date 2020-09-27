import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/manager/database_manager.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';
import 'package:uuid/uuid.dart';

class ScoreRepository {
  ScoreRepository({@required this.dbManager});

  final DebugLabel _label = DebugLabel.REPOSITORY;
  final String _className = 'ScoreRepository';

  final DatabaseManager dbManager;

  /// [取得] 全スコア取得
  Future<List<Score>> getAllScores() async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'getAllScores',
    );

    return await dbManager.getAllScores();
  }

  /// [取得] IDに一致するスコア取得
  Future<Score> getScoreById(String scoreId) async {
    return await dbManager.getScoreById(scoreId);
  }

  /// [保存] スコア保存
  Future<void> saveScore({
    String scoreId,
    String title,
    List<Chord> chords,
    DateTime createdAt,
  }) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'saveScore',
      args: {
        'scoreId': scoreId,
        'title': title,
        'chords': chords,
        'createdAt': createdAt,
      },
    );

    final score = Score(
      id: scoreId ?? Uuid().v1(),
      title: title,
      chords: chords,
      createdAt: createdAt ?? DateTime.now(),
    );

    await dbManager.saveScore(score);
  }

  /// [削除] スコア削除
  Future<void> deleteScore(String scoreId) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'deleteScore',
      args: {'scoreId': scoreId},
    );
    await dbManager.deleteScore(scoreId);
  }
}
