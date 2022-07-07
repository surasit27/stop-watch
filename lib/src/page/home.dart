import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration duration = const Duration();
  Timer? timer;
  static const countdownDuration = Duration(minutes: 5);

  bool isCountdown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSecons = isCountdown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSecons;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
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
                child: isRunning ? const Text('STOP') : const Text('RESUME'),
              ),
              TextButton(
                onPressed: stopTimer,
                style: TextButton.styleFrom(primary: Colors.black),
                child: const Text('RESET'),
              ),
            ],
          )
        : TextButton(
            onPressed: () {
              startTimer();
            },
            style: TextButton.styleFrom(primary: Colors.black),
            child: const Text(
              'Start',
            ),
          );
  }

  Widget _timerBuild() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
        fontSize: 80,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
