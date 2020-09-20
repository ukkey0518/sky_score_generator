import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/database_manageer.dart';

class ScoreRepository {
  ScoreRepository({@required this.dbManager});

  final DatabaseManager dbManager;
}
