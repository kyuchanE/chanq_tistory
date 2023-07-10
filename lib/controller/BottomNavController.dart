import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavController extends Bloc<BottomNavEvent, BlocSelectorState> {
  BottomNavController() : super(BlocSelectorState()) {
    on<ChangeStateEvent>((event, emit) {
      emit(state.clone(changeState: event.state));
    });
    on<ValueEvent>((event, emit) {
      emit(state.clone(value: state.value + 1));
    });
  }
}

abstract class BottomNavEvent {}

class ChangeStateEvent extends BottomNavEvent {
  bool state;
  ChangeStateEvent({this.state = false});
}

class ValueEvent extends BottomNavEvent {}

class BlocSelectorState extends Equatable {
  final bool changeState;
  final int value;
  BlocSelectorState({this.changeState = false, this.value = 0});

  BlocSelectorState clone({
    bool? changeState,
    int? value,
  }) {
    return BlocSelectorState(
      changeState: changeState ?? this.changeState,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [changeState, value];
}
