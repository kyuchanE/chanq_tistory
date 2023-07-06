import 'package:chanq_tistory_project/components/image_data.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (value) {},
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
  }
}
