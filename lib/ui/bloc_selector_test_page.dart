import 'package:chanq_tistory_project/controller/BottomNavController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocSelectorPage extends StatelessWidget {
  const BlocSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavController(),
      child: SamplePage(),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<BottomNavController, BlocSelectorState, bool>(
              selector: (state) => state.changeState,
              builder: (context, state) {
                return Icon(
                  Icons.favorite,
                  color: state ? Colors.red : Colors.grey,
                  size: 50,
                );
              },
            ),
            BlocBuilder<BottomNavController, BlocSelectorState>(
              builder: (context, state) {
                return Text(
                  state.value.toString(),
                  style: const TextStyle(fontSize: 70),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<BottomNavController>()
                        .add(ChangeStateEvent(state: true));
                  },
                  child: Text('True'),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<BottomNavController>()
                        .add(ChangeStateEvent(state: false));
                  },
                  child: Text('False'),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<BottomNavController>().add(ValueEvent());
                  },
                  child: Text('더하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
