import 'package:flutter/material.dart';
import 'package:testing/components/body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.settings_accessibility),
        onPressed: () {},
      ),
      title: const Text('MovieTV'),
      actions: <Widget>[
        IconButton(onPressed: (){},
            icon: const Icon(Icons.search))
      ],
    );
  }
}
