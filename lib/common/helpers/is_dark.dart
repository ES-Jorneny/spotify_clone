
import 'package:flutter/material.dart';

extension IsDark on BuildContext{
  bool get isDarkMode{
    return Theme.of(this).brightness ==Brightness.dark;
  }
}