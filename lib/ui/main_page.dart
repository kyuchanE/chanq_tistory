import 'package:chanq_tistory_project/components/image_data.dart';
import 'package:chanq_tistory_project/controller/bottom_nav_controller.dart';
import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:chanq_tistory_project/repository/tistory_repository.dart';
import 'package:chanq_tistory_project/ui/home_screen.dart';
import 'package:chanq_tistory_project/ui/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends Page {
  static const pageName = "MAIN_PAGE";

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      // TODO chan: settings???
      settings: this,
      builder: (context) => const MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TistoryRepository(),
      child: BlocProvider(
        create: (context) => HomeListController(
          context.read<TistoryRepository>(),
        ),
        child: BottomNavWidget(),
      ),
    );
  }
}

class BottomNavWidget extends StatelessWidget {
  final List<Widget> _screenList = <Widget>[
    const HomeScreen(),
    const SettingScreen(),
  ];
  BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavController, BottomNavState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: _screenList.elementAt(state.navState),
        bottomNavigationBar: BottomNavigationBar(
          // TODO: How to delete BottomNavigationBar ripple effects.
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: state.navState,
          onTap: (value) {
            context
                .read<BottomNavController>()
                .add(ChangeBottomStateEvent(state: value));
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.homeOff),
              activeIcon: ImageData(IconsPath.homeOn),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.homeOff),
              activeIcon: ImageData(IconsPath.homeOn),
              label: 'setting',
            ),
          ],
        ),
      );
    });
  }
}
