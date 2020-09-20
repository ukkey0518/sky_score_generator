import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/models/model_classes/score.dart';
import 'package:sky_score_generator/app/views/components/keyboard_widgets/keyboard.dart';
import 'package:sky_score_generator/data/constants.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({@required this.score});

  final Score score;

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final instrument = Instrument.PIANO;
  final paddingSize = 8.0;
  final size = 60.0;

  int _currentIndex = 0;

  List<Chord> _chords = [];

  List<SoundKey> _inputtedKeys = [];

  @override
  void initState() {
    super.initState();
    _chords = widget.score.chords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: KeyBoard(
                  chord: _chords[_currentIndex],
                  instrument: instrument,
                  height: double.infinity,
                  width: double.infinity,
                  buttonSize: size,
                  paddingSize: paddingSize,
                  onPlayed: _inputKey,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(_chords[_currentIndex].toSoundKeys().toString()),
                    Text(_inputtedKeys.toString()),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _inputKey(SoundKey soundKey) {
    setState(() {
      _inputtedKeys.add(soundKey);
    });

    if (_chords[_currentIndex].allMatch(_inputtedKeys)) {
      setState(() {
        if (_chords.length - 1 <= _currentIndex) {
          Navigator.pop(context);
          return;
        }
        _inputtedKeys.clear();
        _currentIndex++;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _inputtedKeys.remove(soundKey);
        });
      });
    }
  }
}
