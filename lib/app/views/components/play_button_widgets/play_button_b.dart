import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/parts/background_part.dart';
import 'package:sky_score_generator/app/views/components/play_button_widgets/parts/rhombus_part.dart';

class PlayButtonB extends StatefulWidget {
  PlayButtonB({
    @required this.buttonSize,
    @required this.paddingSize,
    @required this.onPressed,
    @required this.isSelected,
  });

  final double buttonSize;
  final double paddingSize;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  _PlayButtonBState createState() => _PlayButtonBState();
}

class _PlayButtonBState extends State<PlayButtonB> {
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
              RhombusPart(
                size: _buttonSize * 0.5,
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
