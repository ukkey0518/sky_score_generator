import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/data/util_classes/audio_controller.dart';
import 'package:sky_score_generator/data/util_classes/sound_path.dart';

class EditViewModel extends ChangeNotifier {
  EditViewModel({@required this.sRep});

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

  void setIndex(int index) {
    _currentIndex = index;
  }

  void setId(String scoreId) {
    _scoreId = scoreId;
  }

  Future<void> getScore() async {
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

  Future<void> saveScore() async {
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

  void toggleSelectButtonState(SoundKey soundKey) {
    _chords[_currentIndex].toggleSound(soundKey);
    notifyListeners();
  }

  void previousChord() {
    _currentIndex--;
    notifyListeners();
  }

  void nextChord() {
    _currentIndex++;
    if (_chords.length <= _currentIndex) {
      _chords.add(Chord.empty());
    }
    notifyListeners();
  }

  void format() {
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
