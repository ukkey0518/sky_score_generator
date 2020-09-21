import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleNameSetDialog extends StatelessWidget {
  TitleNameSetDialog({@required this.onConfirmed});

  final ValueChanged<String> onConfirmed;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool errorFlag = false;
    return StatefulBuilder(
      builder: (context, setState) {
        print('asdf');
        return Container(
          constraints: BoxConstraints(minHeight: 400),
          child: AlertDialog(
            title: const Text('楽譜名の設定'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: _controller,
                  maxLines: 1,
                ),
                if (errorFlag)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '必須入力',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'キャンセル',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  '保存',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    print('empty');
                    setState(() {
                      errorFlag = true;
                    });
                  } else {
                    Navigator.pop(context);
                    onConfirmed(_controller.text);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
