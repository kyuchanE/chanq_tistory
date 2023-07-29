import 'package:chanq_tistory_project/controller/navigator_controller.dart';
import 'package:chanq_tistory_project/repository/tistory_repository.dart';
import 'package:chanq_tistory_project/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/RandomUserData.dart';

class SearchPage extends Page {
  static const pageName = 'SEARCH_PAGE';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => SearchWidget(),
    );
  }
}

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  TistoryRepository repository = TistoryRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorController, SwitchNavigatorState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            // context
            //     .read<NavigatorController>()
            //     .add(SwitchNavigatorEvent(pageName: MainPage.pageName));
            RandomUserData data = await repository.reqRandomUserData();
          },
          child: Container(
            color: Colors.deepPurple[200],
          ),
        );
      },
    );
  }
}
