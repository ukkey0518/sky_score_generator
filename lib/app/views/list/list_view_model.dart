import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/repositories/score_repository.dart';
import 'package:sky_score_generator/data/constants.dart';

class ListViewModel extends ChangeNotifier {
  ListViewModel({@required this.sRep});

  final ScoreRepository sRep;

  List<Score> _scores = [
    Score(
      id: '12345',
      title: '楽譜タイトル',
      chords: [
        Chord.fromSoundKeys([
          SoundKey.f_1,
        ]),
        Chord.fromSoundKeys([
          SoundKey.a_1,
        ]),
        Chord.fromSoundKeys([
          SoundKey.c_2,
        ]),
        Chord.fromSoundKeys([
          SoundKey.c_2,
          SoundKey.e_2,
        ]),
        Chord.fromSoundKeys([
          SoundKey.a_2,
        ]),
        Chord.fromSoundKeys([
          SoundKey.e_2,
        ]),
        Chord.fromSoundKeys([
          SoundKey.e_1,
          SoundKey.d_2,
        ]),
      ],
      createdAt: DateTime.now(),
    ),
  ];

  List<Score> get scores => _scores;
}
