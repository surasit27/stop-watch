part of 'timer_bloc.dart';

class TimerState extends Equatable {
  final minutes;
  const TimerState({required this.minutes});

  @override
  String toString() {
    return "minutes: $minutes";
  }

  @override
  List<Object> get props => [minutes];
}
