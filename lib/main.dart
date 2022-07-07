import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/src/app_route.dart';
import 'package:stopwatch/src/bloc/app_bloc_observer.dart';
import 'package:stopwatch/src/bloc/stop_bloc/stop_bloc.dart';
import 'package:stopwatch/src/bloc/timer_bloc/timer_bloc.dart';
import 'package:stopwatch/src/page/home.dart';

void main() {
  // runApp(const MyApp());
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final timerBloc =
        BlocProvider<TimerBloc>(create: ((context) => TimerBloc()));
    final stopBloc = BlocProvider<StopBloc>(create: ((context) => StopBloc()));

    return MultiBlocProvider(
      providers: [timerBloc, stopBloc],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: AppRoute().getAll,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const MyHomePage(title: 'TIMER'),
      ),
    );
  }
}
