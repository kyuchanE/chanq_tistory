import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/tistory_repository.dart';

class HomeListController extends Bloc<HomeListEvent, HomeListState> {
  TistoryRepository _tistoryRepository;
  HomeListController(this._tistoryRepository) : super(HomeListState()) {
    on<ReqHomeListDataEvent>((event, emit) async {
      var result = await _tistoryRepository.reqTistoryData();
      emit(HomeListState(listData: result));
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
  List<String> listData = [];
  HomeListState({this.listData = const []});

  HomeListState clone({List<String>? listData}) =>
      HomeListState(listData: listData ?? this.listData);

  @override
  List<Object?> get props => [listData];
}
