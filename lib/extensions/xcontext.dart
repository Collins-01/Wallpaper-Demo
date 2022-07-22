import 'package:flutter/material.dart';

extension XContext on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWith => MediaQuery.of(this).size.width;
}
