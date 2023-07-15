import 'package:chanq_tistory_project/components/image_data.dart';
import 'package:chanq_tistory_project/controller/bottom_nav_controller.dart';
import 'package:chanq_tistory_project/ui/home_screen.dart';
import 'package:chanq_tistory_project/ui/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<Widget> _screenList = <Widget>[
  HomeScreen(),
  SettingScreen(),
];

class App extends StatelessWidget {
  const App({super.key});

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
      },
    );
  }
}
