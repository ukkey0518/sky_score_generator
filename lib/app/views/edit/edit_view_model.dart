import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/data/util_classes/audio_controller.dart';
import 'package:sky_score_generator/data/util_classes/sound_path.dart';
import 'package:sky_score_generator/util/log/debug_log.dart';

class EditViewModel extends ChangeNotifier {
  EditViewModel({@required this.sRep});

  final DebugLabel _label = DebugLabel.VIEW_MODEL;
  final String _className = 'EditViewModel';

  final ScoreRepository sRep;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// 設定
  Instrument _instrument = Instrument.PIANO;

  Instrument get instrument => _instrument;

  double _paddingSize = 8.0;

  double get paddingSize => _paddingSize;

  double _buttonSize = 65.0;

  double get buttonSize => _buttonSize;

  /// データ
  String _scoreId;

  String get scoreId => _scoreId;

  TextEditingController _titleController = TextEditingController();

  TextEditingController get titleController => _titleController;

  List<Chord> _chords = [Chord.empty()];

  List<Chord> get chords => _chords;

  DateTime _createdAt;

  /// スコア
  int _currentIndex = 0;

  bool get isCanMovePrevious {
    return _currentIndex > 0;
  }

  bool get isCanSave {
    if (isLoading) {
      return false;
    }

    final formattedChords = _chords.where((chord) => chord.isSetAny()).toList();
    final isAllEmpty = formattedChords.every((chord) => !chord.isSetAny());
    final isFewCodes = formattedChords.length < 3;

    return !(isAllEmpty || isFewCodes);
  }

  int get currentIndex => _currentIndex;

  Chord get currentChord {
    if (_chords.length == 1 && !_chords[0].isSetAny()) {
      return Chord.empty();
    }
    return _chords[_currentIndex];
  }

  /// インデックスのセット
  void setIndex(int index) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'setIndex',
      args: {'index': index},
    );

    _currentIndex = index;
  }

  /// スコアIDのセット
  void setScoreId(String scoreId) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'setScoreId',
      args: {'scoreId': scoreId},
    );

    _scoreId = scoreId;
  }

  /// スコアの取得
  Future<void> getScore() async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'getScore',
    );

    _isLoading = true;
    notifyListeners();

    final score = await sRep.getScoreById(_scoreId);
    if (score != null) {
      _titleController.text = score.title;
      _chords = score.chords;
      _createdAt = score.createdAt;
    } else {
      _titleController.text = 'New Score';
      _chords = [Chord.empty()];
    }

    await AudioController.loadAll(SoundPath.fileNames);

    _isLoading = false;
    notifyListeners();
  }

  /// スコアの保存
  Future<void> saveScore() async {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'saveScore',
    );

    _isLoading = true;
    notifyListeners();

    await sRep.saveScore(
      scoreId: _scoreId,
      title: titleController.text,
      chords: _chords,
      createdAt: _createdAt,
    );

    _isLoading = false;
    notifyListeners();
  }

  /// キー選択状態の変更
  void toggleSelectButtonState(SoundKey soundKey) {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'toggleSelectButtonState',
      args: {'soundKey': soundKey},
    );

    _chords[_currentIndex].toggleSound(soundKey);
    notifyListeners();
  }

  /// 前のコードへ
  void previousChord() {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'previousChord',
    );

    _currentIndex--;
    notifyListeners();
  }

  /// 次のコードへ
  void nextChord() {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'nextChord',
    );

    _currentIndex++;
    if (_chords.length <= _currentIndex) {
      _chords.add(Chord.empty());
    }
    notifyListeners();
  }

  /// 保存前のフォーマット処理(空入力コード間引き)
  void format() {
    DebugLog.add(
      label: _label,
      className: _className,
      name: 'format',
    );

    final emptyChords = _chords.where((chord) => !chord.isSetAny());
    emptyChords.forEach((chord) {
      if (_currentIndex > _chords.indexOf(chord)) {
        _currentIndex--;
      }
    });

    _chords = _chords.where((chord) => chord.isSetAny()).toList();
    notifyListeners();
  }
}
