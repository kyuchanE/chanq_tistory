import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:chanq_tistory_project/controller/navigator_controller.dart';
import 'package:chanq_tistory_project/model/random_user_data.dart';
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
      body: TistoryListWidget(),
    );
  }
}

/// Home Main Data List Widget
class TistoryListWidget extends StatelessWidget {
  ScrollController scrollController = ScrollController();
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
            controller: scrollController
              ..addListener(() {
                if (scrollController.position.maxScrollExtent - 200 <=
                        scrollController.offset &&
                    !scrollController.position.outOfRange &&
                    !state.data.isLoading) {
                  context
                      .read<HomeListController>()
                      .add(ReqHomeListDataEvent());
                }
              }),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: state.data.userData != null
                ? state.data.userData!.results!.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: state.data.userData != null
                    ? TistoryListItemWidget(
                        state.data.userData!.results![index],
                      )
                    : Container(),
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

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child, Key? key})
      : super(key: key);

  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
