import 'package:chanq_tistory_project/controller/bottom_nav_controller.dart';
import 'package:chanq_tistory_project/controller/navigator_controller.dart';
import 'package:chanq_tistory_project/ui/home_item_detail_page.dart';
import 'package:chanq_tistory_project/ui/main_page.dart';
import 'package:chanq_tistory_project/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // TODO chan: Navigator 2.0?
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO chan: switch MaterialApp/CupertinoApp
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const App(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomNavController(),
          ),
          BlocProvider(
            create: (context) => NavigatorController(),
          )
        ],
        child: BlocBuilder<NavigatorController, SwitchNavigatorState>(
          builder: (context, state) {
            return Navigator(
              pages: [
                MainPage(),
                if (state.statePageName == HomeItemDetailPage.pageName)
                  HomeItemDetailPage(),
                if (state.statePageName == SearchPage.pageName) SearchPage(),
              ],
              // TODO chan: onPopPage ???
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                } else {
                  return true;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
