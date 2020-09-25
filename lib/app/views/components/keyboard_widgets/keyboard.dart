import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/play_button_a.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/play_button_b.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/play_button_c.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/data/util_classes/audio_controller.dart';
import 'package:sky_score_generator/data/util_classes/sound_path.dart';

class KeyBoard extends StatefulWidget {
  KeyBoard({
    @required this.chord,
    @required this.instrument,
    @required this.buttonSize,
    @required this.paddingSize,
    this.onPlayed,
  });

  final Chord chord;
  final Instrument instrument;
  final double buttonSize;
  final double paddingSize;
  final ValueChanged<SoundKey> onPlayed;

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _btnA(context, SoundKey.c_1),
              _btnB(context, SoundKey.d_1),
              _btnC(context, SoundKey.e_1),
              _btnB(context, SoundKey.f_1),
              _btnC(context, SoundKey.g_1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _btnC(context, SoundKey.a_1),
              _btnB(context, SoundKey.b_1),
              _btnA(context, SoundKey.c_2),
              _btnB(context, SoundKey.d_2),
              _btnC(context, SoundKey.e_2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _btnC(context, SoundKey.f_2),
              _btnB(context, SoundKey.g_2),
              _btnC(context, SoundKey.a_2),
              _btnB(context, SoundKey.b_2),
              _btnA(context, SoundKey.c_3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btnA(
    BuildContext context,
    SoundKey soundKey,
  ) {
    return PlayButtonA(
      buttonSize: widget.buttonSize,
      paddingSize: widget.paddingSize,
      isSelected: widget.chord.isEnabled(soundKey),
      onPressed: () => _playSound(context, widget.instrument, soundKey),
    );
  }

  Widget _btnB(BuildContext context, SoundKey soundKey) {
    return PlayButtonB(
      buttonSize: widget.buttonSize,
      paddingSize: widget.paddingSize,
      isSelected: widget.chord.isEnabled(soundKey),
      onPressed: () => _playSound(context, widget.instrument, soundKey),
    );
  }

  Widget _btnC(BuildContext context, SoundKey soundKey) {
    return PlayButtonC(
      buttonSize: widget.buttonSize,
      paddingSize: widget.paddingSize,
      isSelected: widget.chord.isEnabled(soundKey),
      onPressed: () => _playSound(context, widget.instrument, soundKey),
    );
  }

  Future<void> _playSound(
    BuildContext context,
    Instrument instrument,
    SoundKey soundKey,
  ) async {
    final path = SoundPath.getPath(instrument, soundKey);

    await AudioController.play(path);

    if (widget.onPlayed != null) {
      widget.onPlayed(soundKey);
    }
  }
}
