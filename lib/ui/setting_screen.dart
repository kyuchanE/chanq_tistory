import 'package:chanq_tistory_project/components/default_dialog.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Center(
        child: TextButton(
          onPressed: () {
            showDefaultAlertDialog(
                context, 'Test Title', 'Hello Flutter World!!');
          },
          child: const Text('Show Dialog'),
        ),
      ),
    );
  }
}
