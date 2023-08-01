import 'package:chanq_tistory_project/model/random_user_data.dart';
import 'package:equatable/equatable.dart';

class HomeListStateData extends Equatable {
  RandomUserData? userData;
  bool isLoading = false;
  int page = 0;

  HomeListStateData({this.userData, this.isLoading = false, this.page = 0});

  @override
  List<Object?> get props => [userData, isLoading, page];
}
