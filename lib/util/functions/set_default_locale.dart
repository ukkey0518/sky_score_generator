import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void setDefaultLocale(String localeString) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    Intl.defaultLocale = localeString;
    // 以下メソッドのインポート先間違えやすいので注意(package:intl/date_symbol_data_local.dart)
    await initializeDateFormatting(localeString);
  });
}
