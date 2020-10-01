import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/app/views/components/loading_widgets/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/edit.dart';
import 'package:sky_score_generator/app/views/play/play_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/main.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';
import 'package:sky_score_generator/util/routes/fade_route.dart';

class PlayScreen extends StatelessWidget {
  PlayScreen({@required this.score});

  final Score score;

  final DebugLabel _label = DebugLabel.VIEW;
  final String _className = 'ListScreen';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlayViewModel>(context, listen: false);
    viewModel.setIndex(0);
    viewModel.setScoreId(score.id);

    Future(() => viewModel.getScore());

    return Consumer<PlayViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            decoration: BoxDecoration(image: playBackgroundImage),
            child: LoadingWrapper(
              isLoading: vm.isLoading,
              child: Container(
                color: Colors.white30,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 32.0),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: vm.isLoading
                                  ? Text('', style: TextStyle(fontSize: 18))
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          vm.title ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          '[${vm.currentIndex + 1}]',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(width: 32.0),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editScore(
                              context,
                              vm.scoreId,
                              vm.currentIndex,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: vm.isCanMovePrevious
                                  ? () => _previous(context)
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: KeyBoard(
                              chord: vm.currentChord,
                              instrument: vm.instrument,
                              buttonSize: vm.buttonSize,
                              paddingSize: vm.paddingSize,
                              onPlayed: (soundKey) =>
                                  _inputKey(context, soundKey),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: vm.isCanMoveNext
                                  ? () => _next(context)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// キーのタップ
  void _inputKey(BuildContext context, SoundKey soundKey) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_inputKey',
      args: {'soundKey': soundKey},
    );

    final viewModel = context.read<PlayViewModel>();

    viewModel.inputKey(soundKey);
    if (viewModel.isFinish) {
      Navigator.pop(context);
    }
  }

  /// スコアの編集(遷移)
  void _editScore(BuildContext context, String scoreId, int currentIndex) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_editScore',
      args: {
        'scoreId': scoreId,
        'currentIndex': currentIndex,
      },
    );

    final viewModel = context.read<PlayViewModel>();

    Navigator.push(
      context,
      FadeRoute(
        screen: EditScreen(
          scoreId: scoreId,
          index: currentIndex,
        ),
      ),
    ).then((index) {
      print(index);
      viewModel.setIndex(index);
      viewModel.getScore();
    });
  }

  /// 前のコードへ
  void _previous(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_previous',
    );

    final viewModel = context.read<PlayViewModel>();

    viewModel.previousChord();
  }

  /// 次のコードへ
  void _next(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_next',
    );

    final viewModel = context.read<PlayViewModel>();

    viewModel.nextChord();
  }
}
