import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/data/constants.dart';

class PlayViewModel extends ChangeNotifier {
  PlayViewModel({@required this.sRep});

  final ScoreRepository sRep;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isFinish = false;

  bool get isFinish => _isFinish;

  /// 設定
  Instrument _instrument = Instrument.PIANO;

  Instrument get instrument => _instrument;

  double _paddingSize = 8.0;

  double get paddingSize => _paddingSize;

  double _buttonSize = 60.0;

  double get buttonSize => _buttonSize;

  /// データ
  String _scoreId;

  String get scoreId => _scoreId;

  String _title;

  String get title => _title;

  List<Chord> _chords = [Chord.empty()];

  List<Chord> get chords => _chords;

  /// スコア
  int _currentIndex = 0;

  bool get isCanMoveNext {
    return !(_chords.length - 1 <= _currentIndex);
  }

  bool get isCanMovePrevious {
    return _currentIndex > 0;
  }

  int get currentIndex => _currentIndex;

  Chord get currentChord => _chords[_currentIndex];

  /// 入力
  List<SoundKey> _inputtedKeys = [];

  List<SoundKey> get inputtedKeys => _inputtedKeys;

  /// 処理

  void setScoreId(String scoreId) {
    _scoreId = scoreId;
  }

  Future<void> getScore() async {
    _currentIndex = 0;

    _isFinish = false;

    _isLoading = true;
    notifyListeners();

    final score = await sRep.getScoreById(_scoreId);
    if (score != null) {
      _title = score.title;
      _chords = score.chords;
    } else {
      _title = '';
      _chords = [Chord.empty()];
    }

    print(scoreId);
    print(score);

    _isLoading = false;
    notifyListeners();
  }

  void inputKey(SoundKey soundKey) {
    _inputtedKeys.add(soundKey);

    if (_chords[_currentIndex].allMatch(_inputtedKeys)) {
      if (!isCanMoveNext) {
        _isFinish = true;
        return;
      }
      _inputtedKeys.clear();
      nextChord();
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        _inputtedKeys.remove(soundKey);
      });
    }
  }

  void previousChord() {
    _currentIndex--;
    notifyListeners();
  }

  void nextChord() {
    _currentIndex++;
    notifyListeners();
  }
}
