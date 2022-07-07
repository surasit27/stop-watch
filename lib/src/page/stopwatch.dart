import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/src/bloc/stop_bloc/stop_bloc.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Duration duration = const Duration();
  Timer? timer;
  static const countdownDuration = Duration();

  bool isRunTime = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (isRunTime) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(milliseconds: 1), (_) => addTime());
  }

  void addTime() {
    final addmilliseconds = isRunTime ? 1 : 1;
    setState(() {
      final milliseconds = duration.inMilliseconds + addmilliseconds;
      duration = Duration(milliseconds: milliseconds);
    });
    //final addSecons = isCountdown ? -1 : 1;
    // final addSecons = isRunTime ? 1 : 1;
    // setState(() {
    //   final seconds = duration.inSeconds + addSecons;
    //   if (seconds < 0) {
    //     timer?.cancel();
    //   } else {
    //     duration = Duration(seconds: seconds);
    //   }
    // });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_timerBuild(), _buildStart()],
        ),
      ),
    );
  }

  Widget _buildStart() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (isRunning) {
                    stopTimer(resets: false);
                  } else {
                    startTimer(resets: false);
                  }
                },
                style: TextButton.styleFrom(primary: Colors.black),
                child: isRunning
                    ? const Text(
                        'STOP',
                        style: TextStyle(fontSize: 20),
                      )
                    : const Text(
                        'RESUME',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
              TextButton(
                onPressed:
                    //() => context.read<TimerBloc>().add(TimerEventStop())
                    stopTimer,
                style: TextButton.styleFrom(primary: Colors.black),
                child: const Text(
                  'RESET',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )
        : TextButton(
            onPressed: () {
              startTimer();
            },
            style: TextButton.styleFrom(primary: Colors.black),
            child: const Text(
              'START',
              style: TextStyle(fontSize: 20),
            ),
          );
  }

  Widget _timerBuild() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(duration.inMilliseconds.remainder(60));
    return BlocBuilder<StopBloc, StopState>(
      builder: (context, state) {
        return Text(
          ' $seconds s : $milliseconds',
          style: const TextStyle(
            fontSize: 70,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
