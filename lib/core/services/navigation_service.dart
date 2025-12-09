import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static final currentContext = key.currentContext!;
}
