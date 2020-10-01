import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/manager/database_manager.dart';

class AssetsRepository {
  AssetsRepository({@required this.dbManager});

  final DatabaseManager dbManager;
}
