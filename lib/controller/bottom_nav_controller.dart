import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavController extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavController() : super(BottomNavState()) {
    on<ChangeBottomStateEvent>((event, emit) {
      emit(state.clone(navState: event.state));
    });
  }
}

abstract class BottomNavEvent {}

class ChangeBottomStateEvent extends BottomNavEvent {
  int state;
  ChangeBottomStateEvent({this.state = 0});
}

class BottomNavState extends Equatable {
  final int navState;
  BottomNavState({this.navState = 0});

  BottomNavState clone({int? navState}) {
    return BottomNavState(navState: navState ?? this.navState);
  }

  @override
  List<Object?> get props => [navState];
}

enum BottomNavItem {
  main(0, "MAIN"),
  setting(1, "SETTING");

  final int code;
  final String title;
  const BottomNavItem(this.code, this.title);
}
