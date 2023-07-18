import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:chanq_tistory_project/repository/tistory_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO chan: How to initial list item
    return RepositoryProvider(
        create: (context) => TistoryRepository(),
        child: BlocProvider(
          create: (context) =>
              HomeListController(context.read<TistoryRepository>()),
          child: Scaffold(
            // TODO chan: need AppBar Design
            appBar: AppBar(
              title: const Text('home screen'),
              shadowColor: Colors.redAccent,
            ),
            body: const TistoryListWidget(),
          ),
        ));
  }
}

/// Home Main Data List Widget
class TistoryListWidget extends StatelessWidget {
  const TistoryListWidget({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.only(top: 10),
                  child: TistoryListItemWidget(
                    itemData: state.listData[index],
                  ));
            },
          ),
        );
      },
    );
  }
}

/// Home Main Data List Item Widget
class TistoryListItemWidget extends StatelessWidget {
  String itemData;
  TistoryListItemWidget({this.itemData = '', super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("GestureDetector item : $itemData");
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.amberAccent,
              height: 80,
              width: 80,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(itemData),
          ),
        ],
      ),
    );
  }
}
