import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sky_score_generator/data/constants.dart';

extension DateTimeExtensions on DateTime {
  // [変換] Timestamp => DateTime
  static DateTime fromTimestamp(Timestamp timestamp) {
    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
  }

  // [変換] DateTime -> Timestamp
  Timestamp toTimestamp() {
    return Timestamp.fromMillisecondsSinceEpoch(this.millisecondsSinceEpoch);
  }

  // [変換：DateTime -> 表示用日付文字列]
  String toFormatStr(DateFormatMode mode) {
    var dateStr;
    switch (mode) {
      case DateFormatMode.FULL:
        dateStr = DateFormat('yyyy年 M月 d日').format(this);
        break;
      case DateFormatMode.FULL_DOW:
        dateStr = DateFormat('yyyy年 M月 d日 (E)').format(this);
        break;
      case DateFormatMode.MEDIUM:
        dateStr = DateFormat('M月 d日').format(this);
        break;
      case DateFormatMode.MEDIUM_DOW:
        dateStr = DateFormat('M月 d日 (E)').format(this);
        break;
      case DateFormatMode.SHORT:
        dateStr = DateFormat('yyyy/M/d').format(this);
        break;
      case DateFormatMode.SHORT_DOW:
        dateStr = DateFormat('yyyy/M/d (E)').format(this);
        break;
    }
    return dateStr;
  }
}
