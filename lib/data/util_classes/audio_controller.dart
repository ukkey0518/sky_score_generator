import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void audioPlayerHandler(AudioPlayerState value) => print('state => $value');

class AudioController {
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioCache audioCache = AudioCache(prefix: 'assets/sounds/');

  /// ロード
  static Future<void> loadAll(List<String> fileNames) async {
    audioCache.loadAll(fileNames);
  }

  /// 再生
  static Future<void> play(String fileName, {double volume = 0.5}) async {
    if (Platform.isIOS) {
      audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
    }
    audioCache.play(
      fileName,
      mode: PlayerMode.LOW_LATENCY,
      volume: volume,
    );
  }
}
