import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';

class DatabaseManager {
  final _scoreCollection = FirebaseFirestore.instance.collection('score');

  Future<void> saveScore(Score score) async {
    await _scoreCollection.doc(score.id).set(score.toMap());
  }

  Future<List<Score>> getAllScores() async {
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

  Future<Score> getScoreById(String scoreId) async {
    final document = await _scoreCollection.doc(scoreId).get();

    if (document == null || document.data == null) {
      return null;
    }

    return Score.fromMap(document.data());
  }

  Future<void> deleteScore(String scoreId) async {
    await _scoreCollection.doc(scoreId).delete();
  }
}
