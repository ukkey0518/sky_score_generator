import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({
    @required this.title,
    @required this.onConfirmed,
    this.desc,
  });

  final String title;
  final String desc;
  final ValueChanged<bool> onConfirmed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: desc != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              margin: const EdgeInsets.all(4.0),
              child: Text(
                desc,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark, fontSize: 14.0),
              ),
            )
          : Container(),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(false);
          },
        ),
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(true);
          },
        ),
      ],
    );
  }
}
