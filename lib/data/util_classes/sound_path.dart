import 'package:sky_score_generator/data/constants.dart';

class SoundPath {
  SoundPath._();

  static List<String> fileNames = const [
    'piano_c_1.mp3',
    'piano_d_1.mp3',
    'piano_e_1.mp3',
    'piano_f_1.mp3',
    'piano_g_1.mp3',
    'piano_a_1.mp3',
    'piano_b_1.mp3',
    'piano_c_2.mp3',
    'piano_d_2.mp3',
    'piano_e_2.mp3',
    'piano_f_2.mp3',
    'piano_g_2.mp3',
    'piano_a_2.mp3',
    'piano_b_2.mp3',
    'piano_c_3.mp3',
  ];

  static String getPath(Instrument instrument, SoundKey soundKey) {
    var insText;
    switch (instrument) {
      case Instrument.PIANO:
        insText = 'piano';
        break;
    }

    var keyText;
    switch (soundKey) {
      case SoundKey.c_1:
        keyText = 'c_1';
        break;
      case SoundKey.d_1:
        keyText = 'd_1';
        break;
      case SoundKey.e_1:
        keyText = 'e_1';
        break;
      case SoundKey.f_1:
        keyText = 'f_1';
        break;
      case SoundKey.g_1:
        keyText = 'g_1';
        break;
      case SoundKey.a_1:
        keyText = 'a_1';
        break;
      case SoundKey.b_1:
        keyText = 'b_1';
        break;
      case SoundKey.c_2:
        keyText = 'c_2';
        break;
      case SoundKey.d_2:
        keyText = 'd_2';
        break;
      case SoundKey.e_2:
        keyText = 'e_2';
        break;
      case SoundKey.f_2:
        keyText = 'f_2';
        break;
      case SoundKey.g_2:
        keyText = 'g_2';
        break;
      case SoundKey.a_2:
        keyText = 'a_2';
        break;
      case SoundKey.b_2:
        keyText = 'b_2';
        break;
      case SoundKey.c_3:
        keyText = 'c_3';
        break;
      default:
        keyText = 'c_1';
    }

    return insText + '_' + keyText + '.mp3';
  }
}
