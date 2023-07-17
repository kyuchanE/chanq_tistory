import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class HomeListController extends Bloc<HomeListEvent, HomeListState> {
  HomeListController() : super(HomeListState()) {
    on<ReqHomeListDataEvent>((event, emit) {
      emit(state.clone(listData: event.listData));
    });
  }
}

abstract class HomeListEvent {}

class ReqHomeListDataEvent extends HomeListEvent {
  List<String>? listData = [];
  ReqHomeListDataEvent({this.listData});
}

class HomeListState extends Equatable {
  List<String>? listData = [];
  HomeListState({this.listData});

  HomeListState clone({List<String>? listData}) =>
      HomeListState(listData: listData ?? this.listData);

  @override
  List<Object?> get props => [listData];
}
