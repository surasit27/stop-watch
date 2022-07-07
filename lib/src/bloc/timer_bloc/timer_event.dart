part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TimerEventStart extends TimerEvent {}
class TimerEventStop extends TimerEvent {}
class TimerEventResume extends TimerEvent {}
class TimerEventReset extends TimerEvent {}
