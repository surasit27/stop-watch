import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(const TimerState(minutes: 0)) {
    //Start Timer
    on<TimerEventStart>((event, emit) {});

    //Stop Timer
    on<TimerEventStop>((event, emit) {});

    //Resume Timer
    on<TimerEventResume>((event, emit) {});

    //Start Reset
    on<TimerEventReset>((event, emit) {});
  }
}
