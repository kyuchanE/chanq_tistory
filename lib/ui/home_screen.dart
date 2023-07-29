import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:chanq_tistory_project/controller/navigator_controller.dart';
import 'package:chanq_tistory_project/model/RandomUserData.dart';
import 'package:chanq_tistory_project/repository/tistory_repository.dart';
import 'package:chanq_tistory_project/ui/home_item_detail_page.dart';
import 'package:chanq_tistory_project/ui/main_page.dart';
import 'package:chanq_tistory_project/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO chan: How to initial list item
    return Scaffold(
      // TODO chan: need AppBar Design
      appBar: AppBar(
        title: const Text('home screen'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context
                  .read<NavigatorController>()
                  .add(SwitchNavigatorEvent(pageName: SearchPage.pageName));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        shadowColor: Colors.redAccent,
      ),
      body: const TistoryListWidget(),
    );
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
            itemCount:
                state.data.results != null ? state.data.results!.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: state.data.results != null
                    ? TistoryListItemWidget(
                        state.data.results![index],
                      )
                    : const TistoryListWidget(),
              );
            },
          ),
        );
      },
    );
  }
}

/// Home Main Data List Item Widget
class TistoryListItemWidget extends StatelessWidget {
  Results? itemData;
  TistoryListItemWidget(this.itemData, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigatorController>()
            .add(SwitchNavigatorEvent(pageName: HomeItemDetailPage.pageName));
        print("GestureDetector item : $itemData");
      },
      child: Row(
        children: itemData != null
            ? [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    itemData!.picture!.medium!,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(itemData!.email!),
                ),
              ]
            : [],
      ),
    );
  }
}
