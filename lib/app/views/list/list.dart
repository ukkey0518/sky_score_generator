import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/views/components/laoding_indicators/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/edit.dart';
import 'package:sky_score_generator/app/views/list/list_view_model.dart';
import 'package:sky_score_generator/app/views/play/play.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/extensions/extensions_exporter.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListViewModel>(context, listen: false);

    Future(() => viewModel.getScores());

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addScore(context),
          ),
        ],
      ),
      body: Consumer<ListViewModel>(
        builder: (context, vm, child) {
          return LoadingWrapper(
            isLoading: vm.isLoading,
            child: ListView.builder(
              itemCount: vm.scores.length,
              itemBuilder: (context, index) {
                final score = vm.scores[index];
                return ListTile(
                  title: Text(score.title),
                  subtitle:
                      Text(score.createdAt.toFormatStr(DateFormatMode.FULL)),
                  onTap: () => _playScore(context, score),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _addScore(BuildContext context) {
    final viewModel = context.read<ListViewModel>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditScreen(scoreId: null),
      ),
    ).then((_) {
      viewModel.getScores();
    });
  }

  void _playScore(BuildContext context, Score score) {
    final viewModel = context.read<ListViewModel>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayScreen(score: score),
      ),
    ).then((_) {
      viewModel.getScores();
    });
  }
}
