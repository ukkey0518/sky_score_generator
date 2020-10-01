import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/components/dialogs/confirm_dialog.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/app/views/components/loading_widgets/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/main.dart';
import 'package:sky_score_generator/util/functions/unfocus_all.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class EditScreen extends StatelessWidget {
  EditScreen({
    @required this.scoreId,
    @required this.index,
  });

  final String scoreId;
  final int index;

  final DebugLabel _label = DebugLabel.VIEW;
  final String _className = 'ListScreen';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditViewModel>(context, listen: false);
    viewModel.setScoreId(scoreId);
    viewModel.setIndex(index);

    Future(() => viewModel.getScore());

    return GestureDetector(
      onTap: unFocusAll,
      child: Scaffold(
        body: Consumer<EditViewModel>(
          builder: (context, vm, child) {
            return Scaffold(
              body: Container(
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
                                onPressed: () => _finishScreen(context),
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
                                            SizedBox(
                                              width: 100,
                                              child: CupertinoTextField(
                                                controller: vm.titleController,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                                maxLines: 1,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(
                                              '${vm.currentIndex + 1} ページ目',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(width: 32.0),
                              IconButton(
                                icon: Icon(Icons.save),
                                onPressed: vm.isCanSave
                                    ? () => _saveScore(context)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                    ),
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
                                        _toggleSelectButtonState(
                                            context, soundKey),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                    onPressed: () => _next(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// キーの選択状態を切り替え
  void _toggleSelectButtonState(BuildContext context, SoundKey soundKey) async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_toggleSelectButtonState',
      args: {'soundKey': soundKey},
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.toggleSelectButtonState(soundKey);
  }

  /// スコアの保存
  void _saveScore(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_saveScore',
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.format();

    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        title: '保存しますか？',
        onConfirmed: (isConfirmed) async {
          if (isConfirmed) {
            await viewModel.saveScore();
            Navigator.pop(context, viewModel.currentIndex);
          }
        },
      ),
    );
  }

  /// 前のコードへ
  void _previous(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_previous',
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.previousChord();
  }

  /// 次のコードへ
  void _next(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_next',
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.nextChord();
  }

  /// 画面の終了
  void _finishScreen(BuildContext context) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_finishScreen',
    );

    final viewModel = context.read<EditViewModel>();
    final finalIndex = viewModel.currentIndex;
    viewModel.setIndex(0);

    Navigator.pop(context, finalIndex);
  }
}
