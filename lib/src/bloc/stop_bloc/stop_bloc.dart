import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stop_event.dart';
part 'stop_state.dart';

class StopBloc extends Bloc<StopEvent, StopState> {
  StopBloc() : super(StopInitial()) {
    on<StopEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
