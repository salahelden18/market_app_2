import 'package:flutter/material.dart';

class MyRouteObserver extends RouteObserver {
  static final List<Route> _stack = []; // Internal list to track page stack

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _stack.add(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _stack.remove(route);
  }

  static bool containsPage(String key) => // Method to check for a specific page
      _stack.any((route) => route.settings.name == key);
}
