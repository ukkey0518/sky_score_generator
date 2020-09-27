import 'package:flutter/material.dart';

void unFocusAll() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}
