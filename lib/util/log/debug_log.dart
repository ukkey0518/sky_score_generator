import 'package:flutter/material.dart';
import 'package:sky_score_generator/data/constants.dart';

class DebugLog extends Iterable {
  DebugLog._();

  static final List<String> _logs = [];

  static List<String> get logs => List<String>.from(_logs);

  static int get limit => 20;

  static void add({
    @required DebugLabel label,
    @required String name,
    Map<String, dynamic> args,
  }) {
    final labelText = _getLabelText(label);
    final nameText = name;
    final argsText = _getArgsText(args);

    final logText = '[$labelText] $nameText($argsText)';

    _logs.add(logText);

    if (_logs.length > limit) {
      final overflowLength = _logs.length - limit;
      _logs.removeRange(0, overflowLength);
      print('delete, ${_logs.length}');
    }
    print(logText);
  }

  static String _getLabelText(DebugLabel label) {
    var labelText;
    switch (label) {
      case DebugLabel.MANAGER:
        labelText = 'Manager';
        break;
      case DebugLabel.REPOSITORY:
        labelText = 'Rep';
        break;
      case DebugLabel.VIEW_MODEL:
        labelText = 'VM';
        break;
      case DebugLabel.VIEW:
        labelText = 'View';
        break;
      case DebugLabel.PROCESS:
        labelText = 'Process';
        break;
    }
    return labelText;
  }

  static String _getArgsText(Map<String, dynamic> args) {
    if (args == null || args.isEmpty) {
      return '';
    }

    final argsList = <String>[];

    final entries = args.entries;
    entries.forEach((entry) {
      argsList.add('${entry.key}: ${entry.value}');
    });
    return argsList.join(',');
  }

  @override
  Iterator get iterator => _logs.iterator;
}
