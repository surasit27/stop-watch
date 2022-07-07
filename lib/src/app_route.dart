import 'package:flutter/cupertino.dart';
import 'package:stopwatch/src/page/home.dart';
import 'package:stopwatch/src/page/stopwatch.dart';

class AppRoute {
  static const home = 'home';
  static const stopwatch = 'stopwatch';

  final _route = <String, WidgetBuilder>{
    home: (context) => const MyHomePage(title: "TIMER"),
    stopwatch: (context) => const StopWatch(title: "STOP WATCH"),
  };

  get getAll => _route;
}
