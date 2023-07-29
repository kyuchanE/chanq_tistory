import 'package:bloc/bloc.dart';
import 'package:chanq_tistory_project/model/RandomUserData.dart';
import 'package:equatable/equatable.dart';
import '../repository/tistory_repository.dart';

class HomeListController extends Bloc<HomeListEvent, HomeListState> {
  TistoryRepository _tistoryRepository;
  HomeListController(this._tistoryRepository)
      : super(HomeListState(RandomUserData(null, null))) {
    on<ReqHomeListDataEvent>((event, emit) async {
      var result = await _tistoryRepository.reqRandomUserData();
      emit(HomeListState(result));
    });
  }

  @override
  void onTransition(Transition<HomeListEvent, HomeListState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

abstract class HomeListEvent {}

class ReqHomeListDataEvent extends HomeListEvent {
  ReqHomeListDataEvent();
}

class HomeListState extends Equatable {
  RandomUserData data = RandomUserData(null, null);
  HomeListState(this.data);

  HomeListState clone({RandomUserData? data}) =>
      HomeListState(data ?? this.data);

  @override
  List<Object?> get props => [data];
}
