import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';

class MiniChordCard extends StatelessWidget {
  MiniChordCard({
    @required this.number,
    @required this.chord,
    @required this.isCurrent,
    @required this.onTap,
    @required this.onLongPress,
    @required this.onInsertRight,
  });

  final int number;
  final Chord chord;
  final bool isCurrent;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onInsertRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              width: 120,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: isCurrent ? Colors.deepOrange : Colors.white,
                  width: 2,
                ),
                color: Colors.white54,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$number',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _miniKey(byte: chord.chord[0]),
                          _miniKey(byte: chord.chord[1]),
                          _miniKey(byte: chord.chord[2]),
                          _miniKey(byte: chord.chord[3]),
                          _miniKey(byte: chord.chord[4]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _miniKey(byte: chord.chord[5]),
                          _miniKey(byte: chord.chord[6]),
                          _miniKey(byte: chord.chord[7]),
                          _miniKey(byte: chord.chord[8]),
                          _miniKey(byte: chord.chord[9]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _miniKey(byte: chord.chord[10]),
                          _miniKey(byte: chord.chord[11]),
                          _miniKey(byte: chord.chord[12]),
                          _miniKey(byte: chord.chord[13]),
                          _miniKey(byte: chord.chord[14]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            child: Icon(Ionicons.ios_add_circle, color: Colors.white),
            onTap: onInsertRight,
          ),
        ),
      ],
    );
  }

  Widget _miniKey({@required int byte}) {
    return Container(
      child: Icon(
        FontAwesome.square,
        size: 15,
        color: byte == 1 ? Colors.deepOrange : Colors.black38,
      ),
    );
  }
}
