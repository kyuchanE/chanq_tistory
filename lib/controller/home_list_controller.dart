import 'package:bloc/bloc.dart';
import 'package:chanq_tistory_project/model/random_user_data.dart';
import 'package:equatable/equatable.dart';
import '../model/home_list_state_data.dart';
import '../repository/tistory_repository.dart';

class HomeListController extends Bloc<HomeListEvent, HomeListState> {
  final TistoryRepository _tistoryRepository;

  HomeListController(this._tistoryRepository) : super(HomeListState()) {
    on<ReqHomeListDataEvent>((event, emit) async {
      state.data.isLoading = true;
      state.data.page++;
      var result = await _tistoryRepository.reqRandomUserData();
      emit(state.emitData(result));
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
  HomeListStateData data = HomeListStateData();

  HomeListState();

  HomeListState emitData(RandomUserData responseData) {
    if (data.userData != null) {
      List<Results>? resultsData = data.userData!.results;
      if (resultsData == null) {
        data.userData!.results = responseData.results;
      } else {
        if (responseData.results != null) {
          resultsData.addAll(responseData.results!.toList());
          data.userData!.results = resultsData;
        }
      }
    } else {
      data.userData = responseData;
    }
    data.isLoading = false;
    return this;
  }

  @override
  List<Object?> get props => [data];
}
