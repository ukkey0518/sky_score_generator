import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class DatabaseManager {
  final DebugLabel _label = DebugLabel.MANAGER;
  final String _className = 'DatabaseManager';

  final CollectionReference _scoreCollection =
      FirebaseFirestore.instance.collection('score');

  /// [取得] 全スコアの取得
  Future<List<Score>> getAllScores() async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'getAllScores',
    );

    final snapshot = await _scoreCollection.get();

    if (snapshot.docs.isEmpty) {
      return <Score>[];
    }

    final scores = <Score>[];
    snapshot.docs.forEach((document) {
      scores.add(Score.fromMap(document.data()));
    });

    return scores;
  }

  /// [取得] IDに一致するスコアを取得
  Future<Score> getScoreById(String scoreId) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'getScoreById',
      args: {'scoreId': scoreId},
    );

    final document = await _scoreCollection.doc(scoreId).get();

    if (document == null || document.data() == null) {
      return null;
    }

    return Score.fromMap(document.data());
  }

  /// [保存] スコアの保存
  Future<void> saveScore(Score score) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'saveScore',
      args: {'score': score},
    );

    await _scoreCollection.doc(score.id).set(score.toMap());
  }

  /// [削除] スコアの削除
  Future<void> deleteScore(String scoreId) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'deleteScore',
      args: {'scoreId': scoreId},
    );

    await _scoreCollection.doc(scoreId).delete();
  }
}
