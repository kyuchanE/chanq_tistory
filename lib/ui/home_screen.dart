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
    return BlocBuilder<HomeListController, HomeListState>(
        builder: (context, state) {
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
        floatingActionButton: HomeScreenFAB(
          children: [],
        ),
        body: TistoryListWidget(isLoading: state.data.isLoading),
      );
    });
  }
}

/// Home Main Data List Widget
class TistoryListWidget extends StatefulWidget {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  TistoryListWidget({this.isLoading = false, Key? key}) : super(key: key);

  @override
  State<TistoryListWidget> createState() => _TistoryListWidgetState();
}

class _TistoryListWidgetState extends State<TistoryListWidget> {
  ScrollController _listScrollController(
          BuildContext context, HomeListState state) =>
      widget.scrollController
        ..addListener(() {
          if (widget.scrollController.position.maxScrollExtent <=
                  widget.scrollController.offset &&
              widget.scrollController.position.maxScrollExtent > 0 &&
              !widget.scrollController.position.outOfRange &&
              !widget.isLoading) {
            widget.isLoading = true;
            context.read<HomeListController>().add(LoadingHomeListDataEvent());
            context.read<HomeListController>().add(ReqHomeListDataEvent());
          }
        });

  @override
  void initState() {
    context.read<HomeListController>().add(ReqHomeListDataEvent());
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListController, HomeListState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeListController>().add(ReqHomeListDataEvent());
          },
          child: Scrollbar(
            controller: _listScrollController(context, state),
            child: ListView.builder(
              controller: _listScrollController(context, state),
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: state.data.userData != null
                  ? (state.data.isLoading
                      ? state.data.userData!.results!.length + 1
                      : state.data.userData!.results!.length)
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: state.data.userData != null
                      ? (index == state.data.userData!.results!.length
                          ? const LoadingWidget()
                          : TistoryListItemWidget(
                              state.data.userData!.results![index],
                            ))
                      : Container(),
                );
              },
            ),
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

//TODO chan need UI
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 40,
      height: 40,
    );
  }
}

class HomeScreenFAB extends StatefulWidget {
  bool? initExpanded;
  bool? initOpenMenu;
  List<Widget> children;

  HomeScreenFAB({
    Key? key,
    this.initExpanded,
    this.initOpenMenu,
    required this.children,
  });

  @override
  State<HomeScreenFAB> createState() => _HomeScreenFABState();
}

class _HomeScreenFABState extends State<HomeScreenFAB> {
  bool _isExpanded = true;
  bool _isOpenMenu = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initExpanded ?? true;
    _isOpenMenu = widget.initOpenMenu ?? false;
  }

  void toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void toggleOpenMenu() {
    setState(() {
      _isOpenMenu = !_isOpenMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _collapsedFab(),
        _expandedFab(),
      ],
    );
  }

  Widget _collapsedFab() {
    return GestureDetector(
      onTap: toggleExpanded,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _expandedFab() {
    return IgnorePointer(
      ignoring: !_isExpanded,
      child: AnimatedContainer(
        transformAlignment: Alignment.centerRight,
        transform: Matrix4.diagonal3Values(
          _isExpanded ? 1.0 : 0.2,
          1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: _isExpanded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          curve: const Interval(0.5, 1.0, curve: Curves.ease),
          child: GestureDetector(
            onTap: toggleExpanded,
            child: Container(
              width: 110,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(350),
              ),
              child: SizedBox.expand(
                child: AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text('Text'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
