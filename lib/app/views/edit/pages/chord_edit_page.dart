import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/app/views/components/loading_widgets/loading_wrapper.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class ChordEditPage extends StatelessWidget {
  final DebugLabel _label = DebugLabel.VIEW;
  static const _className = 'ChordEditPage';

  @override
  Widget build(BuildContext context) {
    return Consumer<EditViewModel>(
      builder: (context, vm, child) {
        return LoadingWrapper(
          isLoading: vm.isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
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
                          _toggleSelectButtonState(context, soundKey),
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
              // const SizedBox(height: 8.0),
              Text(
                '${vm.currentIndex + 1}',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        );
      },
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
}
