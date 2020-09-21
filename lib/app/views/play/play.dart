import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/app/views/components/laoding_indicators/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/play/play_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';

class PlayScreen extends StatelessWidget {
  PlayScreen({@required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PlayViewModel>(context, listen: false);
    viewModel.setScoreId(score.id);

    Future(() => viewModel.getScore());

    return Consumer<PlayViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: vm.isLoading
                ? Container()
                : Text('${vm.title ?? ''} : ${vm.currentIndex + 1} ページ目'),
          ),
          body: Center(
            child: LoadingWrapper(
              isLoading: vm.isLoading,
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
                      onPlayed: (soundKey) => _inputKey(context, soundKey),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: vm.isCanMoveNext ? () => _next(context) : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _previous(BuildContext context) {
    final viewModel = context.read<PlayViewModel>();

    viewModel.previousChord();
  }

  void _next(BuildContext context) {
    final viewModel = context.read<PlayViewModel>();

    viewModel.nextChord();
  }

  void _inputKey(BuildContext context, SoundKey soundKey) {
    final viewModel = context.read<PlayViewModel>();

    viewModel.inputKey(soundKey);
    if (viewModel.isFinish) {
      Navigator.pop(context);
    }
  }
}
