import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/views/components/dialogs/confirm_dialog.dart';
import 'package:sky_score_generator/app/views/components/loading_widgets/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/edit.dart';
import 'package:sky_score_generator/app/views/list/list_view_model.dart';
import 'package:sky_score_generator/app/views/login/components/score_card.dart';
import 'package:sky_score_generator/app/views/play/play.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';
import 'package:sky_score_generator/util/routes/fade_route.dart';

class ListScreen extends StatelessWidget {
  final DebugLabel _label = DebugLabel.VIEW;
  final String _className = 'ListScreen';

  final options = LiveOptions(
    showItemInterval: Duration(milliseconds: 500),
    showItemDuration: Duration(seconds: 1),
    visibleFraction: 0.05,
  );

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ListViewModel>(context, listen: false);

    Future(() => viewModel.getScores());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blue.withOpacity(0.4),
        onPressed: () => _addScore(context),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/list_bg.JPG',
            fit: BoxFit.cover,
          ),
          Consumer<ListViewModel>(
            builder: (context, vm, child) {
              return LoadingWrapper(
                isLoading: vm.isLoading,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: vm.scores.isEmpty
                        ? Center(
                            child: Text(
                              '右下の + ボタンをタップして、作曲してみましょう。',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : LiveList.options(
                            options: options,
                            itemCount: vm.scores.length,
                            itemBuilder: (context, index, animation) {
                              final score = vm.scores[index];
                              return FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation),
                                // And slide transition
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  // Paste you Widget
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 32.0),
                                      ScoreCard(
                                        score: score,
                                        onTap: () => _playScore(context, score),
                                        onLongPress: () =>
                                            _deleteConfirm(context, score),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// スコアの追加(遷移)
  void _addScore(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_addScore',
    );

    final viewModel = context.read<ListViewModel>();

    Navigator.push(
      context,
      FadeRoute(screen: EditScreen(scoreId: null, index: 0)),
    ).then((_) {
      viewModel.getScores();
    });
  }

  /// スコアをプレイ(遷移)
  void _playScore(BuildContext context, Score score) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_playScore',
      args: {'score': score},
    );

    final viewModel = context.read<ListViewModel>();
    Navigator.push(
      context,
      FadeRoute(screen: PlayScreen(score: score)),
    ).then((_) {
      viewModel.getScores();
    });
  }

  /// スコアを削除
  void _deleteConfirm(BuildContext context, Score score) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_deleteConfirm',
      args: {'score': score},
    );

    final viewModel = context.read<ListViewModel>();

    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        title: '楽譜を削除しますか？',
        desc: score.title,
        onConfirmed: (isConfirmed) {
          if (isConfirmed) {
            viewModel.deleteScore(score.id);
          }
        },
      ),
    );
  }
}
