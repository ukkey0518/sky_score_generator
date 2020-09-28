import 'dart:typed_data';

import 'package:sky_score_generator/data/constants.dart';

class Chord {
  Chord(this._chord);

  Chord.empty() : this._chord = Uint8List.fromList(List.generate(15, (_) => 0));

  Uint8List _chord = Uint8List.fromList(List.generate(15, (_) => 0));

  Uint8List get chord => _chord;

  /// 選択状態の切り替え
  void toggleState(SoundKey soundKey) {
    final index = soundKey.index;
    _chord[index] = _chord[index] == 1 ? 0 : 1;
  }

  /// 有効状態をチェック
  bool checkEnabled(SoundKey soundKey) {
    return _chord[soundKey.index] == 1;
  }

  /// 空のコードかどうかを判定
  bool isEmpty() {
    return _chord.every((byte) => byte == 0);
  }

  /// 渡されたサウンドキーリストと位置するかを判定
  bool allMatch(List<SoundKey> soundKeys) {
    final List<SoundKey> chordSounds = [];

    for (int i = 0; i < 15; i++) {
      if (_chord[i] == 1) {
        chordSounds.add(SoundKey.values[i]);
      }
    }

    return chordSounds.every((soundKey) => soundKeys.contains(soundKey));
  }

  /// List<int> -> Chord
  static Chord fromBytes(dynamic bytes) {
    if (bytes == null) {
      return null;
    }
    final casted = (bytes as List).cast<int>();

    return Chord(Uint8List.fromList(casted));
  }
}
