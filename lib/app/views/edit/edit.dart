import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/app/views/components/laoding_indicators/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/components/title_name_input_dialog.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';

class EditScreen extends StatelessWidget {
  EditScreen({@required this.scoreId});

  final String scoreId;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditViewModel>(context, listen: false);
    viewModel.setId(scoreId);

    Future(() => viewModel.getScore());

    return Scaffold(
      body: Consumer<EditViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${vm.title} : ${vm.currentIndex + 1} ページ目'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: vm.isCanSave ? () => _saveScore(context) : null,
                ),
              ],
            ),
            body: LoadingWrapper(
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
                      height: double.infinity,
                      width: double.infinity,
                      buttonSize: vm.buttonSize,
                      paddingSize: vm.paddingSize,
                      onPlayed: (soundKey) =>
                          _toggleSelectButtonState(context, soundKey),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => _next(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggleSelectButtonState(BuildContext context, SoundKey soundKey) async {
    final viewModel = context.read<EditViewModel>();

    viewModel.toggleSelectButtonState(soundKey);
  }

  void _previous(BuildContext context) {
    final viewModel = context.read<EditViewModel>();

    viewModel.previousChord();
  }

  void _next(BuildContext context) {
    final viewModel = context.read<EditViewModel>();

    viewModel.nextChord();
  }

  void _saveScore(BuildContext context) {
    final viewModel = context.read<EditViewModel>();

    viewModel.format();

    showDialog(
      context: context,
      builder: (_) => TitleNameSetDialog(
        onConfirmed: (title) async {
          await viewModel.saveScore(title);
          Navigator.pop(context);
        },
      ),
    );
  }
}
