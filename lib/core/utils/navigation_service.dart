import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

   static final currentContext = scaffoldKey.currentContext;   
}
