import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sky_score_generator/app/models/manager/database_manager.dart';
import 'package:sky_score_generator/app/repositories/assets_repository.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/app/views/list/list_view_model.dart';
import 'package:sky_score_generator/app/views/login/login_view_model.dart';
import 'package:sky_score_generator/app/views/play/play_view_model.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider(
    create: (_) => DatabaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, ScoreRepository>(
    update: (_, db, rep) => ScoreRepository(dbManager: db),
  ),
  ProxyProvider<DatabaseManager, AssetsRepository>(
    update: (_, db, rep) => AssetsRepository(dbManager: db),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      aRep: context.read<AssetsRepository>(),
    ),
  ),
  ChangeNotifierProvider<ListViewModel>(
    create: (context) => ListViewModel(
      sRep: context.read<ScoreRepository>(),
    ),
  ),
  ChangeNotifierProvider<PlayViewModel>(
    create: (context) => PlayViewModel(
      sRep: context.read<ScoreRepository>(),
    ),
  ),
  ChangeNotifierProvider<EditViewModel>(
    create: (context) => EditViewModel(
      sRep: context.read<ScoreRepository>(),
    ),
  ),
];
