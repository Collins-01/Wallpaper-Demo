import 'package:flutter/material.dart';

class NavigationService {
  final _navigationKey = GlobalKey();
  NavigationService._();
  static final _instance = NavigationService._();
  static NavigationService get instance => _instance;
}
