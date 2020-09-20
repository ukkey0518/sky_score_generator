import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/parts/background_part.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/parts/circle_part.dart';

class PlayButtonC extends StatefulWidget {
  PlayButtonC({
    @required this.buttonSize,
    @required this.paddingSize,
    @required this.isSelected,
    @required this.onPressed,
  });

  final double buttonSize;
  final double paddingSize;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  _PlayButtonCState createState() => _PlayButtonCState();
}

class _PlayButtonCState extends State<PlayButtonC> {
  final _borderColor = Colors.yellow[200];

  final Duration _forwardDuration = const Duration(milliseconds: 10);
  final Duration _reverseDuration = const Duration(milliseconds: 80);

  double _buttonSize = 0.0;
  Duration _duration;

  @override
  void initState() {
    _buttonSize = widget.buttonSize;
    _duration = _forwardDuration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.paddingSize),
      child: SizedBox(
        width: widget.buttonSize,
        height: widget.buttonSize,
        child: GestureDetector(
          onTapDown: (_) {
            widget.onPressed();
            setState(() {
              _buttonSize = widget.buttonSize * 0.8;
              _duration = _forwardDuration;
            });
          },
          onTapUp: (_) {
            setState(() {
              _buttonSize = widget.buttonSize;
              _duration = _reverseDuration;
            });
          },
          onTapCancel: () {
            setState(() {
              _buttonSize = widget.buttonSize;
              _duration = _reverseDuration;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              BackgroundPart(
                size: _buttonSize,
                backgroundColor:
                    widget.isSelected ? Colors.deepOrange : Colors.black38,
                duration: _duration,
              ),
              CirclePart(
                size: _buttonSize * 0.6,
                color: _borderColor,
                duration: _duration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
