import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';

class DatabaseManager {
  final _scoreCollection = Firestore.instance.collection('score');

  Future<void> saveScore(Score score) async {
    await _scoreCollection.document(score.id).setData(score.toMap());
  }
}
