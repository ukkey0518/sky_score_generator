import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/database_manager.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:uuid/uuid.dart';

class ScoreRepository {
  ScoreRepository({@required this.dbManager});

  final DatabaseManager dbManager;

  Future<Score> getScoreById(String scoreId) async {
    return await dbManager.getScoreById(scoreId);
  }

  Future<void> saveScore({
    String scoreId,
    String title,
    List<Chord> chords,
    DateTime createdAt,
  }) async {
    final score = Score(
      id: scoreId ?? Uuid().v1(),
      title: title,
      chords: chords,
      createdAt: createdAt ?? DateTime.now(),
    );

    await dbManager.saveScore(score);
  }

  Future<List<Score>> getAllScores() async {
    return await dbManager.getAllScores();
  }

  Future<void> deleteScore(String scoreId) async {
    await dbManager.deleteScore(scoreId);
  }
}
