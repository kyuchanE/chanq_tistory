import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigatorController
    extends Bloc<SwitchNavigatorEvent, SwitchNavigatorState> {
  NavigatorController() : super(SwitchNavigatorState()) {
    on<SwitchNavigatorEvent>((event, emit) {
      emit(SwitchNavigatorState(statePageName: event.pageName));
    });
  }

  @override
  void onTransition(
      Transition<SwitchNavigatorEvent, SwitchNavigatorState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

abstract class NavigatorEvent {}

class SwitchNavigatorEvent extends NavigatorEvent {
  String pageName = "";
  SwitchNavigatorEvent({this.pageName = ""});
}

class SwitchNavigatorState extends Equatable {
  String statePageName = "";
  SwitchNavigatorState({this.statePageName = ""});

  @override
  List<Object?> get props => [statePageName];
}
