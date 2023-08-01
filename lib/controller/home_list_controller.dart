import 'package:bloc/bloc.dart';
import 'package:chanq_tistory_project/model/random_user_data.dart';
import 'package:equatable/equatable.dart';
import '../model/home_list_state_data.dart';
import '../repository/tistory_repository.dart';

class HomeListController extends Bloc<HomeListEvent, HomeListState> {
  final TistoryRepository _tistoryRepository;

  HomeListController(this._tistoryRepository) : super(HomeListState()) {
    on<ReqHomeListDataEvent>((event, emit) async {
      var result = await _tistoryRepository.reqRandomUserData();

      if (state.data.userData != null) {
        List<Results>? resultsData = state.data.userData!.results;
        if (resultsData != null) {
          if (result.results != null) {
            resultsData.addAll(result.results!.toList());
            result.results = resultsData;
          }
        }
      }

      emit(
          HomeListState.clone(result, loading: false, page: state.data.page++));
    });

    on<LoadingHomeListDataEvent>((event, emit) {
      if (state.data.userData != null) {
        emit(HomeListState.clone(state.data.userData!,
            loading: true, page: state.data.page++));
      }
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

class LoadingHomeListDataEvent extends HomeListEvent {
  LoadingHomeListDataEvent();
}

class HomeListState extends Equatable {
  HomeListStateData data = HomeListStateData();

  HomeListState();
  HomeListState.clone(RandomUserData userData,
      {bool loading = false, int page = 0}) {
    data =
        HomeListStateData(userData: userData, isLoading: loading, page: page);
  }

  HomeListState emitIsLoading(bool loadingState) {
    data.isLoading = true;
    return this;
  }

  HomeListState emitData(RandomUserData responseData) {
    return this;
  }

  @override
  List<Object?> get props => [data];
}
