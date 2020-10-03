import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/components/dialogs/confirm_dialog.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/app/views/edit/pages/chord_edit_page.dart';
import 'package:sky_score_generator/app/views/edit/pages/sort_page.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/main.dart';
import 'package:sky_score_generator/util/functions/unfocus_all.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class EditScreen extends StatefulWidget {
  EditScreen({
    @required this.scoreId,
    @required this.index,
  });

  final String scoreId;
  final int index;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> with TickerProviderStateMixin {
  final DebugLabel _label = DebugLabel.VIEW;
  final String _className = 'ListScreen';

  bool _isChordEditMode = true;

  @override
  void initState() {
    super.initState();

    _isChordEditMode = true;

    final viewModel = Provider.of<EditViewModel>(context, listen: false);
    viewModel.setScoreId(widget.scoreId);
    viewModel.setIndex(widget.index);

    Future(() => viewModel.getScore());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocusAll,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: DraggableFab(
          child: FloatingActionButton(
            child: Icon(_isChordEditMode ? Entypo.swap : FontAwesome.music),
            backgroundColor: Colors.blue.withOpacity(0.4),
            onPressed: _toggleMode,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(image: playBackgroundImage),
          child: Container(
            color: Colors.white30,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Consumer<EditViewModel>(
                    builder: (context, vm, child) {
                      return Row(
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
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(width: 32.0),
                          IconButton(
                            icon: Icon(Icons.save),
                            onPressed:
                                vm.isCanSave ? () => _saveScore(context) : null,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: AnimatedSizeAndFade(
                    vsync: this,
                    alignment: Alignment.center,
                    fadeDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeInOut,
                    fadeOutCurve: Curves.easeInOut,
                    child: _isChordEditMode
                        ? ChordEditPage()
                        : SortPage(
                            onCardSelected: (index) =>
                                _onCardSelected(context, index),
                            deleteChord: (index) =>
                                _deleteChord(context, index),
                            insertChord: (index) =>
                                _insertChord(context, index),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleMode() {
    setState(() {
      _isChordEditMode = !_isChordEditMode;
    });
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

    if (viewModel.isEdited) {
      showDialog(
        context: context,
        builder: (_) => ConfirmDialog(
          title: '編集済みの楽譜は\n保存されていません',
          positiveButtonText: '破棄して戻る',
          negativeButtonText: '編集を続ける',
          onConfirmed: (isConfirmed) {
            if (isConfirmed) {
              Navigator.pop(context, finalIndex);
              viewModel.isEdited = false;
            }
          },
        ),
      );
    } else {
      Navigator.pop(context, finalIndex);
      viewModel.isEdited = false;
    }
  }

  /// カードタップ時
  void _onCardSelected(BuildContext context, int index) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_onCardSelected',
      args: {'index': index},
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.setIndex(index);

    setState(() {
      _toggleMode();
    });
  }

  /// コードを右に挿入する
  void _insertChord(BuildContext context, int index) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_onCardSelected',
      args: {'index': index},
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.insertChordToRight(index);
  }

  /// コードを削除する
  void _deleteChord(BuildContext context, int index) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_deleteChord',
      args: {'index': index},
    );

    final viewModel = context.read<EditViewModel>();

    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        title: 'このコードを削除しますか？',
        onConfirmed: (isConfirmed) {
          if (isConfirmed) {
            viewModel.deleteChord(index);
          }
        },
      ),
    );
  }
}
