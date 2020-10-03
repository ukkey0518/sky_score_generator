import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:sky_score_generator/app/views/edit/components/mini_chord_card.dart';
import 'package:sky_score_generator/app/views/edit/edit_view_model.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class SortPage extends StatelessWidget {
  SortPage({
    @required this.onCardSelected,
    @required this.insertChord,
    @required this.deleteChord,
  });

  static const DebugLabel _label = DebugLabel.VIEW;
  static const String _className = 'SortPage';

  final ValueChanged<int> onCardSelected;
  final ValueChanged<int> deleteChord;
  final ValueChanged<int> insertChord;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditViewModel>(
      builder: (context, vm, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: ReorderableWrap(
            spacing: 8.0,
            runSpacing: 8.0,
            padding: const EdgeInsets.all(8),
            onReorder: (oldIndex, newIndex) =>
                _onReorder(context, oldIndex, newIndex),
            needsLongPressDraggable: false,
            children: List<Widget>.generate(
              vm.chords.length,
              (index) {
                return MiniChordCard(
                  number: index + 1,
                  chord: vm.chords[index],
                  isCurrent: vm.currentIndex == index,
                  onTap: () => onCardSelected(index),
                  onLongPress: () => deleteChord(index),
                  onInsertRight: () => insertChord(index),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onReorder(BuildContext context, int oldIndex, int newIndex) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: '_onReorder',
    );

    final viewModel = context.read<EditViewModel>();

    viewModel.onSort(
      oldIndex: oldIndex,
      newIndex: newIndex,
    );
  }
}
