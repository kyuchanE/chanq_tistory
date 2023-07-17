import 'package:chanq_tistory_project/controller/home_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];
final List<double> heights = <double>[150, 50, 850];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: How to init Bloc HomeListData.
    return BlocBuilder<HomeListController, HomeListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('home screen'),
            shadowColor: Colors.redAccent,
          ),
          body: ListView.builder(
            // TODO: ListView Scroll refresh
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: heights[index],
                color: Colors.amber[colorCodes[index]],
                child: Center(
                  child: Text('Entry!! ${entries[index]}'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
