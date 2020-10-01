import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/repositories/assets_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({@required this.aRep});

  final AssetsRepository aRep;
}
