import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:chanq_tistory_project/repository/tistory_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: How to init Bloc HomeListData.
    return RepositoryProvider(
        create: (context) => TistoryRepository(),
        child: BlocProvider(
          create: (context) =>
              HomeListController(context.read<TistoryRepository>()),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('home screen'),
              shadowColor: Colors.redAccent,
            ),
            body: TistoryListWidget(),
          ),
        ));
  }
}

class TistoryListWidget extends StatelessWidget {
  TistoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListController, HomeListState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeListController>().add(ReqHomeListDataEvent());
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Text('My Data : ${state.listData[index]}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
